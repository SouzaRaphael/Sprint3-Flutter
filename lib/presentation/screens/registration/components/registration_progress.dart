import 'package:flutter/material.dart';
import 'package:lactarehub/core/theme/app_colors.dart';
import 'package:lactarehub/core/theme/app_spacing.dart';
import 'package:lactarehub/core/theme/app_text_styles.dart';

/// Barra segmentada do topo do cadastro, com o texto "Etapa X de Y".
class RegistrationProgress extends StatelessWidget {
  const RegistrationProgress({
    super.key,
    required this.currentStep,
    required this.totalSteps,
  });

  final int currentStep;
  final int totalSteps;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            for (var index = 0; index < totalSteps; index++) ...[
              Expanded(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  height: 5,
                  decoration: BoxDecoration(
                    color: index < currentStep
                        ? AppColors.primary
                        : AppColors.tintBlue,
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
              if (index < totalSteps - 1) const SizedBox(width: AppSpacing.sm),
            ],
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        Text.rich(
          TextSpan(
            style: AppTextStyles.bodySmall,
            children: [
              const TextSpan(text: 'Etapa '),
              TextSpan(
                text: '$currentStep',
                style: AppTextStyles.label.copyWith(color: AppColors.primary),
              ),
              TextSpan(text: ' de $totalSteps'),
            ],
          ),
        ),
      ],
    );
  }
}
