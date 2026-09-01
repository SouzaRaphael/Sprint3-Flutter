import 'package:flutter/material.dart';
import 'package:lactarehub/core/theme/app_spacing.dart';
import 'package:lactarehub/presentation/screens/registration/components/registration_fields.dart';
import 'package:lactarehub/presentation/shared/components/app_text_field.dart';

/// Etapa 2 — endereço, que define o BLH mais próximo.
class StepAddress extends StatelessWidget {
  const StepAddress({super.key, required this.fields});

  final RegistrationFields fields;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppTextField(
          label: 'CEP',
          hint: '04101-300',
          controller: fields.zipCode,
          keyboardType: TextInputType.number,
          validator: (value) => (value ?? '').trim().length < 8
              ? 'Informe um CEP válido.'
              : null,
        ),
        const SizedBox(height: AppSpacing.lg),
        AppTextField(
          label: 'Rua',
          hint: 'Nome da rua ou avenida',
          controller: fields.street,
          textCapitalization: TextCapitalization.words,
          validator: (value) =>
              (value ?? '').trim().isEmpty ? 'Informe a rua.' : null,
        ),
        const SizedBox(height: AppSpacing.lg),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: AppTextField(
                label: 'Número',
                hint: '1492',
                controller: fields.number,
                keyboardType: TextInputType.number,
                validator: (value) =>
                    (value ?? '').trim().isEmpty ? 'Obrigatório.' : null,
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              flex: 3,
              child: AppTextField(
                label: 'Bairro',
                hint: 'Vila Mariana',
                controller: fields.neighborhood,
                textCapitalization: TextCapitalization.words,
                validator: (value) =>
                    (value ?? '').trim().isEmpty ? 'Obrigatório.' : null,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.lg),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: AppTextField(
                label: 'Cidade',
                hint: 'São Paulo',
                controller: fields.city,
                textCapitalization: TextCapitalization.words,
                validator: (value) =>
                    (value ?? '').trim().isEmpty ? 'Obrigatório.' : null,
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: AppTextField(
                label: 'UF',
                hint: 'SP',
                controller: fields.state,
                textCapitalization: TextCapitalization.characters,
                validator: (value) => (value ?? '').trim().length != 2
                    ? 'UF'
                    : null,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
