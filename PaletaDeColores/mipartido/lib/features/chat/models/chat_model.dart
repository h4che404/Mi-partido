import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

/// Chat Model
/// 
/// Represents a chat (team or match lobby)
class ChatModel extends Equatable {
  final String id;
  final ChatType type;
  final String? teamId;
  final String? matchId;
  final List<String> participants;
  final DateTime createdAt;
  final DateTime? lastMessageAt;

  const ChatModel({
    required this.id,
    required this.type,
    this.teamId,
    this.matchId,
    required this.participants,
    required this.createdAt,
    this.lastMessageAt,
  });

  @override
  List<Object?> get props => [
        id,
        type,
        teamId,
        matchId,
        participants,
        createdAt,
        lastMessageAt,
      ];

  factory ChatModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return ChatModel(
      id: doc.id,
      type: ChatType.values.byName(data['type']),
      teamId: data['teamId'],
      matchId: data['matchId'],
      participants: List<String>.from(data['participants'] ?? []),
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      lastMessageAt: data['lastMessageAt'] != null
          ? (data['lastMessageAt'] as Timestamp).toDate()
          : null,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'type': type.name,
      'teamId': teamId,
      'matchId': matchId,
      'participants': participants,
      'createdAt': Timestamp.fromDate(createdAt),
      'lastMessageAt':
          lastMessageAt != null ? Timestamp.fromDate(lastMessageAt!) : null,
    };
  }
}

/// Chat Type
enum ChatType {
  team,
  matchLobby;

  String get displayName {
    switch (this) {
      case ChatType.team:
        return 'Chat de Equipo';
      case ChatType.matchLobby:
        return 'Lobby del Partido';
    }
  }
}

/// Message Model
class MessageModel extends Equatable {
  final String id;
  final String chatId;
  final String senderId;
  final String text;
  final DateTime createdAt;
  final bool synced;

  const MessageModel({
    required this.id,
    required this.chatId,
    required this.senderId,
    required this.text,
    required this.createdAt,
    this.synced = true,
  });

  @override
  List<Object?> get props => [
        id,
        chatId,
        senderId,
        text,
        createdAt,
        synced,
      ];

  factory MessageModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return MessageModel(
      id: doc.id,
      chatId: data['chatId'],
      senderId: data['senderId'],
      text: data['text'],
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      synced: true,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'chatId': chatId,
      'senderId': senderId,
      'text': text,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }

  MessageModel copyWith({
    bool? synced,
  }) {
    return MessageModel(
      id: id,
      chatId: chatId,
      senderId: senderId,
      text: text,
      createdAt: createdAt,
      synced: synced ?? this.synced,
    );
  }
}
