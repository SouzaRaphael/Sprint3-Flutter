import 'package:flutter/material.dart';
import 'package:lactarehub/core/theme/app_colors.dart';
import 'package:lactarehub/core/theme/app_text_styles.dart';
import 'package:lactarehub/core/utils/formatters.dart';

/// Avatar em gradiente com as iniciais — o design não usa fotografias.
class AvatarCircle extends StatelessWidget {
  const AvatarCircle({
    super.key,
    required this.name,
    required this.gradientIndex,
    this.size = 44,
    this.showInitials = true,
  });

  final String name;
  final int gradientIndex;
  final double size;
  final bool showInitials;

  @override
  Widget build(BuildContext context) {
    final colors =
        AppColors.avatarGradients[gradientIndex %
            AppColors.avatarGradients.length];

    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: colors,
        ),
      ),
      child: showInitials
          ? Text(
              Formatters.initials(name),
              style: AppTextStyles.badge.copyWith(
                color: AppColors.surface,
                fontSize: size * 0.34,
              ),
            )
          : null,
    );
  }
}

/// Círculo branco com sigla de estado, empilhado no hero da landing.
class StateAvatar extends StatelessWidget {
  const StateAvatar({super.key, required this.state, this.size = 36});

  final String state;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.surface,
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.border, width: 1.5),
      ),
      child: Text(
        state,
        style: AppTextStyles.badge.copyWith(
          color: AppColors.primaryDark,
          fontSize: size * 0.3,
        ),
      ),
    );
  }
}
