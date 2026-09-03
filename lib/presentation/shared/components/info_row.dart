import 'package:flutter/material.dart';
import 'package:lactarehub/core/theme/app_colors.dart';
import 'package:lactarehub/core/theme/app_spacing.dart';
import 'package:lactarehub/core/theme/app_text_styles.dart';

/// Linha de informação: ícone em quadrado azul-claro, rótulo e valor.
///
/// Usada no detalhe do ponto de coleta e nos cards da tela de perfil.
class InfoRow extends StatelessWidget {
  const InfoRow({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    this.bottomSpacing = AppSpacing.lg,
  });

  final IconData icon;
  final String label;
  final String value;
  final double bottomSpacing;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: bottomSpacing),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 38,
            height: 38,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.tintBlue,
              borderRadius: BorderRadius.circular(11),
            ),
            child: Icon(icon, size: 19, color: AppColors.primary),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: AppTextStyles.caption),
                const SizedBox(height: 3),
                Text(
                  value.trim().isEmpty ? '—' : value,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.ink,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
