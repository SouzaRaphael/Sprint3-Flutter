import 'package:flutter/material.dart';
import 'package:lactarehub/core/theme/app_colors.dart';
import 'package:lactarehub/core/theme/app_radius.dart';
import 'package:lactarehub/core/theme/app_spacing.dart';
import 'package:lactarehub/core/theme/app_text_styles.dart';

/// Card que ocupa o lugar de um conteúdo que ainda não existe.
///
/// Quem acaba de se cadastrar não tem coleta agendada nem doação a rastrear;
/// em vez de esconder as seções, elas explicam o que fará o conteúdo aparecer.
class EmptyStateCard extends StatelessWidget {
  const EmptyStateCard({
    super.key,
    required this.icon,
    required this.title,
    required this.message,
    this.actionLabel,
    this.onAction,
    this.onDarkBackground = false,
  });

  final IconData icon;
  final String title;
  final String message;
  final String? actionLabel;
  final VoidCallback? onAction;

  /// Usa o gradiente azul dos cards de destaque, para substituir o card da
  /// próxima coleta sem abrir um buraco visual no topo da tela.
  final bool onDarkBackground;

  @override
  Widget build(BuildContext context) {
    final foreground = onDarkBackground
        ? AppColors.surface
        : AppColors.primaryDark;
    final secondary = onDarkBackground
        ? AppColors.surface.withValues(alpha: 0.85)
        : AppColors.inkMuted;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.xl),
      decoration: BoxDecoration(
        color: onDarkBackground ? null : AppColors.surface,
        gradient: onDarkBackground ? AppColors.heroCard : null,
        borderRadius: AppRadius.largeCardBR,
        border: onDarkBackground
            ? null
            : Border.all(color: AppColors.border),
        boxShadow: onDarkBackground
            ? AppColors.buttonShadow
            : AppColors.cardShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 44,
            height: 44,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: onDarkBackground
                  ? AppColors.surface.withValues(alpha: 0.18)
                  : AppColors.tintBlue,
              borderRadius: BorderRadius.circular(13),
            ),
            child: Icon(
              icon,
              size: 22,
              color: onDarkBackground ? AppColors.surface : AppColors.primary,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            title,
            style: AppTextStyles.cardTitleBlue.copyWith(
              fontSize: 17,
              color: foreground,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            message,
            style: AppTextStyles.bodySmall.copyWith(color: secondary),
          ),
          if (actionLabel != null && onAction != null) ...[
            const SizedBox(height: AppSpacing.lg),
            _CardAction(
              label: actionLabel!,
              onPressed: onAction!,
              onDarkBackground: onDarkBackground,
            ),
          ],
        ],
      ),
    );
  }
}

/// Botão em pílula que se adapta ao fundo claro ou ao gradiente azul.
class _CardAction extends StatelessWidget {
  const _CardAction({
    required this.label,
    required this.onPressed,
    required this.onDarkBackground,
  });

  final String label;
  final VoidCallback onPressed;
  final bool onDarkBackground;

  @override
  Widget build(BuildContext context) {
    final background = onDarkBackground
        ? AppColors.surface
        : AppColors.primary;
    final foreground = onDarkBackground
        ? AppColors.primaryDark
        : AppColors.surface;

    return Material(
      color: background,
      borderRadius: AppRadius.pillBR,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.xl,
            vertical: AppSpacing.md,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: AppTextStyles.label.copyWith(
                  color: foreground,
                  fontSize: 14.5,
                ),
              ),
              const SizedBox(width: 8),
              Icon(Icons.arrow_forward, size: 17, color: foreground),
            ],
          ),
        ),
      ),
    );
  }
}
