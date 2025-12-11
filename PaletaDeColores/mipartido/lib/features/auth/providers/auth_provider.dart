import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/user_model.dart';
import '../services/auth_service.dart';

/// Authentication Provider
/// 
/// Manages authentication state and user profile
class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();
  
  UserModel? _currentUser;
  bool _isLoading = false;
  String? _errorMessage;

  UserModel? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isAuthenticated => _currentUser != null;

  /// Get auth state changes stream
  Stream<User?> get authStateChanges => _authService.authStateChanges;

  AuthProvider() {
    _initializeUser();
  }

  /// Initialize user on app start
  Future<void> _initializeUser() async {
    final user = _authService.currentUser;
    if (user != null) {
      await _loadUserProfile(user.uid);
    }
  }

  /// Load user profile
  Future<void> _loadUserProfile(String userId) async {
    try {
      _currentUser = await _authService.getUserProfile(userId);
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  // ============================================
  // 🔐 AUTHENTICATION METHODS
  // ============================================

  /// Sign in with Google
  Future<bool> signInWithGoogle() async {
    _setLoading(true);
    _clearError();

    try {
      final userCredential = await _authService.signInWithGoogle();
      if (userCredential != null) {
        await _loadUserProfile(userCredential.user!.uid);
        _setLoading(false);
        return true;
      }
      _setLoading(false);
      return false;
    } catch (e) {
      _setError('Google Sign-In failed: $e');
      _setLoading(false);
      return false;
    }
  }

  /// Sign in with Apple
  Future<bool> signInWithApple() async {
    _setLoading(true);
    _clearError();

    try {
      final userCredential = await _authService.signInWithApple();
      if (userCredential != null) {
        await _loadUserProfile(userCredential.user!.uid);
        _setLoading(false);
        return true;
      }
      _setLoading(false);
      return false;
    } catch (e) {
      _setError('Apple Sign-In failed: $e');
      _setLoading(false);
      return false;
    }
  }

  /// Register with Email and Password
  Future<bool> registerWithEmail({
    required String email,
    required String password,
    required String displayName,
  }) async {
    _setLoading(true);
    _clearError();

    try {
      final userCredential = await _authService.registerWithEmail(
        email: email,
        password: password,
        displayName: displayName,
      );
      await _loadUserProfile(userCredential.user!.uid);
      _setLoading(false);
      return true;
    } catch (e) {
      _setError('Registration failed: $e');
      _setLoading(false);
      return false;
    }
  }

  /// Sign in with Email and Password
  Future<bool> signInWithEmail({
    required String email,
    required String password,
  }) async {
    _setLoading(true);
    _clearError();

    try {
      final userCredential = await _authService.signInWithEmail(
        email: email,
        password: password,
      );
      await _loadUserProfile(userCredential.user!.uid);
      _setLoading(false);
      return true;
    } catch (e) {
      _setError('Sign-In failed: $e');
      _setLoading(false);
      return false;
    }
  }

  /// Sign out
  Future<void> signOut() async {
    _setLoading(true);
    try {
      await _authService.signOut();
      _currentUser = null;
      _setLoading(false);
    } catch (e) {
      _setError('Sign-Out failed: $e');
      _setLoading(false);
    }
  }

  // ============================================
  // 👤 PROFILE MANAGEMENT
  // ============================================

  /// Update user profile
  Future<bool> updateProfile({
    String? displayName,
    String? photoUrl,
    String? bio,
    HomeLocation? homeLocation,
    bool? isCustomPhoto,
  }) async {
    if (_currentUser == null) return false;

    _setLoading(true);
    _clearError();

    try {
      await _authService.updateUserProfile(
        userId: _currentUser!.id,
        displayName: displayName,
        photoUrl: photoUrl,
        bio: bio,
        homeLocation: homeLocation,
        isCustomPhoto: isCustomPhoto,
      );
      await _loadUserProfile(_currentUser!.id);
      _setLoading(false);
      return true;
    } catch (e) {
      _setError('Profile update failed: $e');
      _setLoading(false);
      return false;
    }
  }

  /// Refresh user profile
  Future<void> refreshProfile() async {
    if (_currentUser != null) {
      await _loadUserProfile(_currentUser!.id);
    }
  }

  // ============================================
  // 🛠️ HELPER METHODS
  // ============================================

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setError(String message) {
    _errorMessage = message;
    notifyListeners();
  }

  void _clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
