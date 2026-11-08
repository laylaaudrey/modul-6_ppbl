
import 'package:flutter/material.dart';

class AppTheme {
  static const _biru = Color(0xFF1976D2);

  static ThemeData get light {
    return _buat(Brightness.light);
  }

  static ThemeData get dark {
    return _buat(Brightness.dark);
  }

  static ThemeData _buat(Brightness mode) {
    final scheme = ColorScheme.fromSeed(
      seedColor: _biru,
      brightness: mode,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: scheme.surface,

      appBarTheme: AppBarTheme(
        backgroundColor: scheme.primary,
        foregroundColor: scheme.onPrimary,
        centerTitle: false,
      ),

      cardTheme: CardThemeData(
        elevation: 1,
        margin: const EdgeInsets.symmetric(
          vertical: 6,
        ),
        color: scheme.surfaceContainerLow,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: scheme.primary,
          foregroundColor: scheme.onPrimary,
          padding: const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 14,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 12,
        ),
      ),
    );
  }
}
