import 'package:flutter/material.dart';
import 'package:lactarehub/core/theme/app_colors.dart';
import 'package:lactarehub/core/theme/app_radius.dart';
import 'package:lactarehub/core/theme/app_spacing.dart';
import 'package:lactarehub/core/theme/app_text_styles.dart';
import 'package:lactarehub/core/utils/formatters.dart';
import 'package:lactarehub/domain/entities/impact_stats.dart';
import 'package:lactarehub/presentation/screens/landing/components/hero_blob.dart';
import 'package:lactarehub/presentation/shared/components/avatar_circle.dart';
import 'package:lactarehub/presentation/shared/components/primary_button.dart';
import 'package:lactarehub/presentation/shared/components/secondary_button.dart';

/// Abertura da home pública: chamada principal e provas sociais.
class HeroSection extends StatelessWidget {
  const HeroSection({
    super.key,
    required this.stats,
    required this.heroStates,
    required this.onStartDonation,
    required this.onHowItWorks,
  });

  final ImpactStats stats;
  final List<String> heroStates;
  final VoidCallback onStartDonation;
  final VoidCallback onHowItWorks;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.bgLanding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.page,
              AppSpacing.xxl,
              AppSpacing.page,
              0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _NetworkBadge(stats: stats),
                const SizedBox(height: AppSpacing.xl),
                const _Headline(),
                const SizedBox(height: AppSpacing.lg),
                Text(
                  'A primeira rede digital que conecta nutrizes a bancos de '
                  'leite humano em tempo real. Cadastro em 2 minutos, coleta '
                  'agendada na sua casa e cada mL rastreado até o bebê.',
                  style: AppTextStyles.body,
                ),
                const SizedBox(height: AppSpacing.xxl),
                PrimaryButton(
                  label: 'Quero doar leite',
                  color: AppColors.primaryDeep,
                  onPressed: onStartDonation,
                ),
                const SizedBox(height: AppSpacing.md),
                SecondaryButton(
                  label: 'Como funciona',
                  icon: Icons.play_arrow,
                  onPressed: onHowItWorks,
                ),
                const SizedBox(height: AppSpacing.xl),
                _SocialProof(stats: stats, states: heroStates),
                const SizedBox(height: AppSpacing.xxl),
              ],
            ),
          ),
          const HeroBlob(),
        ],
      ),
    );
  }
}

class _NetworkBadge extends StatelessWidget {
  const _NetworkBadge({required this.stats});

  final ImpactStats stats;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
      decoration: BoxDecoration(
        color: AppColors.border.withValues(alpha: 0.55),
        borderRadius: AppRadius.pillBR,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 7,
            height: 7,
            decoration: const BoxDecoration(
              color: AppColors.accentCyan,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            '${stats.connectedBanks} BLHs · '
            '${Formatters.thousands(stats.donorsInNetwork)} doadoras ativas',
            style: AppTextStyles.badge.copyWith(color: AppColors.ink),
          ),
        ],
      ),
    );
  }
}

/// Título com a palavra "salva" em itálico azul, como no design.
class _Headline extends StatelessWidget {
  const _Headline();

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        style: AppTextStyles.heroTitle,
        children: [
          const TextSpan(text: 'Cada gota\n'),
          TextSpan(text: 'salva', style: AppTextStyles.heroTitleAccent),
          const TextSpan(text: ' uma vida\nde prematuro.'),
        ],
      ),
    );
  }
}

class _SocialProof extends StatelessWidget {
  const _SocialProof({required this.stats, required this.states});

  final ImpactStats stats;
  final List<String> states;

  @override
  Widget build(BuildContext context) {
    // Arredondado para a centena, como no design: "+1.200 nutrizes".
    final roundedDonors = (stats.donorsInNetwork ~/ 100) * 100;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 36.0 + (states.length - 1) * 26,
          height: 36,
          child: Stack(
            children: [
              for (var index = 0; index < states.length; index++)
                Positioned(
                  left: index * 26.0,
                  child: StateAvatar(state: states[index]),
                ),
            ],
          ),
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Text.rich(
            TextSpan(
              style: AppTextStyles.statLabel,
              children: [
                TextSpan(
                  text: '+${Formatters.thousands(roundedDonors)} ',
                  style: AppTextStyles.badge.copyWith(color: AppColors.ink),
                ),
                TextSpan(
                  text: 'nutrizes já participam da rede em '
                      '${stats.states} estados',
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
