import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.backgroundDark,
      primaryColor: AppColors.primary,
      
      // Font Ailesi: Plus Jakarta Sans (Başlıklar için varsayılan)
      textTheme: GoogleFonts.plusJakartaSansTextTheme(
        ThemeData.dark().textTheme,
      ).apply(
        bodyColor: AppColors.white,
        displayColor: AppColors.white,
      ),
      
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primary,
        surface: AppColors.cardDark,
        onSurface: AppColors.white,
        background: AppColors.backgroundDark,
        onBackground: AppColors.white,
      ),

      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: ZoomPageTransitionsBuilder(),
          TargetPlatform.iOS: ZoomPageTransitionsBuilder(),
        },
      ),
      
      cardTheme: CardTheme(
        color: AppColors.cardDark,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24), // Rounded-3xl / 2xl
          side: const BorderSide(color: Color(0x33685D31), width: 1), // border-border-gold/20
        ),
      ),
      
      // Buton vb. stiller buraya eklenebilir
    );
  }
}
