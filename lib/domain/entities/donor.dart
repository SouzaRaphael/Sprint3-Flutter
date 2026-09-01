/// Nutriz cadastrada na rede Lactare.
class Donor {
  final String id;
  final String fullName;
  final String firstName;
  final String email;
  final String phone;
  final String city;
  final String state;
  final String neighborhood;

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

  /// Dias desde a última doação.
  final int daysSinceLastDonation;

  /// Índice do gradiente de avatar em `AppColors.avatarGradients`.
  final int avatarGradientIndex;

  const Donor({
    required this.id,
    required this.fullName,
    required this.firstName,
    required this.email,
    required this.phone,
    required this.city,
    required this.state,
    required this.neighborhood,
    required this.completedDonations,
    required this.donatedMilliliters,
    required this.babiesReached,
    required this.streakWeeks,
    required this.donationsToNextBadge,
    required this.daysSinceLastDonation,
    required this.avatarGradientIndex,
  });

  String get cityAndState => '$city, $state';
}
