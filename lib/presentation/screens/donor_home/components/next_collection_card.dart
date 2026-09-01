import 'package:flutter/material.dart';
import 'package:lactarehub/core/theme/app_colors.dart';
import 'package:lactarehub/core/theme/app_radius.dart';
import 'package:lactarehub/core/theme/app_spacing.dart';
import 'package:lactarehub/core/theme/app_text_styles.dart';
import 'package:lactarehub/core/utils/formatters.dart';
import 'package:lactarehub/domain/entities/collection_schedule.dart';

/// Card azul em gradiente com a próxima coleta e suas duas ações.
class NextCollectionCard extends StatelessWidget {
  const NextCollectionCard({
    super.key,
    required this.schedule,
    required this.isConfirming,
    required this.onConfirm,
    required this.onReschedule,
  });

  final CollectionSchedule schedule;
  final bool isConfirming;
  final VoidCallback onConfirm;
  final VoidCallback onReschedule;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.xl),
      decoration: BoxDecoration(
        gradient: AppColors.heroCard,
        borderRadius: AppRadius.largeCardBR,
        boxShadow: AppColors.buttonShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'PRÓXIMA COLETA',
                      style: AppTextStyles.overline.copyWith(
                        color: AppColors.surface.withValues(alpha: 0.75),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Text(
                      '${Formatters.weekdayAndDate(schedule.scheduledAt)} · '
                      '${schedule.scheduledAt.hour}h',
                      style: AppTextStyles.statValueOnDark.copyWith(
                        fontSize: 23,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          size: 15,
                          color: AppColors.surface.withValues(alpha: 0.85),
                        ),
                        const SizedBox(width: 5),
                        Flexible(
                          child: Text(
                            schedule.summary,
                            style: AppTextStyles.bodySmall.copyWith(
                              color: AppColors.surface.withValues(alpha: 0.9),
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              _DateBadge(date: schedule.scheduledAt),
            ],
          ),
          const SizedBox(height: AppSpacing.xl),
          Row(
            children: [
              Expanded(
                child: _CardAction(
                  label: schedule.isConfirmed ? 'Confirmada' : 'Confirmar',
                  icon: schedule.isConfirmed ? Icons.check : null,
                  isLoading: isConfirming,
                  isPrimary: true,
                  onPressed: schedule.isConfirmed ? null : onConfirm,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: _CardAction(
                  label: 'Reagendar',
                  isPrimary: false,
                  onPressed: onReschedule,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Selo com mês e dia, no canto do card.
class _DateBadge extends StatelessWidget {
  const _DateBadge({required this.date});

  final DateTime date;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 56,
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.surface.withValues(alpha: 0.18),
        borderRadius: AppRadius.inputBR,
      ),
      child: Column(
        children: [
          Text(
            Formatters.monthBadge(date),
            style: AppTextStyles.badge.copyWith(
              color: AppColors.surface.withValues(alpha: 0.85),
              fontSize: 10,
            ),
          ),
          Text(
            date.day.toString().padLeft(2, '0'),
            style: AppTextStyles.statValueOnDark.copyWith(fontSize: 22),
          ),
        ],
      ),
    );
  }
}

/// Botão interno do card, em branco sólido ou translúcido.
class _CardAction extends StatelessWidget {
  const _CardAction({
    required this.label,
    required this.isPrimary,
    required this.onPressed,
    this.icon,
    this.isLoading = false,
  });

  final String label;
  final bool isPrimary;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final background = isPrimary
        ? AppColors.surface
        : AppColors.surface.withValues(alpha: 0.22);
    final foreground = isPrimary ? AppColors.primaryDark : AppColors.surface;

    return Material(
      color: background,
      borderRadius: AppRadius.pillBR,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: isLoading ? null : onPressed,
        child: SizedBox(
          height: 46,
          child: Center(
            child: isLoading
                ? SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.2,
                      color: foreground,
                    ),
                  )
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (icon != null) ...[
                        Icon(icon, size: 17, color: foreground),
                        const SizedBox(width: 6),
                      ],
                      Text(
                        label,
                        style: AppTextStyles.label.copyWith(
                          color: foreground,
                          fontSize: 14.5,
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
