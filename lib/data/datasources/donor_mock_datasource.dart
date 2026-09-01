import 'package:lactarehub/domain/entities/achievement.dart';
import 'package:lactarehub/domain/entities/donor.dart';

/// Doadora usada na demonstração das telas autenticadas.
abstract class DonorMockDatasource {
  static const Donor profile = Donor(
    id: 'doadora-giovana',
    fullName: 'Giovana Aparecida Ramos',
    firstName: 'Giovana',
    email: 'giovana@email.com',
    phone: '(11) 98421-7730',
    city: 'São Paulo',
    state: 'SP',
    neighborhood: 'Vila Mariana',
    completedDonations: 14,
    donatedMilliliters: 3200,
    babiesReached: 9,
    streakWeeks: 7,
    donationsToNextBadge: 1,
    daysSinceLastDonation: 3,
    avatarGradientIndex: 0,
  );

  static const List<Achievement> achievements = [
    Achievement(
      id: 'conq-primeira-doacao',
      title: 'Primeira doação',
      progressLabel: 'Conquistada',
      status: AchievementStatus.conquistada,
      gradientIndex: 3,
      icon: AchievementIcon.gota,
    ),
    Achievement(
      id: 'conq-doadora-frequente',
      title: 'Doadora frequente',
      progressLabel: '14 doações',
      status: AchievementStatus.conquistada,
      gradientIndex: 5,
      icon: AchievementIcon.medalha,
    ),
    Achievement(
      id: 'conq-embaixadora',
      title: 'Embaixadora',
      progressLabel: '2/5 indicações',
      status: AchievementStatus.conquistada,
      gradientIndex: 2,
      icon: AchievementIcon.estrela,
    ),
    Achievement(
      id: 'conq-50-dias',
      title: '50 dias seguidos',
      progressLabel: 'Em progresso',
      status: AchievementStatus.emProgresso,
      gradientIndex: 0,
      icon: AchievementIcon.coracao,
    ),
    Achievement(
      id: 'conq-inverno-solidario',
      title: 'Inverno solidário',
      progressLabel: 'Bloqueada',
      status: AchievementStatus.bloqueada,
      gradientIndex: 1,
      icon: AchievementIcon.folha,
    ),
    Achievement(
      id: 'conq-top-1',
      title: 'Top 1% 2026',
      progressLabel: 'Bloqueada',
      status: AchievementStatus.bloqueada,
      gradientIndex: 4,
      icon: AchievementIcon.brilho,
    ),
  ];
}
