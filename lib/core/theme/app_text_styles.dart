import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lactarehub/core/theme/app_colors.dart';

/// Estilos tipográficos do Lactare.
///
/// Toda a família tipográfica passa por aqui: trocar `_family` é suficiente
/// para mudar a fonte do aplicativo inteiro.
abstract class AppTextStyles {
  static TextStyle _family({
    required double size,
    required FontWeight weight,
    Color color = AppColors.ink,
    double? height,
    double letterSpacing = 0,
    FontStyle? fontStyle,
  }) => GoogleFonts.plusJakartaSans(
    fontSize: size,
    fontWeight: weight,
    color: color,
    height: height,
    letterSpacing: letterSpacing,
    fontStyle: fontStyle,
  );

  // ── Display — headline da landing ────────────────────────────
  static TextStyle get heroTitle =>
      _family(size: 34, weight: FontWeight.w800, height: 1.15, letterSpacing: -0.8);

  static TextStyle get heroTitleAccent => _family(
    size: 34,
    weight: FontWeight.w800,
    height: 1.15,
    letterSpacing: -0.8,
    color: AppColors.primaryDeep,
    fontStyle: FontStyle.italic,
  );

  // ── Títulos ──────────────────────────────────────────────────
  static TextStyle get screenTitle => _family(
    size: 24,
    weight: FontWeight.w800,
    color: AppColors.primaryDark,
    letterSpacing: -0.4,
  );

  static TextStyle get sectionTitle =>
      _family(size: 20, weight: FontWeight.w800, letterSpacing: -0.3);

  static TextStyle get sectionTitleOnBlue => _family(
    size: 20,
    weight: FontWeight.w800,
    color: AppColors.primaryDark,
    letterSpacing: -0.3,
  );

  static TextStyle get cardTitle => _family(size: 16, weight: FontWeight.w700);

  static TextStyle get cardTitleBlue => _family(
    size: 16,
    weight: FontWeight.w700,
    color: AppColors.primaryDark,
  );

  static TextStyle get appBarTitle => _family(
    size: 17,
    weight: FontWeight.w800,
    color: AppColors.primaryDark,
  );

  // ── Corpo ────────────────────────────────────────────────────
  static TextStyle get body => _family(
    size: 15,
    weight: FontWeight.w500,
    color: AppColors.inkMuted,
    height: 1.55,
  );

  static TextStyle get bodySmall => _family(
    size: 13,
    weight: FontWeight.w500,
    color: AppColors.inkMuted,
    height: 1.5,
  );

  static TextStyle get quote => _family(
    size: 14.5,
    weight: FontWeight.w500,
    color: AppColors.inkMuted,
    height: 1.7,
    fontStyle: FontStyle.italic,
  );

  // ── Números e estatísticas ───────────────────────────────────
  static TextStyle get statValue =>
      _family(size: 28, weight: FontWeight.w800, letterSpacing: -0.6);

  static TextStyle get statValueOnDark => _family(
    size: 28,
    weight: FontWeight.w800,
    color: AppColors.surface,
    letterSpacing: -0.6,
  );

  static TextStyle get statLabel => _family(
    size: 12.5,
    weight: FontWeight.w500,
    color: AppColors.inkMuted,
    height: 1.4,
  );

  // ── Rótulos e componentes ────────────────────────────────────
  static TextStyle get label =>
      _family(size: 13.5, weight: FontWeight.w700, color: AppColors.primaryDark);

  static TextStyle get overline => _family(
    size: 11.5,
    weight: FontWeight.w700,
    color: AppColors.inkMuted,
    letterSpacing: 1.4,
  );

  static TextStyle get badge =>
      _family(size: 11.5, weight: FontWeight.w700, letterSpacing: 0.2);

  static TextStyle get chip =>
      _family(size: 13.5, weight: FontWeight.w700, color: AppColors.primary);

  static TextStyle get button => _family(
    size: 15.5,
    weight: FontWeight.w700,
    color: AppColors.surface,
    letterSpacing: 0.1,
  );

  static TextStyle get navItem => _family(
    size: 11,
    weight: FontWeight.w600,
    color: AppColors.navInactive,
  );

  static TextStyle get caption => _family(
    size: 12,
    weight: FontWeight.w500,
    color: AppColors.inkMuted,
  );

  static TextStyle get wordmark => _family(
    size: 21,
    weight: FontWeight.w800,
    color: AppColors.primary,
    letterSpacing: -0.4,
  );
}
