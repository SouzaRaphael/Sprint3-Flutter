import 'package:flutter/material.dart';
import 'package:lactarehub/core/theme/app_colors.dart';
import 'package:lactarehub/core/theme/app_spacing.dart';
import 'package:lactarehub/core/utils/formatters.dart';
import 'package:lactarehub/domain/entities/impact_stats.dart';
import 'package:lactarehub/presentation/shared/components/stat_tile.dart';

/// Faixa escura com os quatro números da rede.
class ImpactBand extends StatelessWidget {
  const ImpactBand({super.key, required this.stats});

  final ImpactStats stats;

  @override
  Widget build(BuildContext context) {
    final tiles = <StatTile>[
      StatTile(
        value: Formatters.thousands(stats.litersCollected),
        label: 'litros coletados em ${stats.collectionYear}',
        onDark: true,
      ),
      StatTile(
        value: Formatters.thousands(stats.babiesAssisted),
        label: 'bebês atendidos',
        onDark: true,
      ),
      StatTile(
        value: Formatters.thousands(stats.donorsInNetwork),
        label: 'nutrizes na rede',
        onDark: true,
      ),
      StatTile(
        value: '${stats.connectedBanks}',
        label: 'BLHs conectados em ${stats.states} estados',
        onDark: true,
      ),
    ];

    return Container(
      width: double.infinity,
      color: AppColors.ink,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.page,
        vertical: AppSpacing.xxl,
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: tiles[0]),
              const SizedBox(width: AppSpacing.lg),
              Expanded(child: tiles[1]),
            ],
          ),
          const SizedBox(height: AppSpacing.xxl),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: tiles[2]),
              const SizedBox(width: AppSpacing.lg),
              Expanded(child: tiles[3]),
            ],
          ),
        ],
      ),
    );
  }
}
