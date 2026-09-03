import 'package:lactarehub/domain/entities/registration_draft.dart';

/// Nutriz cadastrada na rede Lactare.
class Donor {
  final String id;
  final String fullName;
  final String firstName;

  // ── Contato ──────────────────────────────────────────────────
  final String email;
  final String phone;
  final String birthDate;

  // ── Endereço ─────────────────────────────────────────────────
  final String zipCode;
  final String street;
  final String number;
  final String neighborhood;
  final String city;
  final String state;

  // ── Triagem ──────────────────────────────────────────────────
  final String babyAgeMonths;
  final bool isBreastfeeding;
  final bool takesMedication;
  final String medicationNotes;

  // ── Jornada ──────────────────────────────────────────────────

  /// Número de doações já concluídas.
  final int completedDonations;

  /// Volume total doado, em mililitros.
  final int donatedMilliliters;

  /// Estimativa de bebês alcançados pelas doações.
  final int babiesReached;

  /// Semanas consecutivas doando.
  final int streakWeeks;

  /// Doações que faltam para a próxima medalha.
  final int donationsToNextBadge;

  /// Dias desde a última doação. Nulo para quem ainda não doou.
  final int? daysSinceLastDonation;

  /// Índice do gradiente de avatar em `AppColors.avatarGradients`.
  final int avatarGradientIndex;

  const Donor({
    required this.id,
    required this.fullName,
    required this.firstName,
    required this.email,
    required this.phone,
    required this.birthDate,
    required this.zipCode,
    required this.street,
    required this.number,
    required this.neighborhood,
    required this.city,
    required this.state,
    required this.babyAgeMonths,
    required this.isBreastfeeding,
    required this.takesMedication,
    required this.medicationNotes,
    required this.completedDonations,
    required this.donatedMilliliters,
    required this.babiesReached,
    required this.streakWeeks,
    required this.donationsToNextBadge,
    required this.daysSinceLastDonation,
    required this.avatarGradientIndex,
  });

  /// Materializa a doadora a partir do que foi preenchido no cadastro.
  ///
  /// Toda a jornada começa zerada: quem acabou de se cadastrar ainda não tem
  /// doações, sequência nem medalhas.
  factory Donor.fromRegistration(RegistrationDraft draft) {
    final name = draft.fullName.trim();

    return Donor(
      id: 'doadora-${draft.email.trim().toLowerCase()}',
      fullName: name,
      firstName: _firstNameOf(name),
      email: draft.email,
      phone: draft.phone,
      birthDate: draft.birthDate,
      zipCode: draft.zipCode,
      street: draft.street,
      number: draft.number,
      neighborhood: draft.neighborhood,
      city: draft.city,
      state: draft.state,
      babyAgeMonths: draft.babyAgeMonths,
      isBreastfeeding: draft.isBreastfeeding,
      takesMedication: draft.takesMedication,
      medicationNotes: draft.medicationNotes,
      completedDonations: 0,
      donatedMilliliters: 0,
      babiesReached: 0,
      streakWeeks: 0,
      donationsToNextBadge: 1,
      daysSinceLastDonation: null,
      avatarGradientIndex: _gradientIndexFor(name),
    );
  }

  /// `true` quando a pessoa ainda não concluiu nenhuma doação.
  bool get isStartingJourney => completedDonations == 0;

  String get cityAndState => '$city, $state';

  String get formattedAddress =>
      '$street, $number — $neighborhood, $city/$state';

  static String _firstNameOf(String fullName) {
    final parts = fullName.split(RegExp(r'\s+'));
    return parts.isEmpty || parts.first.isEmpty ? fullName : parts.first;
  }

  /// Cor do avatar derivada do nome, para que a mesma pessoa receba sempre o
  /// mesmo gradiente. O widget aplica o módulo pelo tamanho da paleta.
  static int _gradientIndexFor(String fullName) =>
      fullName.codeUnits.fold<int>(0, (sum, unit) => sum + unit);
}
