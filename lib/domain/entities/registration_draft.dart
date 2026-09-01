/// Dados coletados ao longo das quatro etapas do cadastro.
///
/// É imutável: cada etapa devolve uma cópia com os campos preenchidos,
/// o que mantém o controlador do formulário previsível.
class RegistrationDraft {
  // Etapa 1 — Sobre você
  final String fullName;
  final String email;
  final String phone;
  final String birthDate;

  // Etapa 2 — Onde você está
  final String zipCode;
  final String street;
  final String number;
  final String neighborhood;
  final String city;
  final String state;

  // Etapa 3 — Saúde e triagem
  final String babyAgeMonths;
  final bool isBreastfeeding;
  final bool takesMedication;
  final String medicationNotes;

  // Etapa 4 — Revisão
  final bool acceptedTerms;

  const RegistrationDraft({
    this.fullName = '',
    this.email = '',
    this.phone = '',
    this.birthDate = '',
    this.zipCode = '',
    this.street = '',
    this.number = '',
    this.neighborhood = '',
    this.city = '',
    this.state = '',
    this.babyAgeMonths = '',
    this.isBreastfeeding = true,
    this.takesMedication = false,
    this.medicationNotes = '',
    this.acceptedTerms = false,
  });

  RegistrationDraft copyWith({
    String? fullName,
    String? email,
    String? phone,
    String? birthDate,
    String? zipCode,
    String? street,
    String? number,
    String? neighborhood,
    String? city,
    String? state,
    String? babyAgeMonths,
    bool? isBreastfeeding,
    bool? takesMedication,
    String? medicationNotes,
    bool? acceptedTerms,
  }) => RegistrationDraft(
    fullName: fullName ?? this.fullName,
    email: email ?? this.email,
    phone: phone ?? this.phone,
    birthDate: birthDate ?? this.birthDate,
    zipCode: zipCode ?? this.zipCode,
    street: street ?? this.street,
    number: number ?? this.number,
    neighborhood: neighborhood ?? this.neighborhood,
    city: city ?? this.city,
    state: state ?? this.state,
    babyAgeMonths: babyAgeMonths ?? this.babyAgeMonths,
    isBreastfeeding: isBreastfeeding ?? this.isBreastfeeding,
    takesMedication: takesMedication ?? this.takesMedication,
    medicationNotes: medicationNotes ?? this.medicationNotes,
    acceptedTerms: acceptedTerms ?? this.acceptedTerms,
  );

  String get formattedAddress =>
      '$street, $number — $neighborhood, $city/$state';
}
