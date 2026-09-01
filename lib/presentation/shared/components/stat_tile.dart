import 'package:flutter/material.dart';
import 'package:lactarehub/core/theme/app_colors.dart';
import 'package:lactarehub/core/theme/app_text_styles.dart';

/// Par número + legenda usado nas estatísticas da rede e do impacto pessoal.
class StatTile extends StatelessWidget {
  const StatTile({
    super.key,
    required this.value,
    required this.label,
    this.onDark = false,
    this.valueColor,
    this.alignment = CrossAxisAlignment.start,
  });

  final String value;
  final String label;

  /// Ajusta as cores para a faixa escura da landing.
  final bool onDark;
  final Color? valueColor;
  final CrossAxisAlignment alignment;

  @override
  Widget build(BuildContext context) {
    final baseValueStyle = onDark
        ? AppTextStyles.statValueOnDark
        : AppTextStyles.statValue;

    return Column(
      crossAxisAlignment: alignment,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          value,
          style: valueColor == null
              ? baseValueStyle
              : baseValueStyle.copyWith(color: valueColor),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          textAlign: alignment == CrossAxisAlignment.center
              ? TextAlign.center
              : TextAlign.start,
          style: onDark
              ? AppTextStyles.statLabel.copyWith(
                  color: AppColors.surface.withValues(alpha: 0.72),
                )
              : AppTextStyles.statLabel,
        ),
      ],
    );
  }
}
