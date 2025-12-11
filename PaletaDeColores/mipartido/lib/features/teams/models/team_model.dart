import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import '../../matches/models/sport_type.dart';

/// Team Model
class TeamModel extends Equatable {
  final String id;
  final String name;
  final String? shieldUrl;
  final SportType primarySport;
  final String captainId;
  final List<TeamMember> members;
  final String? chatId;
  final DateTime createdAt;

  const TeamModel({
    required this.id,
    required this.name,
    this.shieldUrl,
    required this.primarySport,
    required this.captainId,
    this.members = const [],
    this.chatId,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    shieldUrl,
    primarySport,
    captainId,
    members,
    chatId,
    createdAt,
  ];

  factory TeamModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return TeamModel(
      id: doc.id,
      name: data['name'],
      shieldUrl: data['shieldUrl'],
      primarySport: SportType.values.byName(data['primarySport']),
      captainId: data['captainId'],
      members:
          (data['members'] as List?)
              ?.map((m) => TeamMember.fromMap(m))
              .toList() ??
          [],
      chatId: data['chatId'],
      createdAt: (data['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'shieldUrl': shieldUrl,
      'primarySport': primarySport.name,
      'captainId': captainId,
      'members': members.map((m) => m.toMap()).toList(),
      'chatId': chatId,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }

  TeamModel copyWith({
    String? name,
    String? shieldUrl,
    String? captainId,
    List<TeamMember>? members,
    String? chatId,
  }) {
    return TeamModel(
      id: id,
      name: name ?? this.name,
      shieldUrl: shieldUrl ?? this.shieldUrl,
      primarySport: primarySport,
      captainId: captainId ?? this.captainId,
      members: members ?? this.members,
      chatId: chatId ?? this.chatId,
      createdAt: createdAt,
    );
  }

  /// Get accepted members
  List<TeamMember> get acceptedMembers {
    return members.where((m) => m.status == MembershipStatus.accepted).toList();
  }

  /// Check if user is captain
  bool isCaptain(String userId) {
    return captainId == userId;
  }

  /// Check if user is member
  bool isMember(String userId) {
    return members.any(
      (m) => m.userId == userId && m.status == MembershipStatus.accepted,
    );
  }
}

/// Team Member
class TeamMember extends Equatable {
  final String userId;
  final TeamRole role;
  final MembershipStatus status;
  final DateTime joinedAt;

  const TeamMember({
    required this.userId,
    required this.role,
    required this.status,
    required this.joinedAt,
  });

  @override
  List<Object?> get props => [userId, role, status, joinedAt];

  factory TeamMember.fromMap(Map<String, dynamic> map) {
    return TeamMember(
      userId: map['userId'],
      role: TeamRole.values.byName(map['role']),
      status: MembershipStatus.values.byName(map['status']),
      joinedAt: (map['joinedAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'role': role.name,
      'status': status.name,
      'joinedAt': Timestamp.fromDate(joinedAt),
    };
  }
}

/// Team Role
enum TeamRole {
  captain,
  member;

  String get displayName {
    switch (this) {
      case TeamRole.captain:
        return 'Capitán';
      case TeamRole.member:
        return 'Miembro';
    }
  }
}

/// Membership Status
enum MembershipStatus {
  pending,
  accepted,
  rejected;

  String get displayName {
    switch (this) {
      case MembershipStatus.pending:
        return 'Pendiente';
      case MembershipStatus.accepted:
        return 'Aceptado';
      case MembershipStatus.rejected:
        return 'Rechazado';
    }
  }
}
