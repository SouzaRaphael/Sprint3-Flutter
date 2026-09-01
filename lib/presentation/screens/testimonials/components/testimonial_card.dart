import 'package:flutter/material.dart';
import 'package:lactarehub/core/theme/app_colors.dart';
import 'package:lactarehub/core/theme/app_radius.dart';
import 'package:lactarehub/core/theme/app_spacing.dart';
import 'package:lactarehub/core/theme/app_text_styles.dart';
import 'package:lactarehub/domain/entities/testimonial.dart';
import 'package:lactarehub/presentation/shared/components/avatar_circle.dart';
import 'package:lactarehub/presentation/shared/components/primary_button.dart';
import 'package:lactarehub/presentation/shared/components/status_badge.dart';

/// Depoimento de uma doadora: avatar, autoria, etiqueta e citação.
class TestimonialCard extends StatelessWidget {
  const TestimonialCard({super.key, required this.testimonial});

  final Testimonial testimonial;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.largeCardBR,
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AvatarCircle(
                name: testimonial.authorName,
                gradientIndex: testimonial.avatarGradientIndex,
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      testimonial.authorName,
                      style: AppTextStyles.cardTitleBlue.copyWith(fontSize: 15),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      testimonial.cityAndState,
                      style: AppTextStyles.caption,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              StatusBadge.testimonial(testimonial.type),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.format_quote,
                size: 18,
                color: AppColors.accent,
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(testimonial.message, style: AppTextStyles.quote),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Convite, ao fim da lista, para a doadora publicar sua própria história.
class ShareStoryCard extends StatelessWidget {
  const ShareStoryCard({super.key, required this.onWrite});

  final VoidCallback onWrite;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.xl),
      decoration: BoxDecoration(
        color: AppColors.tintBlue,
        borderRadius: AppRadius.largeCardBR,
      ),
      child: Column(
        children: [
          const Icon(
            Icons.chat_bubble_outline,
            size: 30,
            color: AppColors.primary,
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            'Compartilhe sua história',
            style: AppTextStyles.sectionTitle.copyWith(fontSize: 19),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'Sua jornada inspira outras pessoas a serem doadoras.',
            textAlign: TextAlign.center,
            style: AppTextStyles.bodySmall,
          ),
          const SizedBox(height: AppSpacing.lg),
          PrimaryButton(
            label: 'Escrever depoimento',
            icon: Icons.edit_outlined,
            showTrailingIcon: false,
            expand: false,
            onPressed: onWrite,
          ),
        ],
      ),
    );
  }
}
