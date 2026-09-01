import 'package:flutter/material.dart';
import 'package:lactarehub/core/theme/app_colors.dart';
import 'package:lactarehub/core/theme/app_radius.dart';
import 'package:lactarehub/core/theme/app_spacing.dart';
import 'package:lactarehub/core/theme/app_text_styles.dart';
import 'package:lactarehub/domain/entities/test_credential.dart';

/// Caixa azul-clara com as contas de demonstração.
///
/// Tocar em uma linha preenche o formulário, o que abrevia a avaliação.
class TestCredentialsBox extends StatelessWidget {
  const TestCredentialsBox({
    super.key,
    required this.credentials,
    required this.onUseCredential,
  });

  final List<TestCredential> credentials;
  final ValueChanged<TestCredential> onUseCredential;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.tintBlue,
        borderRadius: AppRadius.cardBR,
        border: Border.all(color: AppColors.accent.withValues(alpha: 0.35)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'CREDENCIAIS DE TESTE',
            style: AppTextStyles.overline.copyWith(color: AppColors.primary),
          ),
          const SizedBox(height: AppSpacing.md),
          for (final credential in credentials)
            Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: InkWell(
                onTap: () => onUseCredential(credential),
                borderRadius: AppRadius.inputBR,
                child: Text.rich(
                  TextSpan(
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.primaryDark,
                    ),
                    children: [
                      TextSpan(
                        text: '${credential.roleLabel}: ',
                        style: AppTextStyles.label,
                      ),
                      TextSpan(
                        text: '${credential.email} / ${credential.password}',
                      ),
                    ],
                  ),
                ),
              ),
            ),
          const SizedBox(height: 2),
          Text(
            'Toque em uma linha para preencher o formulário.',
            style: AppTextStyles.caption.copyWith(color: AppColors.primary),
          ),
        ],
      ),
    );
  }
}
