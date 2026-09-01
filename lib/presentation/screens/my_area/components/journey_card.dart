import 'package:flutter/material.dart';
import 'package:lactarehub/core/theme/app_colors.dart';
import 'package:lactarehub/core/theme/app_radius.dart';
import 'package:lactarehub/core/theme/app_spacing.dart';
import 'package:lactarehub/core/theme/app_text_styles.dart';
import 'package:lactarehub/core/utils/formatters.dart';
import 'package:lactarehub/domain/entities/collection_schedule.dart';
import 'package:lactarehub/domain/entities/donor.dart';

/// Card azul da jornada da doadora, no topo da área pessoal.
class JourneyCard extends StatelessWidget {
  const JourneyCard({
    super.key,
    required this.donor,
    required this.schedule,
  });

  final Donor donor;
  final CollectionSchedule schedule;

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
          Text(
            'SUA JORNADA',
            style: AppTextStyles.overline.copyWith(
              color: AppColors.surface.withValues(alpha: 0.75),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                '${donor.completedDonations}',
                style: AppTextStyles.statValueOnDark.copyWith(fontSize: 38),
              ),
              const SizedBox(width: AppSpacing.sm),
              Text(
                'doações realizadas',
                style: AppTextStyles.body.copyWith(
                  color: AppColors.surface.withValues(alpha: 0.9),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xl),
          Row(
            children: [
              Expanded(
                child: _InnerStat(
                  label: 'Última doação',
                  value: Formatters.daysAgo(donor.daysSinceLastDonation),
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: _InnerStat(
                  label: 'Próximo agendamento',
                  value:
                      '${Formatters.weekdayAndDate(schedule.scheduledAt)} · '
                      '${schedule.scheduledAt.hour}h',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Caixa translúcida dentro do card azul.
class _InnerStat extends StatelessWidget {
  const _InnerStat({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface.withValues(alpha: 0.16),
        borderRadius: AppRadius.inputBR,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: AppTextStyles.caption.copyWith(
              color: AppColors.surface.withValues(alpha: 0.8),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: AppTextStyles.label.copyWith(
              color: AppColors.surface,
              fontSize: 14.5,
            ),
          ),
        ],
      ),
    );
  }
}
