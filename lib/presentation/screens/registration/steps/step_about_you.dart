import 'package:flutter/material.dart';
import 'package:lactarehub/core/theme/app_colors.dart';
import 'package:lactarehub/core/theme/app_spacing.dart';
import 'package:lactarehub/presentation/screens/registration/components/registration_fields.dart';
import 'package:lactarehub/presentation/shared/components/app_text_field.dart';

/// Etapa 1 — dados pessoais, fiel à captura do protótipo.
class StepAboutYou extends StatelessWidget {
  const StepAboutYou({super.key, required this.fields});

  final RegistrationFields fields;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppTextField(
          label: 'Nome completo',
          hint: 'Como você se chama?',
          controller: fields.fullName,
          textCapitalization: TextCapitalization.words,
          validator: (value) => (value ?? '').trim().length < 3
              ? 'Informe o seu nome completo.'
              : null,
        ),
        const SizedBox(height: AppSpacing.lg),
        AppTextField(
          label: 'E-mail',
          hint: 'seu@email.com',
          controller: fields.email,
          keyboardType: TextInputType.emailAddress,
          validator: (value) {
            final text = (value ?? '').trim();
            if (text.isEmpty) return 'Informe o seu e-mail.';
            if (!text.contains('@') || !text.contains('.')) {
              return 'Informe um e-mail válido.';
            }
            return null;
          },
        ),
        const SizedBox(height: AppSpacing.lg),
        AppTextField(
          label: 'Telefone / WhatsApp',
          hint: '(11) 99999-9999',
          controller: fields.phone,
          keyboardType: TextInputType.phone,
          validator: (value) => (value ?? '').trim().length < 8
              ? 'Informe um telefone para contato.'
              : null,
        ),
        const SizedBox(height: AppSpacing.lg),
        AppTextField(
          label: 'Data de nascimento',
          hint: 'dd/mm/aaaa',
          controller: fields.birthDate,
          keyboardType: TextInputType.datetime,
          suffix: const Icon(
            Icons.calendar_today_outlined,
            size: 18,
            color: AppColors.navInactive,
          ),
          validator: (value) => (value ?? '').trim().length < 8
              ? 'Informe a sua data de nascimento.'
              : null,
        ),
      ],
    );
  }
}
