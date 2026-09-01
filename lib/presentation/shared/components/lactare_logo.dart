import 'package:flutter/material.dart';
import 'package:lactarehub/core/theme/app_colors.dart';
import 'package:lactarehub/core/theme/app_text_styles.dart';

/// Formatos da marca usados no design.
enum LactareLogoVariant {
  /// Círculo azul com a letra L — landing, login e splash.
  circle,

  /// Quadrado arredondado com anel interno — cabeçalho da área da doadora.
  rounded,
}

/// Símbolo do Lactare, opcionalmente acompanhado do nome.
class LactareLogo extends StatelessWidget {
  const LactareLogo({
    super.key,
    this.size = 36,
    this.showWordmark = true,
    this.variant = LactareLogoVariant.circle,
    this.wordmarkColor = AppColors.primary,
  });

  final double size;
  final bool showWordmark;
  final LactareLogoVariant variant;
  final Color wordmarkColor;

  @override
  Widget build(BuildContext context) {
    final mark = switch (variant) {
      LactareLogoVariant.circle => Container(
        width: size,
        height: size,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          color: AppColors.primary,
          shape: BoxShape.circle,
        ),
        child: Text(
          'L',
          style: AppTextStyles.wordmark.copyWith(
            color: AppColors.surface,
            fontSize: size * 0.5,
          ),
        ),
      ),
      LactareLogoVariant.rounded => Container(
        width: size,
        height: size,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(size * 0.3),
        ),
        child: Container(
          width: size * 0.46,
          height: size * 0.46,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.accent, width: size * 0.09),
          ),
        ),
      ),
    };

    if (!showWordmark) return mark;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        mark,
        const SizedBox(width: 10),
        Text(
          'Lactare',
          style: AppTextStyles.wordmark.copyWith(color: wordmarkColor),
        ),
      ],
    );
  }
}
