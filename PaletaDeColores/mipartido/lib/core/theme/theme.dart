import 'package:flutter/material.dart';
import 'colors.dart';

/// Mi Partido - Theme Configuration
///
/// Material 3 theme data for light and dark modes

// ============================================
// 🌞 LIGHT THEME
// ============================================

/// Light theme configuration
///
/// Designed for:
/// - Clean, almost white background
/// - Crisp card surfaces
/// - Green CTAs (create match, confirm result)
/// - Yellow highlights (scores, MVP badges)
ThemeData get lightTheme {
  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,

    // Color Scheme
    colorScheme: const ColorScheme(
      brightness: Brightness.light,

      // Primary - Green (Football field aesthetic)
      primary: greenPrimary,
      onPrimary: Colors.white,
      primaryContainer: greenPrimaryContainer,
      onPrimaryContainer: greenOnPrimaryContainer,

      // Secondary - Deep Blue
      secondary: blueSecondary,
      onSecondary: Colors.white,
      secondaryContainer: blueSecondaryContainerLight,
      onSecondaryContainer: blueOnSecondaryContainerLight,

      // Tertiary - Yellow (Scores, MVP, Badges)
      tertiary: yellowAccent,
      onTertiary: yellowOnAccent,
      tertiaryContainer: yellowAccentContainer,
      onTertiaryContainer: yellowOnAccentContainer,

      // Error
      error: error,
      onError: Colors.white,
      errorContainer: errorContainer,
      onErrorContainer: onErrorContainer,

      // Background & Surface
      surface: lightBackground,
      onSurface: darkInk,
      surfaceContainerHighest: lightSurfaceVariant,
      onSurfaceVariant: blueOnSecondaryContainerLight,

      // Outline
      outline: outline,
      outlineVariant: Color(0xFFD1D5DB),

      // Other
      shadow: Colors.black26,
      scrim: Colors.black54,
      inverseSurface: darkInk,
      onInverseSurface: lightInk,
      inversePrimary: greenPrimaryDark,
    ),

    // Typography
    textTheme: _buildTextTheme(darkInk),

    // App Bar Theme
    appBarTheme: const AppBarTheme(
      backgroundColor: lightSurface,
      foregroundColor: darkInk,
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: darkInk),
    ),

    // Card Theme
    cardTheme: CardThemeData(
      color: lightSurface,
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: Color(0xFFE5E7EB), width: 1),
      ),
    ),

    // Elevated Button Theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: greenPrimary,
        foregroundColor: Colors.white,
        elevation: 2,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),

    // Floating Action Button Theme
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: greenPrimary,
      foregroundColor: Colors.white,
      elevation: 4,
    ),

    // Input Decoration Theme
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: lightSurfaceVariant,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: outline),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: outline),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: greenPrimary, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: error),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    ),

    // Bottom Navigation Bar Theme
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: lightSurface,
      selectedItemColor: greenPrimary,
      unselectedItemColor: outline,
      type: BottomNavigationBarType.fixed,
      elevation: 8,
    ),

    // Chip Theme
    chipTheme: ChipThemeData(
      backgroundColor: lightSurfaceVariant,
      selectedColor: greenPrimaryContainer,
      labelStyle: const TextStyle(color: darkInk),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
  );
}

// ============================================
// 🌙 DARK THEME
// ============================================

/// Dark theme configuration
///
/// Designed for:
/// - Deep blue-black background (night match aesthetic)
/// - Brighter green for CTAs
/// - High contrast text
/// - Yellow highlights for scores
ThemeData get darkTheme {
  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,

    // Color Scheme
    colorScheme: const ColorScheme(
      brightness: Brightness.dark,

      // Primary - Brighter Green for dark mode
      primary: greenPrimaryDark,
      onPrimary: Color(0xFF022C16),
      primaryContainer: Color(0xFF14532D),
      onPrimaryContainer: greenPrimaryContainer,

      // Secondary - Dark Blue
      secondary: blueSecondaryContainerDark,
      onSecondary: lightInk,
      secondaryContainer: blueSecondaryContainerDark,
      onSecondaryContainer: blueOnSecondaryContainerDark,

      // Tertiary - Yellow (Scores, MVP, Badges)
      tertiary: yellowAccent,
      onTertiary: yellowOnAccent,
      tertiaryContainer: Color(0xFF854D0E),
      onTertiaryContainer: yellowAccentContainer,

      // Error
      error: error,
      onError: Colors.white,
      errorContainer: errorContainerDark,
      onErrorContainer: errorContainer,

      // Background & Surface
      surface: darkBackground,
      onSurface: lightInk,
      surfaceContainerHighest: darkSurfaceVariant,
      onSurfaceVariant: lightInk,

      // Outline
      outline: outline,
      outlineVariant: Color(0xFF4B5563),

      // Other
      shadow: Colors.black87,
      scrim: Colors.black87,
      inverseSurface: lightInk,
      onInverseSurface: darkInk,
      inversePrimary: greenPrimary,
    ),

    // Typography
    textTheme: _buildTextTheme(lightInk),

    // App Bar Theme
    appBarTheme: const AppBarTheme(
      backgroundColor: darkSurface,
      foregroundColor: lightInk,
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: lightInk),
    ),

    // Card Theme
    cardTheme: CardThemeData(
      color: darkSurfaceVariant,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: Color(0xFF374151), width: 1),
      ),
    ),

    // Elevated Button Theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: greenPrimaryDark,
        foregroundColor: Color(0xFF022C16),
        elevation: 2,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),

    // Floating Action Button Theme
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: greenPrimaryDark,
      foregroundColor: Color(0xFF022C16),
      elevation: 4,
    ),

    // Input Decoration Theme
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: darkSurfaceVariant,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: outline),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: outline),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: greenPrimaryDark, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: error),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    ),

    // Bottom Navigation Bar Theme
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: darkSurface,
      selectedItemColor: greenPrimaryDark,
      unselectedItemColor: outline,
      type: BottomNavigationBarType.fixed,
      elevation: 8,
    ),

    // Chip Theme
    chipTheme: ChipThemeData(
      backgroundColor: darkSurfaceVariant,
      selectedColor: Color(0xFF14532D),
      labelStyle: const TextStyle(color: lightInk),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
  );
}

// ============================================
// 📝 TYPOGRAPHY
// ============================================

TextTheme _buildTextTheme(Color baseColor) {
  return TextTheme(
    // Display styles (large, prominent text)
    displayLarge: TextStyle(
      fontSize: 57,
      fontWeight: FontWeight.bold,
      color: baseColor,
      letterSpacing: -0.25,
    ),
    displayMedium: TextStyle(
      fontSize: 45,
      fontWeight: FontWeight.bold,
      color: baseColor,
    ),
    displaySmall: TextStyle(
      fontSize: 36,
      fontWeight: FontWeight.bold,
      color: baseColor,
    ),

    // Headline styles (section headers)
    headlineLarge: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.bold,
      color: baseColor,
    ),
    headlineMedium: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.w600,
      color: baseColor,
    ),
    headlineSmall: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      color: baseColor,
    ),

    // Title styles (card titles, list items)
    titleLarge: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w600,
      color: baseColor,
    ),
    titleMedium: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: baseColor,
      letterSpacing: 0.15,
    ),
    titleSmall: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: baseColor,
      letterSpacing: 0.1,
    ),

    // Body styles (main content)
    bodyLarge: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.normal,
      color: baseColor,
      letterSpacing: 0.5,
    ),
    bodyMedium: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.normal,
      color: baseColor,
      letterSpacing: 0.25,
    ),
    bodySmall: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.normal,
      color: baseColor,
      letterSpacing: 0.4,
    ),

    // Label styles (buttons, tabs)
    labelLarge: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: baseColor,
      letterSpacing: 0.1,
    ),
    labelMedium: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w600,
      color: baseColor,
      letterSpacing: 0.5,
    ),
    labelSmall: TextStyle(
      fontSize: 11,
      fontWeight: FontWeight.w600,
      color: baseColor,
      letterSpacing: 0.5,
    ),
  );
}
