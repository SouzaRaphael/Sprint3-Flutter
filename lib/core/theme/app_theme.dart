import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lactarehub/core/theme/app_colors.dart';
import 'package:lactarehub/core/theme/app_radius.dart';
import 'package:lactarehub/core/theme/app_text_styles.dart';

const ColorScheme _lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: AppColors.primary,
  onPrimary: AppColors.surface,
  primaryContainer: AppColors.tintBlue,
  onPrimaryContainer: AppColors.primaryDark,
  secondary: AppColors.accent,
  onSecondary: AppColors.surface,
  secondaryContainer: AppColors.tintBlue,
  onSecondaryContainer: AppColors.primary,
  tertiary: AppColors.pinkStrong,
  onTertiary: AppColors.surface,
  tertiaryContainer: AppColors.pinkBg,
  onTertiaryContainer: AppColors.pinkFg,
  error: Color(0xFFC0334E),
  onError: AppColors.surface,
  errorContainer: Color(0xFFFCE3E8),
  onErrorContainer: Color(0xFF8E1F36),
  surface: AppColors.surface,
  onSurface: AppColors.ink,
  onSurfaceVariant: AppColors.inkMuted,
  surfaceContainerLowest: AppColors.surface,
  surfaceContainerLow: AppColors.bgApp,
  surfaceContainer: AppColors.bgLanding,
  outline: AppColors.border,
  outlineVariant: AppColors.borderInput,
  shadow: Color(0x1A0F2A4A),
  scrim: Color(0x66101828),
  inverseSurface: AppColors.ink,
  onInverseSurface: AppColors.surface,
  inversePrimary: AppColors.accent,
);

TextTheme _buildTextTheme() => TextTheme(
  displayLarge: AppTextStyles.heroTitle,
  displayMedium: AppTextStyles.screenTitle,
  displaySmall: AppTextStyles.sectionTitle,
  headlineLarge: AppTextStyles.sectionTitle,
  headlineMedium: AppTextStyles.sectionTitleOnBlue,
  headlineSmall: AppTextStyles.cardTitleBlue,
  titleLarge: AppTextStyles.cardTitle,
  titleMedium: AppTextStyles.cardTitleBlue,
  titleSmall: AppTextStyles.label,
  bodyLarge: AppTextStyles.body,
  bodyMedium: AppTextStyles.bodySmall,
  bodySmall: AppTextStyles.caption,
  labelLarge: AppTextStyles.button,
  labelMedium: AppTextStyles.badge,
  labelSmall: AppTextStyles.overline,
);

/// Tema único do aplicativo — o design de referência é claro.
abstract class AppTheme {
  static ThemeData get light => ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: _lightColorScheme,
    textTheme: _buildTextTheme(),
    scaffoldBackgroundColor: AppColors.bgApp,
    splashFactory: InkRipple.splashFactory,

    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.surface,
      surfaceTintColor: Colors.transparent,
      foregroundColor: AppColors.primaryDark,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: true,
      titleTextStyle: AppTextStyles.appBarTitle,
      iconTheme: const IconThemeData(color: AppColors.primary, size: 22),
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
    ),

    cardTheme: const CardThemeData(
      color: AppColors.surface,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: AppRadius.cardBR,
        side: BorderSide(color: AppColors.border),
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.surface,
      isDense: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      hintStyle: AppTextStyles.body.copyWith(color: const Color(0xFFA6B4C4)),
      border: const OutlineInputBorder(
        borderRadius: AppRadius.inputBR,
        borderSide: BorderSide(color: AppColors.borderInput),
      ),
      enabledBorder: const OutlineInputBorder(
        borderRadius: AppRadius.inputBR,
        borderSide: BorderSide(color: AppColors.borderInput),
      ),
      focusedBorder: const OutlineInputBorder(
        borderRadius: AppRadius.inputBR,
        borderSide: BorderSide(color: AppColors.accent, width: 1.6),
      ),
      errorBorder: const OutlineInputBorder(
        borderRadius: AppRadius.inputBR,
        borderSide: BorderSide(color: Color(0xFFC0334E)),
      ),
      focusedErrorBorder: const OutlineInputBorder(
        borderRadius: AppRadius.inputBR,
        borderSide: BorderSide(color: Color(0xFFC0334E), width: 1.6),
      ),
    ),

    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.surface,
        minimumSize: const Size.fromHeight(56),
        textStyle: AppTextStyles.button,
        shape: const RoundedRectangleBorder(borderRadius: AppRadius.pillBR),
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primaryDark,
        backgroundColor: AppColors.surface,
        minimumSize: const Size.fromHeight(56),
        side: const BorderSide(color: AppColors.border),
        textStyle: AppTextStyles.button.copyWith(color: AppColors.primaryDark),
        shape: const RoundedRectangleBorder(borderRadius: AppRadius.pillBR),
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.primary,
        textStyle: AppTextStyles.label.copyWith(color: AppColors.primary),
      ),
    ),

    dividerTheme: const DividerThemeData(
      color: AppColors.border,
      thickness: 1,
      space: 1,
    ),

    snackBarTheme: SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      backgroundColor: AppColors.primaryDark,
      contentTextStyle: AppTextStyles.bodySmall.copyWith(
        color: AppColors.surface,
        fontWeight: FontWeight.w600,
      ),
      shape: const RoundedRectangleBorder(borderRadius: AppRadius.cardBR),
      insetPadding: const EdgeInsets.all(16),
    ),

    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppColors.primary,
      linearTrackColor: AppColors.tintBlue,
    ),

    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: AppColors.surface,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: AppRadius.sheetBR),
    ),
  );
}
