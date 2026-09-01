import 'package:flutter/material.dart';
import 'package:lactarehub/core/theme/app_colors.dart';
import 'package:lactarehub/core/theme/app_radius.dart';
import 'package:lactarehub/core/theme/app_spacing.dart';
import 'package:lactarehub/core/theme/app_text_styles.dart';
import 'package:lactarehub/domain/entities/achievement.dart';

/// Grade de medalhas da trilha da doadora.
class AchievementsGrid extends StatelessWidget {
  const AchievementsGrid({
    super.key,
    required this.achievements,
    required this.onTap,
  });

  final List<Achievement> achievements;
  final ValueChanged<Achievement> onTap;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: AppSpacing.md,
        crossAxisSpacing: AppSpacing.md,
        childAspectRatio: 0.82,
      ),
      itemCount: achievements.length,
      itemBuilder: (context, index) =>
          _AchievementTile(achievement: achievements[index], onTap: onTap),
    );
  }
}

class _AchievementTile extends StatelessWidget {
  const _AchievementTile({required this.achievement, required this.onTap});

  final Achievement achievement;
  final ValueChanged<Achievement> onTap;

  IconData get _icon => switch (achievement.icon) {
    AchievementIcon.gota => Icons.water_drop_outlined,
    AchievementIcon.medalha => Icons.workspace_premium_outlined,
    AchievementIcon.estrela => Icons.star_border,
    AchievementIcon.coracao => Icons.favorite_border,
    AchievementIcon.folha => Icons.eco_outlined,
    AchievementIcon.brilho => Icons.auto_awesome_outlined,
  };

  Color get _labelColor => switch (achievement.status) {
    AchievementStatus.conquistada => AppColors.primary,
    AchievementStatus.emProgresso => AppColors.inkMuted,
    AchievementStatus.bloqueada => AppColors.navInactive,
  };

  @override
  Widget build(BuildContext context) {
    final isLocked = achievement.status == AchievementStatus.bloqueada;
    final gradient =
        AppColors.avatarGradients[achievement.gradientIndex %
            AppColors.avatarGradients.length];

    return Material(
      color: AppColors.surface,
      borderRadius: AppRadius.cardBR,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => onTap(achievement),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.sm,
            vertical: AppSpacing.md,
          ),
          decoration: BoxDecoration(
            borderRadius: AppRadius.cardBR,
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 50,
                height: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isLocked ? AppColors.bgApp : null,
                  gradient: isLocked
                      ? null
                      : LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: gradient,
                        ),
                ),
                child: Icon(
                  isLocked ? Icons.lock_outline : _icon,
                  size: 22,
                  color: isLocked ? AppColors.navInactive : AppColors.surface,
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                achievement.title,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.badge.copyWith(
                  color: isLocked ? AppColors.inkMuted : AppColors.primaryDark,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                achievement.progressLabel,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.caption.copyWith(
                  color: _labelColor,
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
