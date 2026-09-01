import 'package:flutter/material.dart';
import 'package:lactarehub/core/theme/app_colors.dart';
import 'package:lactarehub/core/theme/app_text_styles.dart';

/// Título de seção, com sobrelinha e ação opcionais.
class SectionTitle extends StatelessWidget {
  const SectionTitle({
    super.key,
    required this.title,
    this.overline,
    this.actionLabel,
    this.onAction,
    this.color = AppColors.primaryDark,
  });

  final String title;

  /// Rótulo em maiúsculas acima do título, como "COMO FUNCIONA".
  final String? overline;
  final String? actionLabel;
  final VoidCallback? onAction;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (overline != null) ...[
                Text(overline!.toUpperCase(), style: AppTextStyles.overline),
                const SizedBox(height: 8),
              ],
              Text(
                title,
                style: AppTextStyles.sectionTitle.copyWith(color: color),
              ),
            ],
          ),
        ),
        if (actionLabel != null && onAction != null)
          TextButton(
            onPressed: onAction,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  actionLabel!,
                  style: AppTextStyles.label.copyWith(color: AppColors.primary),
                ),
                const SizedBox(width: 4),
                const Icon(
                  Icons.arrow_forward,
                  size: 16,
                  color: AppColors.primary,
                ),
              ],
            ),
          ),
      ],
    );
  }
}
