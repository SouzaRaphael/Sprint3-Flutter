import 'package:flutter/material.dart';
import 'package:lactarehub/core/theme/app_colors.dart';
import 'package:lactarehub/core/theme/app_radius.dart';
import 'package:lactarehub/core/theme/app_spacing.dart';
import 'package:lactarehub/core/theme/app_text_styles.dart';
import 'package:lactarehub/domain/entities/registration_draft.dart';
import 'package:lactarehub/presentation/screens/registration/components/registration_fields.dart';
import 'package:lactarehub/presentation/shared/components/app_text_field.dart';

/// Etapa 3 — triagem de saúde.
class StepHealth extends StatelessWidget {
  const StepHealth({
    super.key,
    required this.fields,
    required this.draft,
    required this.onChanged,
  });

  final RegistrationFields fields;
  final RegistrationDraft draft;
  final ValueChanged<RegistrationDraft> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppTextField(
          label: 'Idade do bebê (em meses)',
          hint: '4',
          controller: fields.babyAgeMonths,
          keyboardType: TextInputType.number,
          validator: (value) => (value ?? '').trim().isEmpty
              ? 'Informe a idade do seu bebê.'
              : null,
        ),
        const SizedBox(height: AppSpacing.lg),
        _ToggleRow(
          title: 'Estou amamentando atualmente',
          description: 'Requisito para participar da rede de doação.',
          value: draft.isBreastfeeding,
          onChanged: (value) =>
              onChanged(draft.copyWith(isBreastfeeding: value)),
        ),
        const SizedBox(height: AppSpacing.md),
        _ToggleRow(
          title: 'Uso medicamento contínuo',
          description: 'A maior parte dos remédios comuns é compatível.',
          value: draft.takesMedication,
          onChanged: (value) =>
              onChanged(draft.copyWith(takesMedication: value)),
        ),
        if (draft.takesMedication) ...[
          const SizedBox(height: AppSpacing.lg),
          AppTextField(
            label: 'Quais medicamentos?',
            hint: 'Liste os medicamentos em uso',
            controller: fields.medicationNotes,
            maxLines: 3,
            validator: (value) => (value ?? '').trim().isEmpty
                ? 'Descreva os medicamentos para a triagem.'
                : null,
          ),
        ],
      ],
    );
  }
}

/// Linha com título, descrição e interruptor.
class _ToggleRow extends StatelessWidget {
  const _ToggleRow({
    required this.title,
    required this.description,
    required this.value,
    required this.onChanged,
  });

  final String title;
  final String description;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.md,
      ),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.cardBR,
        border: Border.all(color: AppColors.borderInput),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTextStyles.label),
                const SizedBox(height: 4),
                Text(description, style: AppTextStyles.caption),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Switch(
            value: value,
            onChanged: onChanged,
            activeThumbColor: AppColors.surface,
            activeTrackColor: AppColors.primary,
          ),
        ],
      ),
    );
  }
}
