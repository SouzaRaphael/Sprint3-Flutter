import 'package:flutter/material.dart';
import 'package:lactarehub/core/theme/app_colors.dart';
import 'package:lactarehub/core/theme/app_radius.dart';
import 'package:lactarehub/core/theme/app_spacing.dart';
import 'package:lactarehub/core/theme/app_text_styles.dart';
import 'package:lactarehub/core/utils/formatters.dart';
import 'package:lactarehub/domain/entities/donation.dart';
import 'package:lactarehub/presentation/shared/components/app_top_bar.dart';
import 'package:lactarehub/presentation/shared/components/section_title.dart';
import 'package:lactarehub/presentation/shared/components/stat_tile.dart';
import 'package:lactarehub/presentation/shared/components/status_badge.dart';
import 'package:lactarehub/presentation/shared/components/tracking_timeline.dart';

/// Rastreamento completo de uma doação.
///
/// Recebe a [Donation] por `settings.arguments`, a partir da home ou da
/// área da doadora.
class DonationDetailScreen extends StatelessWidget {
  const DonationDetailScreen({
    super.key,
    required this.donation,
    required this.goBack,
  });

  final Donation donation;
  final VoidCallback goBack;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgApp,
      body: SafeArea(
        child: Column(
          children: [
            AppTopBar(title: 'Doação #${donation.code}', onBack: goBack),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.page,
                  AppSpacing.xl,
                  AppSpacing.page,
                  AppSpacing.section,
                ),
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          'Coletada em '
                          '${Formatters.paddedDate(donation.collectedAt)}',
                          style: AppTextStyles.heroTitle.copyWith(fontSize: 24),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.md),
                      StatusBadge.donation(donation.status),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: AppSpacing.xl,
                      horizontal: AppSpacing.lg,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: AppRadius.largeCardBR,
                      border: Border.all(color: AppColors.border),
                    ),
                    child: IntrinsicHeight(
                      child: Row(
                        children: [
                          Expanded(
                            child: StatTile(
                              value: Formatters.volume(
                                donation.volumeMilliliters,
                              ),
                              label: 'volume doado',
                              alignment: CrossAxisAlignment.center,
                            ),
                          ),
                          const VerticalDivider(width: 1),
                          Expanded(
                            child: StatTile(
                              value: '${donation.timeline.length}',
                              label: 'etapas de rastreio',
                              alignment: CrossAxisAlignment.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  _InfoTile(
                    icon: Icons.place_outlined,
                    label: 'Origem',
                    value: donation.collectionPlace,
                  ),
                  _InfoTile(
                    icon: Icons.local_hospital_outlined,
                    label: 'Destino',
                    value: donation.destinationHospital,
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  const SectionTitle(title: 'Percurso do seu leite'),
                  const SizedBox(height: AppSpacing.xl),
                  Container(
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: AppRadius.largeCardBR,
                      border: Border.all(color: AppColors.border),
                    ),
                    child: TrackingTimeline(steps: donation.timeline),
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  Container(
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    decoration: BoxDecoration(
                      color: AppColors.tintBlue,
                      borderRadius: AppRadius.cardBR,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.science_outlined,
                          size: 20,
                          color: AppColors.primary,
                        ),
                        const SizedBox(width: AppSpacing.md),
                        Expanded(
                          child: Text(
                            'Todo lote é pasteurizado a 62,5 °C por trinta '
                            'minutos e analisado antes de chegar à unidade '
                            'neonatal.',
                            style: AppTextStyles.bodySmall.copyWith(
                              color: AppColors.primaryDark,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  const _InfoTile({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 19, color: AppColors.primary),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: AppTextStyles.caption),
                const SizedBox(height: 2),
                Text(
                  value,
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
