import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import '../models/user_model.dart';

/// Authentication Service
/// 
/// Handles all authentication operations including:
/// - Google Sign-In
/// - Apple Sign-In
/// - Email/Password authentication
/// - User profile management
/// - Identity merging
class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  /// Get current user stream
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  /// Get current user
  User? get currentUser => _auth.currentUser;

  // ============================================
  // 🔐 AUTHENTICATION METHODS
  // ============================================

  /// Sign in with Google
  Future<UserCredential?> signInWithGoogle() async {
    try {
      // Trigger Google Sign-In flow
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return null;

      // Obtain auth details
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase
      final userCredential = await _auth.signInWithCredential(credential);

      // Create or update user profile
      await _createOrUpdateUserProfile(
        userCredential.user!,
        isNewUser: userCredential.additionalUserInfo?.isNewUser ?? false,
      );

      return userCredential;
    } catch (e) {
      throw Exception('Google Sign-In failed: $e');
    }
  }

  /// Sign in with Apple
  Future<UserCredential?> signInWithApple() async {
    try {
      // Request Apple ID credential
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      // Create OAuth credential
      final oauthCredential = OAuthProvider('apple.com').credential(
        idToken: appleCredential.identityToken,
        accessToken: appleCredential.authorizationCode,
      );

      // Sign in to Firebase
      final userCredential = await _auth.signInWithCredential(oauthCredential);

      // Create or update user profile
      await _createOrUpdateUserProfile(
        userCredential.user!,
        isNewUser: userCredential.additionalUserInfo?.isNewUser ?? false,
        appleDisplayName: appleCredential.givenName != null &&
                appleCredential.familyName != null
            ? '${appleCredential.givenName} ${appleCredential.familyName}'
            : null,
      );

      return userCredential;
    } catch (e) {
      throw Exception('Apple Sign-In failed: $e');
    }
  }

  /// Register with Email and Password
  Future<UserCredential> registerWithEmail({
    required String email,
    required String password,
    required String displayName,
  }) async {
    try {
      // Create user
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Update display name
      await userCredential.user!.updateDisplayName(displayName);

      // Create user profile
      await _createOrUpdateUserProfile(
        userCredential.user!,
        isNewUser: true,
        customDisplayName: displayName,
      );

      return userCredential;
    } catch (e) {
      throw Exception('Registration failed: $e');
    }
  }

  /// Sign in with Email and Password
  Future<UserCredential> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Update profile if needed
      await _createOrUpdateUserProfile(
        userCredential.user!,
        isNewUser: false,
      );

      return userCredential;
    } catch (e) {
      throw Exception('Sign-In failed: $e');
    }
  }

  /// Sign out
  Future<void> signOut() async {
    await Future.wait([
      _auth.signOut(),
      _googleSignIn.signOut(),
    ]);
  }

  // ============================================
  // 👤 USER PROFILE MANAGEMENT
  // ============================================

  /// Create or update user profile in Firestore
  /// 
  /// Implements smart merge logic:
  /// - Don't overwrite existing data with empty values
  /// - Update photo/name from social providers if not custom
  Future<void> _createOrUpdateUserProfile(
    User user, {
    required bool isNewUser,
    String? customDisplayName,
    String? appleDisplayName,
  }) async {
    final userRef = _firestore.collection('users').doc(user.uid);
    final userDoc = await userRef.get();

    if (isNewUser || !userDoc.exists) {
      // Create new user profile
      final newUser = UserModel(
        id: user.uid,
        email: user.email ?? '',
        displayName: customDisplayName ??
            appleDisplayName ??
            user.displayName ??
            'User',
        photoUrl: user.photoURL,
        createdAt: DateTime.now(),
        isCustomName: customDisplayName != null,
        isCustomPhoto: false,
      );

      await userRef.set(newUser.toFirestore());
    } else {
      // Update existing user with smart merge
      final existingUser = UserModel.fromFirestore(userDoc);
      final updates = <String, dynamic>{};

      // Update photo if not custom and new photo available
      if (!existingUser.isCustomPhoto && user.photoURL != null) {
        updates['photoUrl'] = user.photoURL;
      }

      // Update display name if not custom and new name available
      if (!existingUser.isCustomName) {
        final newName = customDisplayName ??
            appleDisplayName ??
            user.displayName;
        if (newName != null && newName.isNotEmpty) {
          updates['displayName'] = newName;
        }
      }

      // Update email if changed
      if (user.email != null && user.email != existingUser.email) {
        updates['email'] = user.email;
      }

      if (updates.isNotEmpty) {
        await userRef.update(updates);
      }
    }
  }

  /// Get user profile
  Future<UserModel?> getUserProfile(String userId) async {
    try {
      final doc = await _firestore.collection('users').doc(userId).get();
      if (doc.exists) {
        return UserModel.fromFirestore(doc);
      }
      return null;
    } catch (e) {
      throw Exception('Failed to get user profile: $e');
    }
  }

  /// Get user profile stream
  Stream<UserModel?> getUserProfileStream(String userId) {
    return _firestore
        .collection('users')
        .doc(userId)
        .snapshots()
        .map((doc) => doc.exists ? UserModel.fromFirestore(doc) : null);
  }

  /// Update user profile
  Future<void> updateUserProfile({
    required String userId,
    String? displayName,
    String? photoUrl,
    String? bio,
    HomeLocation? homeLocation,
    bool? isCustomPhoto,
    bool? isCustomName,
  }) async {
    try {
      final updates = <String, dynamic>{};

      if (displayName != null) {
        updates['displayName'] = displayName;
        updates['isCustomName'] = true;
      }
      if (photoUrl != null) {
        updates['photoUrl'] = photoUrl;
        if (isCustomPhoto != null) {
          updates['isCustomPhoto'] = isCustomPhoto;
        }
      }
      if (bio != null) updates['bio'] = bio;
      if (homeLocation != null) updates['homeLocation'] = homeLocation.toMap();

      if (updates.isNotEmpty) {
        await _firestore.collection('users').doc(userId).update(updates);
      }
    } catch (e) {
      throw Exception('Failed to update profile: $e');
    }
  }

  /// Update user stats
  Future<void> updateUserStats({
    required String userId,
    required UserStats stats,
  }) async {
    try {
      await _firestore.collection('users').doc(userId).update({
        'stats': stats.toMap(),
        'lastMatchAt': Timestamp.now(),
      });
    } catch (e) {
      throw Exception('Failed to update stats: $e');
    }
  }
}
