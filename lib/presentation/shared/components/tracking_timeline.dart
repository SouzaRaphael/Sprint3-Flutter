import 'package:flutter/material.dart';
import 'package:lactarehub/core/theme/app_colors.dart';
import 'package:lactarehub/core/theme/app_spacing.dart';
import 'package:lactarehub/core/theme/app_text_styles.dart';
import 'package:lactarehub/domain/entities/tracking_step.dart';

/// Linha do tempo vertical do percurso do leite doado.
class TrackingTimeline extends StatelessWidget {
  const TrackingTimeline({super.key, required this.steps});

  final List<TrackingStep> steps;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var index = 0; index < steps.length; index++)
          _TimelineRow(
            step: steps[index],
            isLast: index == steps.length - 1,
          ),
      ],
    );
  }
}

class _TimelineRow extends StatelessWidget {
  const _TimelineRow({required this.step, required this.isLast});

  final TrackingStep step;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final isDone = step.status == TrackingStepStatus.concluida;
    final isCurrent = step.status == TrackingStepStatus.atual;
    final isPending = step.status == TrackingStepStatus.pendente;

    final dotColor = switch (step.status) {
      TrackingStepStatus.concluida => AppColors.accent,
      TrackingStepStatus.atual => AppColors.primary,
      TrackingStepStatus.pendente => AppColors.surface,
    };

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: isCurrent ? 20 : 16,
                height: isCurrent ? 20 : 16,
                margin: EdgeInsets.only(top: isCurrent ? 2 : 4),
                decoration: BoxDecoration(
                  color: dotColor,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isPending ? AppColors.accent : dotColor,
                    width: isPending ? 2 : 0,
                  ),
                ),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    color: isDone
                        ? AppColors.accent
                        : AppColors.accent.withValues(alpha: 0.35),
                  ),
                ),
            ],
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : AppSpacing.xl),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    step.title,
                    style: AppTextStyles.label.copyWith(
                      fontSize: 15,
                      color: isPending
                          ? AppColors.inkMuted
                          : AppColors.primaryDark,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(step.description, style: AppTextStyles.caption),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
