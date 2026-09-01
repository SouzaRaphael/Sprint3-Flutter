import 'package:flutter/material.dart';
import 'package:lactarehub/core/theme/app_colors.dart';
import 'package:lactarehub/core/theme/app_radius.dart';
import 'package:lactarehub/core/theme/app_spacing.dart';
import 'package:lactarehub/core/theme/app_text_styles.dart';

/// Tratamento visual do item selecionado.
enum FilterChipStyle {
  /// Fundo azul-claro e texto azul — usado na aba Conteúdo.
  tinted,

  /// Fundo azul sólido e texto branco — usado no mapa.
  solid,
}

/// Linha rolável de filtros em pílula.
class FilterChipBar extends StatelessWidget {
  const FilterChipBar({
    super.key,
    required this.labels,
    required this.selectedIndex,
    required this.onSelected,
    this.style = FilterChipStyle.tinted,
    this.padding = AppSpacing.pageHorizontal,
  });

  final List<String> labels;
  final int selectedIndex;
  final ValueChanged<int> onSelected;
  final FilterChipStyle style;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: padding,
        itemCount: labels.length,
        separatorBuilder: (_, _) => const SizedBox(width: AppSpacing.sm),
        itemBuilder: (context, index) => _Chip(
          label: labels[index],
          isSelected: index == selectedIndex,
          style: style,
          onTap: () => onSelected(index),
        ),
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({
    required this.label,
    required this.isSelected,
    required this.style,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final FilterChipStyle style;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final Color background;
    final Color foreground;
    final Color borderColor;

    if (!isSelected) {
      background = AppColors.surface;
      foreground = AppColors.primaryDark;
      borderColor = AppColors.border;
    } else if (style == FilterChipStyle.solid) {
      background = AppColors.primary;
      foreground = AppColors.surface;
      borderColor = AppColors.primary;
    } else {
      background = AppColors.tintBlue;
      foreground = AppColors.primary;
      borderColor = AppColors.tintBlue;
    }

    return Material(
      color: background,
      borderRadius: AppRadius.pillBR,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
          decoration: BoxDecoration(
            borderRadius: AppRadius.pillBR,
            border: Border.all(color: borderColor),
          ),
          child: Text(
            label,
            style: AppTextStyles.chip.copyWith(color: foreground),
          ),
        ),
      ),
    );
  }
}

/// Controle segmentado dentro de uma faixa azul-clara — usado nos
/// depoimentos, onde os três filtros dividem um mesmo trilho.
class SegmentedFilter extends StatelessWidget {
  const SegmentedFilter({
    super.key,
    required this.labels,
    required this.selectedIndex,
    required this.onSelected,
  });

  final List<String> labels;
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.tintBlue,
        borderRadius: AppRadius.pillBR,
      ),
      child: Row(
        children: [
          for (var index = 0; index < labels.length; index++)
            Expanded(
              child: _Segment(
                label: labels[index],
                isSelected: index == selectedIndex,
                onTap: () => onSelected(index),
              ),
            ),
        ],
      ),
    );
  }
}

class _Segment extends StatelessWidget {
  const _Segment({
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
      color: isSelected ? AppColors.surface : Colors.transparent,
      borderRadius: AppRadius.pillBR,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 38,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: AppRadius.pillBR,
            border: Border.all(
              color: isSelected ? AppColors.border : Colors.transparent,
            ),
          ),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              label,
              style: AppTextStyles.chip.copyWith(
                color: isSelected ? AppColors.primaryDark : AppColors.primary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
