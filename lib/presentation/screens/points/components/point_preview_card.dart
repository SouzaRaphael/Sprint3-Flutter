import 'package:flutter/material.dart';
import 'package:lactarehub/core/theme/app_colors.dart';
import 'package:lactarehub/core/theme/app_radius.dart';
import 'package:lactarehub/core/theme/app_spacing.dart';
import 'package:lactarehub/core/theme/app_text_styles.dart';
import 'package:lactarehub/domain/entities/collection_point.dart';
import 'package:lactarehub/presentation/shared/components/primary_button.dart';
import 'package:lactarehub/presentation/shared/components/status_badge.dart';

/// Folha inferior com o resumo do ponto selecionado no mapa.
class PointPreviewCard extends StatelessWidget {
  const PointPreviewCard({
    super.key,
    required this.point,
    required this.onOpenDetails,
    required this.onCall,
  });

  final CollectionPoint point;
  final VoidCallback onOpenDetails;
  final VoidCallback onCall;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.md,
        AppSpacing.lg,
        AppSpacing.lg,
      ),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.sheetBR,
        boxShadow: [
          BoxShadow(
            color: Color(0x1A101828),
            blurRadius: 24,
            offset: Offset(0, -6),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 42,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.border,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          InkWell(
            onTap: onOpenDetails,
            borderRadius: AppRadius.cardBR,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 52,
                  height: 52,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [AppColors.coverBlue, AppColors.accent],
                    ),
                    borderRadius: BorderRadius.circular(AppRadius.md),
                  ),
                  child: const Icon(
                    Icons.water_drop,
                    color: AppColors.surface,
                    size: 24,
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              point.name,
                              style: AppTextStyles.cardTitleBlue.copyWith(
                                fontSize: 16,
                              ),
                            ),
                          ),
                          const SizedBox(width: AppSpacing.sm),
                          DotStatusLabel(
                            label: point.isOpenNow ? 'Aberto' : 'Fechado',
                            color: point.isOpenNow
                                ? AppColors.successFg
                                : AppColors.navInactive,
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(point.summary, style: AppTextStyles.caption),
                      const SizedBox(height: 3),
                      Text(point.address, style: AppTextStyles.caption),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Row(
            children: [
              Expanded(
                child: PrimaryButton(
                  label: 'Traçar rota',
                  icon: Icons.turn_right,
                  showTrailingIcon: false,
                  height: 50,
                  onPressed: onOpenDetails,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Material(
                color: AppColors.surface,
                shape: const CircleBorder(
                  side: BorderSide(color: AppColors.border),
                ),
                clipBehavior: Clip.antiAlias,
                child: InkWell(
                  onTap: onCall,
                  child: const SizedBox(
                    width: 50,
                    height: 50,
                    child: Icon(
                      Icons.call_outlined,
                      size: 21,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
