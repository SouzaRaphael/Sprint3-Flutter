import 'package:flutter/material.dart';
import 'package:lactarehub/core/theme/app_colors.dart';
import 'package:lactarehub/core/theme/app_radius.dart';
import 'package:lactarehub/core/theme/app_spacing.dart';
import 'package:lactarehub/core/theme/app_text_styles.dart';

/// Convite para indicar outra nutriz à rede.
class ReferralCard extends StatelessWidget {
  const ReferralCard({super.key, required this.onInvite});

  final VoidCallback onInvite;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.tintBlue,
        borderRadius: AppRadius.largeCardBR,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 52,
            height: 52,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.pinkStrong,
              borderRadius: BorderRadius.circular(AppRadius.md),
            ),
            child: const Icon(
              Icons.card_giftcard,
              size: 25,
              color: AppColors.surface,
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Indique uma amiga',
                  style: AppTextStyles.cardTitleBlue.copyWith(fontSize: 15.5),
                ),
                const SizedBox(height: 4),
                Text(
                  'Cada pessoa que você convidar amplia a rede de cuidado.',
                  style: AppTextStyles.caption,
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Material(
            color: AppColors.accent,
            shape: const CircleBorder(),
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: onInvite,
              child: const SizedBox(
                width: 44,
                height: 44,
                child: Icon(Icons.send, size: 19, color: AppColors.surface),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
