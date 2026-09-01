import 'package:flutter/material.dart';
import 'package:lactarehub/core/theme/app_colors.dart';
import 'package:lactarehub/core/theme/app_radius.dart';
import 'package:lactarehub/core/theme/app_spacing.dart';
import 'package:lactarehub/core/theme/app_text_styles.dart';
import 'package:lactarehub/core/utils/formatters.dart';
import 'package:lactarehub/domain/entities/collection_schedule.dart';

/// Escolha da modalidade de entrega do leite.
class ModeSelector extends StatelessWidget {
  const ModeSelector({
    super.key,
    required this.selected,
    required this.onSelected,
  });

  final CollectionMode selected;
  final ValueChanged<CollectionMode> onSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (final mode in CollectionMode.values)
          Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.sm),
            child: _ModeTile(
              mode: mode,
              isSelected: mode == selected,
              onTap: () => onSelected(mode),
            ),
          ),
      ],
    );
  }
}

class _ModeTile extends StatelessWidget {
  const _ModeTile({
    required this.mode,
    required this.isSelected,
    required this.onTap,
  });

  final CollectionMode mode;
  final bool isSelected;
  final VoidCallback onTap;

  IconData get _icon => switch (mode) {
    CollectionMode.domiciliar => Icons.home_outlined,
    CollectionMode.postoDeColeta => Icons.storefront_outlined,
    CollectionMode.banco => Icons.local_hospital_outlined,
  };

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isSelected ? AppColors.tintBlue : AppColors.surface,
      borderRadius: AppRadius.cardBR,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(AppSpacing.lg),
          decoration: BoxDecoration(
            borderRadius: AppRadius.cardBR,
            border: Border.all(
              color: isSelected ? AppColors.accent : AppColors.border,
              width: isSelected ? 1.6 : 1,
            ),
          ),
          child: Row(
            children: [
              Icon(_icon, size: 22, color: AppColors.primary),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(mode.label, style: AppTextStyles.label),
                    const SizedBox(height: 3),
                    Text(mode.description, style: AppTextStyles.caption),
                  ],
                ),
              ),
              Icon(
                isSelected
                    ? Icons.radio_button_checked
                    : Icons.radio_button_unchecked,
                size: 20,
                color: isSelected ? AppColors.primary : AppColors.border,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Fita horizontal de datas disponíveis.
class DateStrip extends StatelessWidget {
  const DateStrip({
    super.key,
    required this.dates,
    required this.selected,
    required this.onSelected,
  });

  final List<DateTime> dates;
  final DateTime? selected;
  final ValueChanged<DateTime> onSelected;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 78,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: dates.length,
        separatorBuilder: (_, _) => const SizedBox(width: AppSpacing.sm),
        itemBuilder: (context, index) {
          final date = dates[index];
          final isSelected =
              selected != null &&
              selected!.day == date.day &&
              selected!.month == date.month;

          return Material(
            color: isSelected ? AppColors.primary : AppColors.surface,
            borderRadius: AppRadius.cardBR,
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: () => onSelected(date),
              child: Container(
                width: 62,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: AppRadius.cardBR,
                  border: Border.all(
                    color: isSelected ? AppColors.primary : AppColors.border,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      Formatters.weekdayAndDate(date).split(',').first,
                      style: AppTextStyles.caption.copyWith(
                        color: isSelected
                            ? AppColors.surface.withValues(alpha: 0.8)
                            : AppColors.inkMuted,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      date.day.toString().padLeft(2, '0'),
                      style: AppTextStyles.cardTitle.copyWith(
                        fontSize: 19,
                        color: isSelected
                            ? AppColors.surface
                            : AppColors.primaryDark,
                      ),
                    ),
                    Text(
                      Formatters.monthBadge(date),
                      style: AppTextStyles.badge.copyWith(
                        fontSize: 9.5,
                        color: isSelected
                            ? AppColors.surface.withValues(alpha: 0.8)
                            : AppColors.navInactive,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

/// Grade de janelas de horário.
class TimeWindowGrid extends StatelessWidget {
  const TimeWindowGrid({
    super.key,
    required this.windows,
    required this.selected,
    required this.onSelected,
  });

  final List<String> windows;
  final String? selected;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: AppSpacing.sm,
      runSpacing: AppSpacing.sm,
      children: [
        for (final window in windows)
          _WindowChip(
            label: window,
            isSelected: window == selected,
            onTap: () => onSelected(window),
          ),
      ],
    );
  }
}

class _WindowChip extends StatelessWidget {
  const _WindowChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isSelected ? AppColors.tintBlue : AppColors.surface,
      borderRadius: AppRadius.pillBR,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.md,
          ),
          decoration: BoxDecoration(
            borderRadius: AppRadius.pillBR,
            border: Border.all(
              color: isSelected ? AppColors.accent : AppColors.border,
              width: isSelected ? 1.6 : 1,
            ),
          ),
          child: Text(
            label,
            style: AppTextStyles.chip.copyWith(
              color: isSelected ? AppColors.primary : AppColors.primaryDark,
            ),
          ),
        ),
      ),
    );
  }
}
