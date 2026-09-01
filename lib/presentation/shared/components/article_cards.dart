import 'package:flutter/material.dart';
import 'package:lactarehub/core/theme/app_colors.dart';
import 'package:lactarehub/core/theme/app_radius.dart';
import 'package:lactarehub/core/theme/app_spacing.dart';
import 'package:lactarehub/core/theme/app_text_styles.dart';
import 'package:lactarehub/domain/entities/article.dart';
import 'package:lactarehub/presentation/shared/components/status_badge.dart';

/// Card grande da aba Conteúdo: capa colorida, título, resumo e tempo.
class ArticleCard extends StatelessWidget {
  const ArticleCard({super.key, required this.article, required this.onTap});

  final Article article;
  final ValueChanged<Article> onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      borderRadius: AppRadius.largeCardBR,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => onTap(article),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: AppRadius.largeCardBR,
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(height: 110, color: article.coverColor),
              Padding(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      article.title,
                      style: AppTextStyles.cardTitleBlue.copyWith(fontSize: 16),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(article.summary, style: AppTextStyles.bodySmall),
                    const SizedBox(height: AppSpacing.md),
                    Row(
                      children: [
                        const Icon(
                          Icons.schedule,
                          size: 14,
                          color: AppColors.navInactive,
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: Text(
                            article.readingLabel,
                            style: AppTextStyles.caption,
                          ),
                        ),
                        const Icon(
                          Icons.arrow_forward,
                          size: 17,
                          color: AppColors.primary,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Card estreito do carrossel "Para ler nesta semana".
class ArticleCarouselCard extends StatelessWidget {
  const ArticleCarouselCard({
    super.key,
    required this.article,
    required this.onTap,
    this.width = 240,
  });

  final Article article;
  final ValueChanged<Article> onTap;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Material(
        color: AppColors.surface,
        borderRadius: AppRadius.largeCardBR,
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () => onTap(article),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: AppRadius.largeCardBR,
              border: Border.all(color: AppColors.border),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(height: 79, color: article.coverColor),
                Padding(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      StatusBadge(
                        label: article.category.label,
                        background: AppColors.bgApp,
                        foreground: AppColors.inkMuted,
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      Text(
                        article.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.cardTitleBlue.copyWith(
                          fontSize: 14.5,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          const Icon(
                            Icons.schedule,
                            size: 13,
                            color: AppColors.navInactive,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${article.readingMinutes} min',
                            style: AppTextStyles.caption,
                          ),
                        ],
                      ),
                    ],
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

/// Linha compacta usada na lista de leituras da área da doadora.
class ArticleListTile extends StatelessWidget {
  const ArticleListTile({
    super.key,
    required this.article,
    required this.onTap,
  });

  final Article article;
  final ValueChanged<Article> onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      borderRadius: AppRadius.cardBR,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => onTap(article),
        child: Container(
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            borderRadius: AppRadius.cardBR,
            border: Border.all(color: AppColors.border),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 66,
                height: 66,
                decoration: BoxDecoration(
                  color: article.coverColor,
                  borderRadius: BorderRadius.circular(AppRadius.md),
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    StatusBadge(
                      label: article.category.label,
                      background: AppColors.bgApp,
                      foreground: AppColors.inkMuted,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      article.title,
                      style: AppTextStyles.cardTitleBlue.copyWith(
                        fontSize: 14.5,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        const Icon(
                          Icons.schedule,
                          size: 13,
                          color: AppColors.navInactive,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${article.readingMinutes} min',
                          style: AppTextStyles.caption,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
