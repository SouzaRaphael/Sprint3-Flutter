import 'package:flutter/material.dart';
import 'package:lactarehub/core/theme/app_colors.dart';
import 'package:lactarehub/core/theme/app_radius.dart';
import 'package:lactarehub/core/theme/app_spacing.dart';
import 'package:lactarehub/core/theme/app_text_styles.dart';
import 'package:lactarehub/core/utils/formatters.dart';
import 'package:lactarehub/domain/entities/donor.dart';
import 'package:lactarehub/presentation/shared/components/stat_tile.dart';

/// Resumo do impacto pessoal da doadora, com a faixa de sequência embaixo.
class ImpactSummaryCard extends StatelessWidget {
  const ImpactSummaryCard({
    super.key,
    required this.donor,
    required this.onOpenAchievements,
  });

  final Donor donor;
  final VoidCallback onOpenAchievements;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.largeCardBR,
        border: Border.all(color: AppColors.border),
        boxShadow: AppColors.cardShadow,
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.lg,
              vertical: AppSpacing.xl,
            ),
            child: IntrinsicHeight(
              child: Row(
                children: [
                  Expanded(
                    child: StatTile(
                      value: '${donor.completedDonations}',
                      label: 'doações',
                      alignment: CrossAxisAlignment.center,
                    ),
                  ),
                  const VerticalDivider(width: 1),
                  Expanded(
                    child: StatTile(
                      value: Formatters.liters(donor.donatedMilliliters),
                      label: 'doados',
                      alignment: CrossAxisAlignment.center,
                    ),
                  ),
                  const VerticalDivider(width: 1),
                  Expanded(
                    child: StatTile(
                      value: '~${donor.babiesReached}',
                      label: 'bebês alcançados',
                      valueColor: AppColors.pinkStrong,
                      alignment: CrossAxisAlignment.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Divider(height: 1),
          InkWell(
            onTap: onOpenAchievements,
            borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(AppRadius.xl),
            ),
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: AppColors.pinkBg,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.local_fire_department_outlined,
                      size: 20,
                      color: AppColors.pinkFg,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${donor.streakWeeks} semanas seguidas doando',
                          style: AppTextStyles.label,
                        ),
                        const SizedBox(height: 3),
                        Text(
                          'Falta ${donor.donationsToNextBadge} doação para a '
                          'próxima medalha.',
                          style: AppTextStyles.caption,
                        ),
                      ],
                    ),
                  ),
                  const Icon(
                    Icons.arrow_forward,
                    size: 18,
                    color: AppColors.navInactive,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
