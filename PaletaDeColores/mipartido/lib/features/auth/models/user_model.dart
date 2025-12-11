import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

/// User Model
/// 
/// Represents a user in the Mi Partido app (Sports Passport)
class UserModel extends Equatable {
  final String id;
  final String email;
  final String displayName;
  final String? photoUrl;
  final String? bio;
  final HomeLocation? homeLocation;
  final UserStats stats;
  final bool isCustomPhoto;
  final bool isCustomName;
  final DateTime createdAt;
  final DateTime? lastMatchAt;

  const UserModel({
    required this.id,
    required this.email,
    required this.displayName,
    this.photoUrl,
    this.bio,
    this.homeLocation,
    this.stats = const UserStats(),
    this.isCustomPhoto = false,
    this.isCustomName = false,
    required this.createdAt,
    this.lastMatchAt,
  });

  @override
  List<Object?> get props => [
        id,
        email,
        displayName,
        photoUrl,
        bio,
        homeLocation,
        stats,
        isCustomPhoto,
        isCustomName,
        createdAt,
        lastMatchAt,
      ];

  /// Create from Firestore document
  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return UserModel(
      id: doc.id,
      email: data['email'] ?? '',
      displayName: data['displayName'] ?? '',
      photoUrl: data['photoUrl'],
      bio: data['bio'],
      homeLocation: data['homeLocation'] != null
          ? HomeLocation.fromMap(data['homeLocation'])
          : null,
      stats: data['stats'] != null
          ? UserStats.fromMap(data['stats'])
          : const UserStats(),
      isCustomPhoto: data['isCustomPhoto'] ?? false,
      isCustomName: data['isCustomName'] ?? false,
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      lastMatchAt: data['lastMatchAt'] != null
          ? (data['lastMatchAt'] as Timestamp).toDate()
          : null,
    );
  }

  /// Convert to Firestore map
  Map<String, dynamic> toFirestore() {
    return {
      'email': email,
      'displayName': displayName,
      'photoUrl': photoUrl,
      'bio': bio,
      'homeLocation': homeLocation?.toMap(),
      'stats': stats.toMap(),
      'isCustomPhoto': isCustomPhoto,
      'isCustomName': isCustomName,
      'createdAt': Timestamp.fromDate(createdAt),
      'lastMatchAt':
          lastMatchAt != null ? Timestamp.fromDate(lastMatchAt!) : null,
    };
  }

  /// Copy with method for updates
  UserModel copyWith({
    String? email,
    String? displayName,
    String? photoUrl,
    String? bio,
    HomeLocation? homeLocation,
    UserStats? stats,
    bool? isCustomPhoto,
    bool? isCustomName,
    DateTime? lastMatchAt,
  }) {
    return UserModel(
      id: id,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      photoUrl: photoUrl ?? this.photoUrl,
      bio: bio ?? this.bio,
      homeLocation: homeLocation ?? this.homeLocation,
      stats: stats ?? this.stats,
      isCustomPhoto: isCustomPhoto ?? this.isCustomPhoto,
      isCustomName: isCustomName ?? this.isCustomName,
      createdAt: createdAt,
      lastMatchAt: lastMatchAt ?? this.lastMatchAt,
    );
  }
}

/// Home Location
/// 
/// User's base location for geospatial queries
class HomeLocation extends Equatable {
  final double latitude;
  final double longitude;
  final String geohash;
  final String? address;

  const HomeLocation({
    required this.latitude,
    required this.longitude,
    required this.geohash,
    this.address,
  });

  @override
  List<Object?> get props => [latitude, longitude, geohash, address];

  factory HomeLocation.fromMap(Map<String, dynamic> map) {
    return HomeLocation(
      latitude: map['latitude'] ?? 0.0,
      longitude: map['longitude'] ?? 0.0,
      geohash: map['geohash'] ?? '',
      address: map['address'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'latitude': latitude,
      'longitude': longitude,
      'geohash': geohash,
      'address': address,
    };
  }
}

/// User Statistics
/// 
/// Accumulated stats for a user
class UserStats extends Equatable {
  final int matchesPlayed;
  final int matchesWon;
  final int mvps;

  const UserStats({
    this.matchesPlayed = 0,
    this.matchesWon = 0,
    this.mvps = 0,
  });

  @override
  List<Object?> get props => [matchesPlayed, matchesWon, mvps];

  factory UserStats.fromMap(Map<String, dynamic> map) {
    return UserStats(
      matchesPlayed: map['matchesPlayed'] ?? 0,
      matchesWon: map['matchesWon'] ?? 0,
      mvps: map['mvps'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'matchesPlayed': matchesPlayed,
      'matchesWon': matchesWon,
      'mvps': mvps,
    };
  }

  /// Calculate win rate
  double get winRate {
    if (matchesPlayed == 0) return 0.0;
    return matchesWon / matchesPlayed;
  }

  /// Update stats after match
  UserStats incrementStats({
    bool won = false,
    bool isMvp = false,
  }) {
    return UserStats(
      matchesPlayed: matchesPlayed + 1,
      matchesWon: won ? matchesWon + 1 : matchesWon,
      mvps: isMvp ? mvps + 1 : mvps,
    );
  }
}
