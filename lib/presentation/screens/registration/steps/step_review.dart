import 'package:flutter/material.dart';
import 'package:lactarehub/core/theme/app_colors.dart';
import 'package:lactarehub/core/theme/app_radius.dart';
import 'package:lactarehub/core/theme/app_spacing.dart';
import 'package:lactarehub/core/theme/app_text_styles.dart';
import 'package:lactarehub/domain/entities/registration_draft.dart';

/// Etapa 4 — revisão dos dados e aceite dos termos.
class StepReview extends StatelessWidget {
  const StepReview({super.key, required this.draft, required this.onChanged});

  final RegistrationDraft draft;
  final ValueChanged<RegistrationDraft> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _ReviewCard(
          title: 'Sobre você',
          rows: [
            ('Nome', draft.fullName),
            ('E-mail', draft.email),
            ('Telefone', draft.phone),
            ('Nascimento', draft.birthDate),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        _ReviewCard(
          title: 'Endereço',
          rows: [
            ('CEP', draft.zipCode),
            ('Endereço', draft.formattedAddress),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        _ReviewCard(
          title: 'Saúde e triagem',
          rows: [
            ('Idade do bebê', '${draft.babyAgeMonths} meses'),
            ('Amamentando', draft.isBreastfeeding ? 'Sim' : 'Não'),
            (
              'Medicamento contínuo',
              draft.takesMedication
                  ? (draft.medicationNotes.isEmpty
                        ? 'Sim'
                        : draft.medicationNotes)
                  : 'Não',
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.xl),
        _TermsCheckbox(
          value: draft.acceptedTerms,
          onChanged: (value) => onChanged(draft.copyWith(acceptedTerms: value)),
        ),
      ],
    );
  }
}

class _ReviewCard extends StatelessWidget {
  const _ReviewCard({required this.title, required this.rows});

  final String title;
  final List<(String, String)> rows;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.cardBR,
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppTextStyles.cardTitleBlue),
          const SizedBox(height: AppSpacing.md),
          for (final (label, value) in rows)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 120,
                    child: Text(label, style: AppTextStyles.caption),
                  ),
                  Expanded(
                    child: Text(
                      value.isEmpty ? '—' : value,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.ink,
                        fontWeight: FontWeight.w600,
                      ),
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

class _TermsCheckbox extends StatelessWidget {
  const _TermsCheckbox({required this.value, required this.onChanged});

  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onChanged(!value),
      borderRadius: AppRadius.cardBR,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Checkbox(
              value: value,
              onChanged: (checked) => onChanged(checked ?? false),
              activeColor: AppColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Text(
                  'Autorizo o contato da equipe do banco de leite e concordo '
                  'com a política de privacidade e o tratamento dos meus dados '
                  'conforme a LGPD.',
                  style: AppTextStyles.bodySmall,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
