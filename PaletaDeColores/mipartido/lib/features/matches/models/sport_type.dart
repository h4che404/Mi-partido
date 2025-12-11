/// Sport Type Enumeration
/// 
/// Supported sports in Mi Partido app
enum SportType {
  football,
  padel,
  tennis;

  String get displayName {
    switch (this) {
      case SportType.football:
        return 'Fútbol';
      case SportType.padel:
        return 'Pádel';
      case SportType.tennis:
        return 'Tenis';
    }
  }

  String get icon {
    switch (this) {
      case SportType.football:
        return '⚽';
      case SportType.padel:
        return '🎾';
      case SportType.tennis:
        return '🎾';
    }
  }
}

/// Football Modality
/// 
/// Different football game formats
enum FootballModality {
  five,
  seven,
  eleven;

  int get playerCount {
    switch (this) {
      case FootballModality.five:
        return 5;
      case FootballModality.seven:
        return 7;
      case FootballModality.eleven:
        return 11;
    }
  }

  String get displayName {
    switch (this) {
      case FootballModality.five:
        return 'Fútbol 5';
      case FootballModality.seven:
        return 'Fútbol 7';
      case FootballModality.eleven:
        return 'Fútbol 11';
    }
  }
}

/// Surface Type
/// 
/// Playing surface for matches
enum SurfaceType {
  grass,
  synthetic,
  dirt,
  cement,
  indoor;

  String get displayName {
    switch (this) {
      case SurfaceType.grass:
        return 'Césped';
      case SurfaceType.synthetic:
        return 'Sintético';
      case SurfaceType.dirt:
        return 'Tierra';
      case SurfaceType.cement:
        return 'Cemento';
      case SurfaceType.indoor:
        return 'Indoor';
    }
  }
}

/// Match State
/// 
/// Lifecycle states of a match
enum MatchState {
  draft,
  published,
  matchPending,
  confirmed,
  live,
  finishedPendingConfirmation,
  finishedConfirmed,
  cancelled,
  disputed;

  String get displayName {
    switch (this) {
      case MatchState.draft:
        return 'Borrador';
      case MatchState.published:
        return 'Publicado';
      case MatchState.matchPending:
        return 'Pendiente de confirmación';
      case MatchState.confirmed:
        return 'Confirmado';
      case MatchState.live:
        return 'En vivo';
      case MatchState.finishedPendingConfirmation:
        return 'Finalizado - Pendiente de confirmación';
      case MatchState.finishedConfirmed:
        return 'Finalizado';
      case MatchState.cancelled:
        return 'Cancelado';
      case MatchState.disputed:
        return 'Disputado';
    }
  }

  bool get isActive {
    return this == MatchState.confirmed || this == MatchState.live;
  }

  bool get isFinished {
    return this == MatchState.finishedPendingConfirmation ||
        this == MatchState.finishedConfirmed ||
        this == MatchState.disputed;
  }
}

/// Match Mode
/// 
/// Visibility and discovery mode for matches
enum MatchMode {
  marketplace,
  social;

  String get displayName {
    switch (this) {
      case MatchMode.marketplace:
        return 'Público (Marketplace)';
      case MatchMode.social:
        return 'Privado (Social)';
    }
  }

  String get description {
    switch (this) {
      case MatchMode.marketplace:
        return 'Visible para todos, encuentra rivales cercanos';
      case MatchMode.social:
        return 'Solo visible para equipos invitados';
    }
  }
}

/// Skill Level
/// 
/// Player/team skill level
enum SkillLevel {
  beginner,
  intermediate,
  advanced;

  String get displayName {
    switch (this) {
      case SkillLevel.beginner:
        return 'Principiante';
      case SkillLevel.intermediate:
        return 'Intermedio';
      case SkillLevel.advanced:
        return 'Avanzado';
    }
  }
}
