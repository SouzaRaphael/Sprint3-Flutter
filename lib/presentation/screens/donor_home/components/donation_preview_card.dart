import 'package:flutter/material.dart';
import 'package:lactarehub/core/theme/app_colors.dart';
import 'package:lactarehub/core/theme/app_radius.dart';
import 'package:lactarehub/core/theme/app_spacing.dart';
import 'package:lactarehub/core/theme/app_text_styles.dart';
import 'package:lactarehub/core/utils/formatters.dart';
import 'package:lactarehub/domain/entities/donation.dart';
import 'package:lactarehub/presentation/shared/components/status_badge.dart';

/// Cartão de uma doação em rastreamento. Tocar abre os detalhes com a
/// linha do tempo completa.
class DonationPreviewCard extends StatelessWidget {
  const DonationPreviewCard({
    super.key,
    required this.donation,
    required this.onTap,
  });

  final Donation donation;
  final ValueChanged<Donation> onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      borderRadius: AppRadius.largeCardBR,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => onTap(donation),
        child: Container(
          padding: const EdgeInsets.all(AppSpacing.lg),
          decoration: BoxDecoration(
            borderRadius: AppRadius.largeCardBR,
            border: Border.all(color: AppColors.border),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Doação #${donation.code}',
                      style: AppTextStyles.caption,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Coletada em '
                      '${Formatters.paddedDate(donation.collectedAt)} · '
                      '${Formatters.volume(donation.volumeMilliliters)}',
                      style: AppTextStyles.cardTitleBlue.copyWith(fontSize: 15),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              StatusBadge.donation(donation.status),
            ],
          ),
        ),
      ),
    );
  }
}

/// Mensagem da equipe do banco de leite, em destaque azul-claro.
class TeamMessageCard extends StatelessWidget {
  const TeamMessageCard({
    super.key,
    required this.donorFirstName,
    required this.hospital,
  });

  final String donorFirstName;
  final String hospital;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.tintBlue,
        borderRadius: AppRadius.largeCardBR,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 38,
            height: 38,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(11),
            ),
            child: const Icon(
              Icons.favorite,
              size: 18,
              color: AppColors.surface,
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Da equipe Lactare', style: AppTextStyles.label),
                const SizedBox(height: 6),
                Text(
                  '$donorFirstName, sua última doação ajudou um bebê na '
                  '$hospital. Cada gota conta.',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.primaryDark,
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
