import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'sport_type.dart';

/// Match Model
/// 
/// Polymorphic match entity that adapts to different sports
class MatchModel extends Equatable {
  final String id;
  final SportType sportType;
  final FootballModality? footballModality;
  final SurfaceType? surface;
  final MatchState state;
  final MatchMode mode;
  final DateTime startTime;
  final int? durationMinutes;
  final MatchLocation location;
  final String homeTeamId;
  final String? awayTeamId;
  final String creatorId;
  final SkillLevel? skillLevel;
  final String? notes;
  final MatchScore score;
  final bool disputed;
  final DateTime createdAt;
  final DateTime? confirmedAt;
  final DateTime? finishedAt;
  final List<String> captainConfirmations;

  const MatchModel({
    required this.id,
    required this.sportType,
    this.footballModality,
    this.surface,
    required this.state,
    required this.mode,
    required this.startTime,
    this.durationMinutes,
    required this.location,
    required this.homeTeamId,
    this.awayTeamId,
    required this.creatorId,
    this.skillLevel,
    this.notes,
    this.score = const MatchScore(),
    this.disputed = false,
    required this.createdAt,
    this.confirmedAt,
    this.finishedAt,
    this.captainConfirmations = const [],
  });

  @override
  List<Object?> get props => [
        id,
        sportType,
        footballModality,
        surface,
        state,
        mode,
        startTime,
        durationMinutes,
        location,
        homeTeamId,
        awayTeamId,
        creatorId,
        skillLevel,
        notes,
        score,
        disputed,
        createdAt,
        confirmedAt,
        finishedAt,
        captainConfirmations,
      ];

  factory MatchModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return MatchModel(
      id: doc.id,
      sportType: SportType.values.byName(data['sportType']),
      footballModality: data['footballModality'] != null
          ? FootballModality.values.byName(data['footballModality'])
          : null,
      surface: data['surface'] != null
          ? SurfaceType.values.byName(data['surface'])
          : null,
      state: MatchState.values.byName(data['state']),
      mode: MatchMode.values.byName(data['mode']),
      startTime: (data['startTime'] as Timestamp).toDate(),
      durationMinutes: data['durationMinutes'],
      location: MatchLocation.fromMap(data['location']),
      homeTeamId: data['homeTeamId'],
      awayTeamId: data['awayTeamId'],
      creatorId: data['creatorId'],
      skillLevel: data['skillLevel'] != null
          ? SkillLevel.values.byName(data['skillLevel'])
          : null,
      notes: data['notes'],
      score: MatchScore.fromMap(data['score'] ?? {}),
      disputed: data['disputed'] ?? false,
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      confirmedAt: data['confirmedAt'] != null
          ? (data['confirmedAt'] as Timestamp).toDate()
          : null,
      finishedAt: data['finishedAt'] != null
          ? (data['finishedAt'] as Timestamp).toDate()
          : null,
      captainConfirmations:
          List<String>.from(data['captainConfirmations'] ?? []),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'sportType': sportType.name,
      'footballModality': footballModality?.name,
      'surface': surface?.name,
      'state': state.name,
      'mode': mode.name,
      'startTime': Timestamp.fromDate(startTime),
      'durationMinutes': durationMinutes,
      'location': location.toMap(),
      'homeTeamId': homeTeamId,
      'awayTeamId': awayTeamId,
      'creatorId': creatorId,
      'skillLevel': skillLevel?.name,
      'notes': notes,
      'score': score.toMap(),
      'disputed': disputed,
      'createdAt': Timestamp.fromDate(createdAt),
      'confirmedAt':
          confirmedAt != null ? Timestamp.fromDate(confirmedAt!) : null,
      'finishedAt':
          finishedAt != null ? Timestamp.fromDate(finishedAt!) : null,
      'captainConfirmations': captainConfirmations,
    };
  }

  MatchModel copyWith({
    MatchState? state,
    String? awayTeamId,
    MatchScore? score,
    bool? disputed,
    DateTime? confirmedAt,
    DateTime? finishedAt,
    List<String>? captainConfirmations,
    String? notes,
  }) {
    return MatchModel(
      id: id,
      sportType: sportType,
      footballModality: footballModality,
      surface: surface,
      state: state ?? this.state,
      mode: mode,
      startTime: startTime,
      durationMinutes: durationMinutes,
      location: location,
      homeTeamId: homeTeamId,
      awayTeamId: awayTeamId ?? this.awayTeamId,
      creatorId: creatorId,
      skillLevel: skillLevel,
      notes: notes ?? this.notes,
      score: score ?? this.score,
      disputed: disputed ?? this.disputed,
      createdAt: createdAt,
      confirmedAt: confirmedAt ?? this.confirmedAt,
      finishedAt: finishedAt ?? this.finishedAt,
      captainConfirmations: captainConfirmations ?? this.captainConfirmations,
    );
  }
}

/// Match Location
class MatchLocation extends Equatable {
  final double latitude;
  final double longitude;
  final String geohash;
  final String venueName;
  final String? address;

  const MatchLocation({
    required this.latitude,
    required this.longitude,
    required this.geohash,
    required this.venueName,
    this.address,
  });

  @override
  List<Object?> get props => [latitude, longitude, geohash, venueName, address];

  factory MatchLocation.fromMap(Map<String, dynamic> map) {
    return MatchLocation(
      latitude: map['latitude'] ?? 0.0,
      longitude: map['longitude'] ?? 0.0,
      geohash: map['geohash'] ?? '',
      venueName: map['venueName'] ?? '',
      address: map['address'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'latitude': latitude,
      'longitude': longitude,
      'geohash': geohash,
      'venueName': venueName,
      'address': address,
    };
  }
}

/// Match Score
/// 
/// Polymorphic score that adapts to sport type
class MatchScore extends Equatable {
  // Football
  final int? goalsHome;
  final int? goalsAway;

  // Padel/Tennis
  final int? setsHome;
  final int? setsAway;
  final String? setsDetail; // Detailed score like "6-4, 3-6, 7-5"

  const MatchScore({
    this.goalsHome,
    this.goalsAway,
    this.setsHome,
    this.setsAway,
    this.setsDetail,
  });

  @override
  List<Object?> get props => [
        goalsHome,
        goalsAway,
        setsHome,
        setsAway,
        setsDetail,
      ];

  factory MatchScore.fromMap(Map<String, dynamic> map) {
    return MatchScore(
      goalsHome: map['goalsHome'],
      goalsAway: map['goalsAway'],
      setsHome: map['setsHome'],
      setsAway: map['setsAway'],
      setsDetail: map['setsDetail'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'goalsHome': goalsHome,
      'goalsAway': goalsAway,
      'setsHome': setsHome,
      'setsAway': setsAway,
      'setsDetail': setsDetail,
    };
  }

  /// Create football score
  factory MatchScore.football({int goalsHome = 0, int goalsAway = 0}) {
    return MatchScore(goalsHome: goalsHome, goalsAway: goalsAway);
  }

  /// Create padel/tennis score
  factory MatchScore.racket({
    int setsHome = 0,
    int setsAway = 0,
    String? setsDetail,
  }) {
    return MatchScore(
      setsHome: setsHome,
      setsAway: setsAway,
      setsDetail: setsDetail,
    );
  }

  /// Check if home team won
  bool get homeWon {
    if (goalsHome != null && goalsAway != null) {
      return goalsHome! > goalsAway!;
    }
    if (setsHome != null && setsAway != null) {
      return setsHome! > setsAway!;
    }
    return false;
  }

  /// Check if away team won
  bool get awayWon {
    if (goalsHome != null && goalsAway != null) {
      return goalsAway! > goalsHome!;
    }
    if (setsHome != null && setsAway != null) {
      return setsAway! > setsHome!;
    }
    return false;
  }

  /// Check if draw (only for football)
  bool get isDraw {
    if (goalsHome != null && goalsAway != null) {
      return goalsHome == goalsAway;
    }
    return false;
  }

  /// Get formatted score string
  String getFormattedScore(SportType sportType) {
    switch (sportType) {
      case SportType.football:
        return '${goalsHome ?? 0} - ${goalsAway ?? 0}';
      case SportType.padel:
      case SportType.tennis:
        if (setsDetail != null && setsDetail!.isNotEmpty) {
          return setsDetail!;
        }
        return '${setsHome ?? 0} - ${setsAway ?? 0} sets';
    }
  }
}
