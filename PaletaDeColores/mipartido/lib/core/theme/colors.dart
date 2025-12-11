import 'package:flutter/material.dart';

/// Mi Partido - Color Tokens
/// 
/// Base color palette for the football app.
/// Supports both light and dark themes with Material 3 design system.

// ============================================
// 🎨 BRAND / IDENTITY COLORS
// ============================================

/// Primary brand color - Green (represents the football field)
/// Used for main CTAs, FABs, and primary actions
const Color greenPrimary = Color(0xFF16A34A);

/// Primary color for dark mode - Brighter green for better visibility
const Color greenPrimaryDark = Color(0xFF22C55E);

/// Primary container - Light green background
/// Used for subtle highlights and containers
const Color greenPrimaryContainer = Color(0xFFBBF7D0);

/// Text color on primary container
const Color greenOnPrimaryContainer = Color(0xFF052E16);

// ============================================
// ⚡ ACCENT COLORS - Yellow (Highlight)
// ============================================

/// Yellow accent - Used for scores, MVP badges, and highlights
const Color yellowAccent = Color(0xFFFACC15);

/// Yellow accent container - Light yellow background
const Color yellowAccentContainer = Color(0xFFFEF9C3);

/// Text color on yellow accent
const Color yellowOnAccent = Color(0xFF1F2937);

/// Text color on yellow accent container
const Color yellowOnAccentContainer = Color(0xFF422006);

// ============================================
// 🔵 SECONDARY COLORS - Blue/Navy
// ============================================

/// Secondary color - Deep blue/navy
/// Used for secondary actions and information
const Color blueSecondary = Color(0xFF0F172A);

/// Secondary container for light theme
const Color blueSecondaryContainerLight = Color(0xFFE5E7EB);

/// Secondary container for dark theme
const Color blueSecondaryContainerDark = Color(0xFF1F2937);

/// Text on secondary container (light theme)
const Color blueOnSecondaryContainerLight = Color(0xFF020617);

/// Text on secondary container (dark theme)
const Color blueOnSecondaryContainerDark = Color(0xFFE5E7EB);

// ============================================
// ⚪ NEUTRAL COLORS - Light Theme
// ============================================

/// Light theme background - Almost white
const Color lightBackground = Color(0xFFF9FAFB);

/// Light theme surface - Pure white for cards
const Color lightSurface = Color(0xFFFFFFFF);

/// Light theme surface variant - Subtle gray
const Color lightSurfaceVariant = Color(0xFFE5E7EB);

/// Dark ink for text on light backgrounds
const Color darkInk = Color(0xFF111827);

// ============================================
// ⚫ NEUTRAL COLORS - Dark Theme
// ============================================

/// Dark theme background - Deep blue-black (night match aesthetic)
const Color darkBackground = Color(0xFF020617);

/// Dark theme surface - Same as background for consistency
const Color darkSurface = Color(0xFF020617);

/// Dark theme surface variant - Slightly lighter
const Color darkSurfaceVariant = Color(0xFF1F2937);

/// Light ink for text on dark backgrounds
const Color lightInk = Color(0xFFE5E7EB);

// ============================================
// 🚦 SEMANTIC COLORS
// ============================================

/// Success color - Green for confirmations and positive actions
const Color success = Color(0xFF22C55E);

/// Warning color - Orange for alerts and warnings
const Color warning = Color(0xFFF97316);

/// Error color - Red for errors and destructive actions
const Color error = Color(0xFFDC2626);

/// Error container - Light red background
const Color errorContainer = Color(0xFFFEE2E2);

/// Text on error container
const Color onErrorContainer = Color(0xFF450A0A);

/// Error container for dark theme
const Color errorContainerDark = Color(0xFF7F1D1D);

// ============================================
// 📐 UTILITY COLORS
// ============================================

/// Outline color - Used for borders and dividers
const Color outline = Color(0xFF9CA3AF);
