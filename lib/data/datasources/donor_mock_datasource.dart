import 'package:lactarehub/domain/entities/achievement.dart';
import 'package:lactarehub/domain/entities/donor.dart';

/// Persona de demonstração e as trilhas de conquistas.
///
/// Este é o catálogo: quem está de fato na sessão é decidido pelo
/// `SessionMockDatasource`.
abstract class DonorMockDatasource {
  /// Doadora com histórico, carregada pelo login com as credenciais de teste.
  static const Donor demoProfile = Donor(
    id: 'doadora-giovana',
    fullName: 'Giovana Aparecida Ramos',
    firstName: 'Giovana',
    email: 'giovana@email.com',
    phone: '(11) 98421-7730',
    birthDate: '14/03/1994',
    zipCode: '04101-300',
    street: 'Rua Domingos de Morais',
    number: '1284',
    neighborhood: 'Vila Mariana',
    city: 'São Paulo',
    state: 'SP',
    babyAgeMonths: '5',
    isBreastfeeding: true,
    takesMedication: false,
    medicationNotes: '',
    completedDonations: 14,
    donatedMilliliters: 3200,
    babiesReached: 9,
    streakWeeks: 7,
    donationsToNextBadge: 1,
    daysSinceLastDonation: 3,
    avatarGradientIndex: 0,
  );

  /// Medalhas da doadora com histórico.
  static const List<Achievement> demoAchievements = [
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

  /// Mesma trilha, no ponto de partida de quem acabou de se cadastrar.
  static const List<Achievement> startingAchievements = [
    Achievement(
      id: 'conq-primeira-doacao',
      title: 'Primeira doação',
      progressLabel: 'Falta 1 doação',
      status: AchievementStatus.emProgresso,
      gradientIndex: 3,
      icon: AchievementIcon.gota,
    ),
    Achievement(
      id: 'conq-doadora-frequente',
      title: 'Doadora frequente',
      progressLabel: '0/10 doações',
      status: AchievementStatus.bloqueada,
      gradientIndex: 5,
      icon: AchievementIcon.medalha,
    ),
    Achievement(
      id: 'conq-embaixadora',
      title: 'Embaixadora',
      progressLabel: '0/5 indicações',
      status: AchievementStatus.bloqueada,
      gradientIndex: 2,
      icon: AchievementIcon.estrela,
    ),
    Achievement(
      id: 'conq-50-dias',
      title: '50 dias seguidos',
      progressLabel: 'Bloqueada',
      status: AchievementStatus.bloqueada,
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
