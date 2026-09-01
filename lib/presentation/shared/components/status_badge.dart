import 'package:flutter/material.dart';
import 'package:lactarehub/core/theme/app_colors.dart';
import 'package:lactarehub/core/theme/app_radius.dart';
import 'package:lactarehub/core/theme/app_text_styles.dart';
import 'package:lactarehub/domain/entities/donation.dart';
import 'package:lactarehub/domain/entities/testimonial.dart';

/// Etiqueta em pílula usada para tipos e situações.
class StatusBadge extends StatelessWidget {
  const StatusBadge({
    super.key,
    required this.label,
    required this.background,
    required this.foreground,
    this.icon,
  });

  /// Etiqueta de tipo de doadora — verde para recorrente, rosa para a
  /// primeira doação, como no design.
  StatusBadge.testimonial(TestimonialType type, {super.key})
    : label = type.label,
      background = type == TestimonialType.recorrente
          ? AppColors.successBg
          : AppColors.pinkBg,
      foreground = type == TestimonialType.recorrente
          ? AppColors.successFg
          : AppColors.pinkFg,
      icon = null;

  /// Etiqueta de situação de uma doação.
  StatusBadge.donation(DonationStatus status, {super.key})
    : label = status.label,
      background = switch (status) {
        DonationStatus.emAnalise ||
        DonationStatus.emAndamento => AppColors.successBg,
        DonationStatus.aprovada => AppColors.tintBlue,
        DonationStatus.distribuida => AppColors.successBg,
      },
      foreground = switch (status) {
        DonationStatus.emAnalise ||
        DonationStatus.emAndamento => AppColors.successFg,
        DonationStatus.aprovada => AppColors.primary,
        DonationStatus.distribuida => AppColors.successFg,
      },
      icon = null;

  final String label;
  final Color background;
  final Color foreground;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: background,
        borderRadius: AppRadius.pillBR,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 13, color: foreground),
            const SizedBox(width: 5),
          ],
          Text(label, style: AppTextStyles.badge.copyWith(color: foreground)),
        ],
      ),
    );
  }
}

/// Indicador "aberto / fechado" com um ponto colorido à esquerda.
class DotStatusLabel extends StatelessWidget {
  const DotStatusLabel({super.key, required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 7,
          height: 7,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 6),
        Text(label, style: AppTextStyles.badge.copyWith(color: color)),
      ],
    );
  }
}
