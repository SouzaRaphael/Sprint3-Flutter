import 'package:flutter/material.dart';
import 'package:lactarehub/core/theme/app_colors.dart';
import 'package:lactarehub/core/theme/app_radius.dart';
import 'package:lactarehub/core/theme/app_spacing.dart';
import 'package:lactarehub/core/theme/app_text_styles.dart';
import 'package:lactarehub/domain/entities/collection_point.dart';
import 'package:lactarehub/presentation/shared/components/app_feedback.dart';
import 'package:lactarehub/presentation/shared/components/app_top_bar.dart';
import 'package:lactarehub/presentation/shared/components/primary_button.dart';
import 'package:lactarehub/presentation/shared/components/secondary_button.dart';
import 'package:lactarehub/presentation/shared/components/status_badge.dart';

/// Detalhe de um ponto da rede.
///
/// Recebe o [CollectionPoint] por `settings.arguments` — é a passagem de
/// parâmetros entre listagem e detalhe.
class CollectionPointDetailScreen extends StatelessWidget {
  const CollectionPointDetailScreen({
    super.key,
    required this.point,
    required this.goBack,
  });

  final CollectionPoint point;
  final VoidCallback goBack;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgApp,
      body: SafeArea(
        child: Column(
          children: [
            AppTopBar(title: point.type.label, onBack: goBack),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.page,
                  AppSpacing.xl,
                  AppSpacing.page,
                  AppSpacing.xl,
                ),
                children: [
                  Container(
                    height: 130,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [AppColors.coverBlue, AppColors.accent],
                      ),
                      borderRadius: AppRadius.largeCardBR,
                    ),
                    child: const Icon(
                      Icons.water_drop,
                      size: 52,
                      color: AppColors.surface,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          point.name,
                          style: AppTextStyles.heroTitle.copyWith(fontSize: 24),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.md),
                      DotStatusLabel(
                        label: point.isOpenNow ? 'Aberto' : 'Fechado',
                        color: point.isOpenNow
                            ? AppColors.successFg
                            : AppColors.navInactive,
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  _InfoRow(
                    icon: Icons.place_outlined,
                    label: 'Endereço',
                    value: point.address,
                  ),
                  _InfoRow(
                    icon: Icons.schedule,
                    label: 'Funcionamento',
                    value: point.openingHours,
                  ),
                  _InfoRow(
                    icon: Icons.near_me_outlined,
                    label: 'Distância',
                    value: point.type == CollectionPointType.coletaDomiciliar
                        ? 'Atendimento no seu endereço'
                        : '${point.distanceKm.toStringAsFixed(1)} km de você',
                  ),
                  _InfoRow(
                    icon: Icons.call_outlined,
                    label: 'Telefone',
                    value: point.phone,
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  Container(
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    decoration: BoxDecoration(
                      color: AppColors.tintBlue,
                      borderRadius: AppRadius.cardBR,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.info_outline,
                          size: 20,
                          color: AppColors.primary,
                        ),
                        const SizedBox(width: AppSpacing.md),
                        Expanded(
                          child: Text(
                            'Leve o leite congelado em caixa térmica e '
                            'apresente o seu cadastro do Lactare na recepção.',
                            style: AppTextStyles.bodySmall.copyWith(
                              color: AppColors.primaryDark,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xxl),
                  PrimaryButton(
                    label: 'Traçar rota',
                    icon: Icons.turn_right,
                    showTrailingIcon: false,
                    onPressed: () => AppFeedback.info(
                      context,
                      'Rota até ${point.name} aberta no aplicativo de mapas.',
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  SecondaryButton(
                    label: 'Ligar para o ponto',
                    icon: Icons.call_outlined,
                    onPressed: () => AppFeedback.info(
                      context,
                      'Ligando para ${point.phone}.',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Linha de informação com ícone, rótulo e valor.
class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.lg),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 38,
            height: 38,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.tintBlue,
              borderRadius: BorderRadius.circular(11),
            ),
            child: Icon(icon, size: 19, color: AppColors.primary),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: AppTextStyles.caption),
                const SizedBox(height: 3),
                Text(
                  value,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.ink,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
