import 'package:flutter/material.dart';

class AppColors {
  // 파스텔 컬러 팔레트
  static const Color pastelPink = Color(0xFFFFB5BA);
  static const Color pastelBlue = Color(0xFFB5D8FF);
  static const Color pastelMint = Color(0xFFB5FFD9);
  static const Color pastelYellow = Color(0xFFFFF3B5);
  static const Color pastelPurple = Color(0xFFE0B5FF);

  // 메인 컬러
  static const Color primary = Color(0xFFFF8A9B);
  static const Color primaryDark = Color(0xFFE57A8A);
  static const Color primaryLight = Color(0xFFFFD4D8);

  // 배경 컬러
  static const Color background = Color(0xFFFFF9F9);
  static const Color cardBackground = Color(0xFFFFFFFF);

  // 텍스트 컬러
  static const Color textPrimary = Color(0xFF4A4A4A);
  static const Color textLight = Color(0xFF8E8E8E);
  static const Color textWhite = Color(0xFFFFFFFF);

  // 상태 컬러
  static const Color success = Color(0xFF4DC48D);
  static const Color warning = Color(0xFFC4A84D);
  static const Color error = Color(0xFFC44D5C);

  // 보더
  static const Color border = Color(0xFFF0E0E2);
  static const Color borderLight = Color(0xFFF8F0F2);

  // 그라데이션
  static const LinearGradient backgroundGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFFFE5E5), Color(0xFFE5F0FF)],
  );

  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [pastelPink, primary],
  );

  static const LinearGradient avatarGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [pastelPink, pastelPurple],
  );

  static const LinearGradient mapGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFE8F5E9), pastelMint],
  );
}

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      fontFamily: 'Pretendard',
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: ColorScheme.light(
        primary: AppColors.primary,
        secondary: AppColors.pastelPink,
        surface: AppColors.cardBackground,
        error: AppColors.error,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: AppColors.textPrimary,
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
        iconTheme: IconThemeData(color: AppColors.textPrimary),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.textWhite,
          padding: const EdgeInsets.symmetric(vertical: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          elevation: 0,
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.textPrimary,
          padding: const EdgeInsets.symmetric(vertical: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          side: const BorderSide(color: AppColors.border, width: 2),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.cardBackground,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(color: AppColors.border, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(color: AppColors.border, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(color: AppColors.pastelPink, width: 2),
        ),
        hintStyle: const TextStyle(color: AppColors.textLight),
        labelStyle: const TextStyle(
          color: AppColors.textPrimary,
          fontSize: 13,
          fontWeight: FontWeight.w600,
        ),
      ),
      cardTheme: CardThemeData(
        color: AppColors.cardBackground,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
      ),
    );
  }
}
