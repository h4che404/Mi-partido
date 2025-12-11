# Mi Partido - Flutter App

Flutter project for organizing amateur sports matches.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Firebase Setup

Before running the app, you need to configure Firebase:

1. Create a Firebase project at https://console.firebase.google.com/
2. Add Android and iOS apps to your Firebase project
3. Download configuration files:
   - `google-services.json` for Android → place in `android/app/`
   - `GoogleService-Info.plist` for iOS → place in `ios/Runner/`
4. Enable Authentication providers (Google, Apple, Email/Password)
5. Create Firestore database
6. Enable Cloud Messaging
7. Enable Storage

## Running the App

```bash
flutter pub get
flutter run
```

## Project Structure

See main README.md for detailed architecture and features.
