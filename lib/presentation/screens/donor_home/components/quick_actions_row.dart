import 'package:flutter/material.dart';
import 'package:lactarehub/core/theme/app_colors.dart';
import 'package:lactarehub/core/theme/app_spacing.dart';
import 'package:lactarehub/core/theme/app_text_styles.dart';

/// Uma das quatro entradas rápidas abaixo do card de coleta.
class QuickAction {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  /// A primeira ação recebe o azul cheio no design.
  final bool isHighlighted;

  const QuickAction({
    required this.icon,
    required this.label,
    required this.onTap,
    this.isHighlighted = false,
  });
}

/// Fileira de atalhos da home da doadora.
class QuickActionsRow extends StatelessWidget {
  const QuickActionsRow({super.key, required this.actions});

  final List<QuickAction> actions;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final action in actions)
          Expanded(child: _QuickActionButton(action: action)),
      ],
    );
  }
}

class _QuickActionButton extends StatelessWidget {
  const _QuickActionButton({required this.action});

  final QuickAction action;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: action.onTap,
      borderRadius: BorderRadius.circular(AppSpacing.lg),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
        child: Column(
          children: [
            Container(
              width: 54,
              height: 54,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: action.isHighlighted
                    ? AppColors.accent
                    : AppColors.tintBlue,
                borderRadius: BorderRadius.circular(AppSpacing.lg),
              ),
              child: Icon(
                action.icon,
                size: 24,
                color: action.isHighlighted
                    ? AppColors.surface
                    : AppColors.primary,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              action.label,
              textAlign: TextAlign.center,
              style: AppTextStyles.caption.copyWith(
                color: AppColors.primaryDark,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
