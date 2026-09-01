import 'package:flutter/material.dart';
import 'package:lactarehub/core/theme/app_colors.dart';
import 'package:lactarehub/core/theme/app_spacing.dart';
import 'package:lactarehub/core/theme/app_text_styles.dart';
import 'package:lactarehub/presentation/shared/components/lactare_logo.dart';
import 'package:lactarehub/presentation/shared/components/primary_button.dart';
import 'package:lactarehub/presentation/shared/components/secondary_button.dart';

/// Chamada para o mapa de pontos de coleta.
class MapTeaserSection extends StatelessWidget {
  const MapTeaserSection({super.key, required this.onOpenMap});

  final VoidCallback onOpenMap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.surface,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.page,
        vertical: AppSpacing.section,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Encontre um BLH perto de você',
            style: AppTextStyles.sectionTitle.copyWith(fontSize: 24),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            'Veja pontos de coleta, BLHs e opções de coleta domiciliar na sua '
            'região.',
            style: AppTextStyles.body,
          ),
          const SizedBox(height: AppSpacing.xl),
          PrimaryButton(
            label: 'Ver mapa',
            expand: false,
            color: AppColors.primaryDeep,
            onPressed: () => (),
            // onPressed: onOpenMap,
          ),
        ],
      ),
    );
  }
}

/// Bloco de acesso para profissionais dos bancos de leite.
class ProfessionalsSection extends StatelessWidget {
  const ProfessionalsSection({super.key, required this.onLogin});

  final VoidCallback onLogin;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.bgLanding,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.page,
        vertical: AppSpacing.section,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Para profissionais',
            style: AppTextStyles.sectionTitle.copyWith(fontSize: 24),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            'Acesse recursos e rotinas para apoiar a rede de bancos de leite '
            'humano e o cuidado neonatal.',
            style: AppTextStyles.body,
          ),
          const SizedBox(height: AppSpacing.xl),
          SecondaryButton(
            label: 'Entrar',
            trailingIcon: Icons.arrow_forward,
            expand: false,
            onPressed: onLogin,
          ),
        ],
      ),
    );
  }
}

/// Rodapé institucional da home pública.
class LandingFooter extends StatelessWidget {
  const LandingFooter({super.key});

  @override
  Widget build(BuildContext context) {
    const links = ['Privacidade & LGPD', 'Termos', 'Imprensa', 'Contato'];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.page,
        AppSpacing.xxl,
        AppSpacing.page,
        AppSpacing.section,
      ),
      decoration: const BoxDecoration(
        color: AppColors.bgLanding,
        border: Border(top: BorderSide(color: AppColors.border)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const LactareLogo(size: 34, showWordmark: false),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Lactare Conecta', style: AppTextStyles.wordmark),
                  Text(
                    'Rede de bancos de leite',
                    style: AppTextStyles.caption,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xl),
          Wrap(
            spacing: AppSpacing.xl,
            runSpacing: AppSpacing.md,
            children: [
              for (final link in links)
                Text(
                  link,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.primaryDark,
                    fontWeight: FontWeight.w600,
                  ),
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.xl),
          Text(
            '© 2026 Lactare Conecta. Todos os direitos reservados.',
            style: AppTextStyles.caption,
          ),
        ],
      ),
    );
  }
}
