import 'package:flutter/material.dart';
import 'package:lactarehub/core/theme/app_colors.dart';
import 'package:lactarehub/core/theme/app_radius.dart';
import 'package:lactarehub/core/theme/app_spacing.dart';
import 'package:lactarehub/core/theme/app_text_styles.dart';
import 'package:lactarehub/domain/entities/collection_point.dart';
import 'package:lactarehub/presentation/controllers/collection_points_controller.dart';
import 'package:lactarehub/presentation/screens/points/components/map_canvas.dart';
import 'package:lactarehub/presentation/screens/points/components/point_preview_card.dart';
import 'package:lactarehub/presentation/shared/components/app_feedback.dart';
import 'package:lactarehub/presentation/shared/components/filter_chip_bar.dart';

/// Tela 06 do protótipo — mapa dos pontos da rede.
class CollectionPointsScreen extends StatefulWidget {
  const CollectionPointsScreen({super.key, required this.onOpenPoint});

  final ValueChanged<CollectionPoint> onOpenPoint;

  @override
  State<CollectionPointsScreen> createState() => _CollectionPointsScreenState();
}

class _CollectionPointsScreenState extends State<CollectionPointsScreen> {
  final CollectionPointsController _controller = CollectionPointsController();
  final TextEditingController _searchField = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.load();
  }

  @override
  void dispose() {
    _controller.dispose();
    _searchField.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgApp,
      body: ListenableBuilder(
        listenable: _controller,
        builder: (context, _) {
          final selected = _controller.selected;

          return Stack(
            children: [
              const MapCanvas(),
              if (!_controller.isLoading)
                LayoutBuilder(
                  builder: (context, constraints) => Stack(
                    children: [
                      Positioned(
                        left: constraints.maxWidth * 0.5 - 15,
                        top: constraints.maxHeight * 0.52 - 15,
                        child: const CurrentLocationDot(),
                      ),
                      for (final point in _controller.points)
                        Positioned(
                          left: constraints.maxWidth * point.mapX - 17,
                          top: constraints.maxHeight * point.mapY - 21,
                          child: MapPin(
                            isSelected: point == selected,
                            onTap: () => _controller.select(point),
                          ),
                        ),
                    ],
                  ),
                ),
              SafeArea(
                bottom: false,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(AppSpacing.lg),
                      child: _SearchBar(
                        controller: _searchField,
                        onChanged: _controller.search,
                        onlyOpenNow: _controller.onlyOpenNow,
                        onToggleOpenNow: _controller.toggleOpenNow,
                      ),
                    ),
                    FilterChipBar(
                      labels: _controller.filterLabels,
                      selectedIndex: _controller.selectedFilterIndex,
                      style: FilterChipStyle.solid,
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.lg,
                      ),
                      onSelected: _controller.selectFilter,
                    ),
                  ],
                ),
              ),
              if (_controller.isLoading)
                const Center(child: CircularProgressIndicator()),
              if (selected != null)
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: PointPreviewCard(
                    point: selected,
                    onOpenDetails: () => widget.onOpenPoint(selected),
                    onCall: () => AppFeedback.info(
                      context,
                      'Ligando para ${selected.name}: ${selected.phone}',
                    ),
                  ),
                ),
              if (!_controller.isLoading && _controller.points.isEmpty)
                Center(
                  child: Container(
                    margin: const EdgeInsets.all(AppSpacing.xl),
                    padding: const EdgeInsets.all(AppSpacing.xl),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: AppRadius.largeCardBR,
                      boxShadow: AppColors.cardShadow,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.location_off_outlined,
                          size: 32,
                          color: AppColors.navInactive,
                        ),
                        const SizedBox(height: AppSpacing.md),
                        Text(
                          'Nenhum ponto encontrado com esses filtros.',
                          textAlign: TextAlign.center,
                          style: AppTextStyles.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

/// Busca e alternador "Aberto agora", flutuando sobre o mapa.
class _SearchBar extends StatelessWidget {
  const _SearchBar({
    required this.controller,
    required this.onChanged,
    required this.onlyOpenNow,
    required this.onToggleOpenNow,
  });

  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final bool onlyOpenNow;
  final VoidCallback onToggleOpenNow;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 54,
      padding: const EdgeInsets.only(left: AppSpacing.lg, right: 6),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.pillBR,
        boxShadow: AppColors.cardShadow,
      ),
      child: Row(
        children: [
          const Icon(Icons.search, size: 20, color: AppColors.navInactive),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              style: AppTextStyles.bodySmall.copyWith(color: AppColors.ink),
              decoration: InputDecoration(
                hintText: 'BLHs próximos',
                hintStyle: AppTextStyles.bodySmall,
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                filled: false,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
          Material(
            color: onlyOpenNow ? AppColors.primary : AppColors.tintBlue,
            borderRadius: AppRadius.pillBR,
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: onToggleOpenNow,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: 9,
                ),
                child: Text(
                  'Aberto agora',
                  style: AppTextStyles.badge.copyWith(
                    color: onlyOpenNow ? AppColors.surface : AppColors.primary,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
