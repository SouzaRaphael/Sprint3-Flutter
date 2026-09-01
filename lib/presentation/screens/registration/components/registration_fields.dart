import 'package:flutter/widgets.dart';
import 'package:lactarehub/domain/entities/registration_draft.dart';

/// Campos de texto do cadastro, vivos durante todo o fluxo.
///
/// Ficam fora dos widgets de etapa para que os valores sobrevivam ao ir e
/// voltar entre as quatro telas do formulário.
class RegistrationFields {
  final TextEditingController fullName = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController birthDate = TextEditingController();

  final TextEditingController zipCode = TextEditingController();
  final TextEditingController street = TextEditingController();
  final TextEditingController number = TextEditingController();
  final TextEditingController neighborhood = TextEditingController();
  final TextEditingController city = TextEditingController();
  final TextEditingController state = TextEditingController();

  final TextEditingController babyAgeMonths = TextEditingController();
  final TextEditingController medicationNotes = TextEditingController();

  /// Copia o que foi digitado para o rascunho imutável do domínio.
  RegistrationDraft applyTo(RegistrationDraft draft) => draft.copyWith(
    fullName: fullName.text.trim(),
    email: email.text.trim(),
    phone: phone.text.trim(),
    birthDate: birthDate.text.trim(),
    zipCode: zipCode.text.trim(),
    street: street.text.trim(),
    number: number.text.trim(),
    neighborhood: neighborhood.text.trim(),
    city: city.text.trim(),
    state: state.text.trim().toUpperCase(),
    babyAgeMonths: babyAgeMonths.text.trim(),
    medicationNotes: medicationNotes.text.trim(),
  );

  void dispose() {
    for (final field in [
      fullName,
      email,
      phone,
      birthDate,
      zipCode,
      street,
      number,
      neighborhood,
      city,
      state,
      babyAgeMonths,
      medicationNotes,
    ]) {
      field.dispose();
    }
  }
}
