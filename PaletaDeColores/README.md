# Mi Partido ⚽

Una aplicación móvil multiplataforma para organizar partidos de deportes amateur.

## 🎯 Descripción

**Mi Partido** es una app móvil (Android/iOS) construida con Flutter que permite a los usuarios:

- 🔐 Registrarse fácilmente con Google, Apple o Email/Password
- 👥 Crear y gestionar equipos deportivos
- ⚽ Organizar partidos de fútbol, pádel y tenis
- 🗺️ Encontrar rivales cercanos mediante un marketplace geoespacial
- 💬 Coordinar mediante chats de equipo y lobbies de partido
- 📊 Seguir estadísticas personales y de equipo
- 🏆 Validar resultados con confirmación de capitanes
- 📱 Funcionar offline-first con sincronización automática

## 🏗️ Arquitectura

### Stack Tecnológico

- **Framework**: Flutter 3.0+
- **Backend**: Firebase (Auth, Firestore, Cloud Messaging, Storage)
- **State Management**: Provider
- **Local Database**: Hive
- **Diseño**: Material 3

### Estructura del Proyecto

```
lib/
├── core/
│   ├── theme/
│   │   ├── colors.dart          # Tokens de color
│   │   ├── theme.dart           # Configuración de temas
│   │   └── theme_provider.dart  # Gestión de modo claro/oscuro
│   ├── database/
│   │   └── local_database.dart  # Configuración de Hive
│   └── sync/
│       └── sync_service.dart    # Sincronización offline-first
├── features/
│   ├── auth/
│   │   ├── models/
│   │   │   └── user_model.dart
│   │   ├── services/
│   │   │   └── auth_service.dart
│   │   ├── providers/
│   │   │   └── auth_provider.dart
│   │   └── screens/
│   │       ├── login_screen.dart
│   │       └── register_screen.dart
│   ├── teams/
│   │   ├── models/
│   │   │   └── team_model.dart
│   │   └── screens/
│   │       └── (team screens)
│   ├── matches/
│   │   ├── models/
│   │   │   ├── sport_type.dart
│   │   │   └── match_model.dart
│   │   └── screens/
│   │       └── (match screens)
│   ├── chat/
│   │   ├── models/
│   │   │   └── chat_model.dart
│   │   └── screens/
│   │       └── (chat screens)
│   └── home/
│       └── screens/
│           └── home_screen.dart
└── main.dart
```

## 🎨 Sistema de Colores

### Paleta de Marca

- **Verde Primario** (`#16A34A`): Representa el campo de fútbol, usado en CTAs principales
- **Amarillo Acento** (`#FACC15`): Para marcadores, badges de MVP y highlights
- **Azul Secundario** (`#0F172A`): Acciones secundarias e información

### Temas

- **Modo Claro**: Fondo casi blanco, cards limpias, alta legibilidad
- **Modo Oscuro**: Estética "noche de partido" con fondo azul-negruzco

## 🚀 Configuración

### Prerrequisitos

1. **Flutter SDK** (3.0+)
   ```bash
   flutter --version
   ```

2. **Firebase Project**
   - Crear proyecto en [Firebase Console](https://console.firebase.google.com/)
   - Habilitar Authentication (Google, Apple, Email/Password)
   - Crear base de datos Firestore
   - Configurar Cloud Messaging
   - Configurar Storage

### Instalación

1. **Clonar el repositorio**
   ```bash
   cd PaletaDeColores
   ```

2. **Instalar dependencias**
   ```bash
   flutter pub get
   ```

3. **Configurar Firebase**

   **Android:**
   - Descargar `google-services.json` desde Firebase Console
   - Colocar en `android/app/google-services.json`

   **iOS:**
   - Descargar `GoogleService-Info.plist` desde Firebase Console
   - Colocar en `ios/Runner/GoogleService-Info.plist`

4. **Ejecutar la app**
   ```bash
   flutter run
   ```

## 📱 Características Principales

### Autenticación
- Login con Google
- Login con Apple (iOS)
- Registro/Login con Email y Contraseña
- Merge inteligente de identidades

### Gestión de Equipos
- Crear equipos con escudo personalizado
- Asignar capitán
- Invitar miembros
- Chat persistente de equipo

### Sistema de Partidos
- **Multi-deporte**: Fútbol (5/7/11), Pádel, Tenis
- **Modo Marketplace**: Publicar partido para encontrar rivales
- **Modo Social**: Desafíos privados entre equipos conocidos
- **Estados**: Borrador → Publicado → Confirmado → En Vivo → Finalizado

### Partido en Vivo
- Marcador editable en tiempo real
- UI polimórfica según deporte (goles vs sets)
- Sincronización offline-first
- Confirmación de resultado por capitanes

### Marketplace Geoespacial
- Buscar partidos cercanos
- Filtros por deporte, fecha, distancia
- Desafiar equipos
- Aceptar/rechazar solicitudes

### Chat
- Chat de equipo (persistente)
- Lobby de partido (efímero)
- Mensajes en tiempo real
- Cola offline para envíos

### Notificaciones Push
- Invitaciones a partido
- Confirmación de match
- Recordatorio 2 horas antes
- Resultado pendiente de confirmación

## 🗄️ Modelos de Datos

### Usuario
```dart
- id, email, displayName
- photoUrl, bio
- homeLocation (geohash, lat/lng)
- stats (matchesPlayed, matchesWon, mvps)
```

### Equipo
```dart
- id, name, shieldUrl
- primarySport, captainId
- members (userId, role, status)
- chatId
```

### Partido
```dart
- id, sportType, footballModality
- state, mode, startTime
- location (geohash, lat/lng, venueName)
- homeTeamId, awayTeamId
- score (polymorphic: goals or sets)
- captainConfirmations
```

## 🔒 Seguridad

Las reglas de Firestore garantizan:
- Usuarios solo pueden editar su propio perfil
- Solo miembros de equipo pueden ver su chat
- Solo jugadores de un partido pueden editar marcador
- Solo capitanes pueden confirmar resultados

## 📊 Offline-First

- **Lectura**: Cache local primero, actualización en segundo plano
- **Escritura**: Guardado local inmediato, sincronización cuando hay red
- **Conflictos**: Last-write-wins para MVP

## 🎯 Roadmap

### MVP (Actual)
- ✅ Autenticación multi-proveedor
- ✅ Gestión de equipos
- ✅ Sistema de partidos polimórfico
- ✅ Marketplace geoespacial
- ✅ Chat en tiempo real
- ✅ Notificaciones push
- ✅ Offline-first

### Futuro
- 🔜 Reserva de canchas
- 🔜 Torneos
- 🔜 Rankings globales
- 🔜 Sistema de pagos
- 🔜 Estadísticas avanzadas
- 🔜 Compartir en redes sociales

## 📄 Licencia

Este proyecto es parte de Mi Partido. Todos los derechos reservados.

## 🤝 Contribución

Para contribuir al proyecto, por favor contacta al equipo de desarrollo.

---

**Hecho con ❤️ y Flutter**
