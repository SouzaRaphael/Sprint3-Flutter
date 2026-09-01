import 'package:flutter/material.dart';
import 'package:lactarehub/core/theme/app_colors.dart';
import 'package:lactarehub/core/theme/app_radius.dart';
import 'package:lactarehub/core/theme/app_spacing.dart';
import 'package:lactarehub/core/theme/app_text_styles.dart';
import 'package:lactarehub/domain/entities/how_it_works_step.dart';

/// Seção "Em 3 passos você se torna parte da rede".
class HowItWorksSection extends StatelessWidget {
  const HowItWorksSection({
    super.key,
    required this.steps,
    required this.onOpenGuide,
  });

  final List<HowItWorksStep> steps;
  final VoidCallback onOpenGuide;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.bgLanding,
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.section),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: AppSpacing.pageHorizontal,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('COMO FUNCIONA', style: AppTextStyles.overline),
                const SizedBox(height: AppSpacing.md),
                Text.rich(
                  TextSpan(
                    style: AppTextStyles.sectionTitle.copyWith(fontSize: 26),
                    children: [
                      const TextSpan(text: 'Em 3 '),
                      TextSpan(
                        text: 'passos',
                        style: AppTextStyles.sectionTitle.copyWith(
                          fontSize: 26,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      const TextSpan(text: ' você se torna parte da rede.'),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                GestureDetector(
                  // onTap: onOpenGuide,
                  onTap: () => (),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Ver guia completo',
                        style: AppTextStyles.label.copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(
                        Icons.arrow_forward,
                        size: 16,
                        color: AppColors.primary,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          for (final step in steps)
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.page,
                0,
                AppSpacing.page,
                AppSpacing.md,
              ),
              child: _StepCard(step: step),
            ),
        ],
      ),
    );
  }
}

class _StepCard extends StatelessWidget {
  const _StepCard({required this.step});

  final HowItWorksStep step;

  IconData get _icon => switch (step.icon) {
    HowItWorksIcon.pessoa => Icons.person_outline,
    HowItWorksIcon.local => Icons.location_on_outlined,
    HowItWorksIcon.coracao => Icons.favorite_border,
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.xl),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.largeCardBR,
        border: Border.all(color: AppColors.border),
        boxShadow: AppColors.cardShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                step.number,
                style: AppTextStyles.statValue.copyWith(
                  color: AppColors.primaryDeep,
                  fontSize: 26,
                ),
              ),
              Container(
                width: 40,
                height: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.tintBlue,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(_icon, size: 20, color: AppColors.primary),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(step.title, style: AppTextStyles.cardTitleBlue.copyWith(fontSize: 17)),
          const SizedBox(height: AppSpacing.sm),
          Text(step.description, style: AppTextStyles.bodySmall),
        ],
      ),
    );
  }
}
