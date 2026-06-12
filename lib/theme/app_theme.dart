import 'package:flutter/material.dart';
import 'package:virtual_display/theme/colors.dart';

class AppTheme {
  // Para usar: colorScheme.primary, colorScheme.secondary, etc.
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.dark(
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      tertiary: AppColors.tertiary,
      surface: AppColors.surface,       // Puxa automáticamente em Cards
      error: AppColors.error,
    ),
    // Para usar: Scaffold(), a cor de fundo já está definida aqui. 
    scaffoldBackgroundColor: AppColors.background,
    // Para usar: Apenas chamar AppBar(), a cor já está definida aqui.
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
    ),
    // Para usar: ElevatedButton(), a cor já está definida aqui.
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.buttons,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
    // Para usar: Text(), a cor já está definida aqui.
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.outline),
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.outline),
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.outlineVariant),
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
    ),
  );
}