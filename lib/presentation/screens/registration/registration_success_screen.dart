import 'package:flutter/material.dart';
import 'package:lactarehub/core/theme/app_colors.dart';
import 'package:lactarehub/core/theme/app_radius.dart';
import 'package:lactarehub/core/theme/app_spacing.dart';
import 'package:lactarehub/core/theme/app_text_styles.dart';
import 'package:lactarehub/presentation/shared/components/primary_button.dart';

/// Confirmação exibida ao concluir o cadastro.
class RegistrationSuccessScreen extends StatelessWidget {
  const RegistrationSuccessScreen({super.key, required this.onEnterApp});

  final VoidCallback onEnterApp;

  @override
  Widget build(BuildContext context) {
    const nextSteps = [
      'Um enfermeiro do BLH mais próximo entra em contato em até 48 horas.',
      'A triagem é concluída por telefone ou WhatsApp, sem sair de casa.',
      'Depois disso você já pode agendar a sua primeira coleta.',
    ];

    return Scaffold(
      backgroundColor: AppColors.bgApp,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.page),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),
              Container(
                width: 76,
                height: 76,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: AppColors.successBg,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check_rounded,
                  size: 40,
                  color: AppColors.successFg,
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
              Text(
                'Cadastro enviado!',
                style: AppTextStyles.heroTitle.copyWith(fontSize: 28),
              ),
              const SizedBox(height: AppSpacing.md),
              Text(
                'Você acaba de dar o primeiro passo para alimentar bebês '
                'prematuros. Veja o que acontece agora.',
                style: AppTextStyles.body,
              ),
              const SizedBox(height: AppSpacing.xl),
              Container(
                padding: const EdgeInsets.all(AppSpacing.lg),
                decoration: BoxDecoration(
                  color: AppColors.tintBlue,
                  borderRadius: AppRadius.cardBR,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (var index = 0; index < nextSteps.length; index++)
                      Padding(
                        padding: EdgeInsets.only(
                          bottom: index == nextSteps.length - 1 ? 0 : 12,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 22,
                              height: 22,
                              alignment: Alignment.center,
                              decoration: const BoxDecoration(
                                color: AppColors.primary,
                                shape: BoxShape.circle,
                              ),
                              child: Text(
                                '${index + 1}',
                                style: AppTextStyles.badge.copyWith(
                                  color: AppColors.surface,
                                  fontSize: 11,
                                ),
                              ),
                            ),
                            const SizedBox(width: AppSpacing.md),
                            Expanded(
                              child: Text(
                                nextSteps[index],
                                style: AppTextStyles.bodySmall.copyWith(
                                  color: AppColors.primaryDark,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
              const Spacer(),
              PrimaryButton(
                label: 'Ir para a minha área',
                onPressed: onEnterApp,
              ),
              const SizedBox(height: AppSpacing.lg),
            ],
          ),
        ),
      ),
    );
  }
}
