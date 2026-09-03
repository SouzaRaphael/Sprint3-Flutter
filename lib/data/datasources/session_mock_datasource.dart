import 'package:lactarehub/data/datasources/donation_mock_datasource.dart';
import 'package:lactarehub/data/datasources/donor_mock_datasource.dart';
import 'package:lactarehub/data/datasources/schedule_mock_datasource.dart';
import 'package:lactarehub/domain/entities/achievement.dart';
import 'package:lactarehub/domain/entities/collection_schedule.dart';
import 'package:lactarehub/domain/entities/donation.dart';
import 'package:lactarehub/domain/entities/donor.dart';
import 'package:lactarehub/domain/entities/registration_draft.dart';

/// Quem está usando o aplicativo agora.
///
/// Os demais datasources são catálogo — a persona de demonstração, as doações
/// e a agenda de exemplo. É aqui que se decide o que a sessão atual enxerga,
/// e é o que separa quem entrou pelo login de quem acabou de se cadastrar.
///
/// O estado vive em memória e se perde ao fechar o aplicativo, como o restante
/// dos mocks desta Sprint.
abstract class SessionMockDatasource {
  static Donor _donor = DonorMockDatasource.demoProfile;
  static CollectionSchedule? _nextCollection = ScheduleMockDatasource.demoNext;
  static List<Donation> _donations = DonationMockDatasource.demoItems;
  static List<Achievement> _achievements = DonorMockDatasource.demoAchievements;

  static Donor get donor => _donor;
  static List<Donation> get donations => List.unmodifiable(_donations);
  static List<Achievement> get achievements => _achievements;

  /// Nula quando não há coleta marcada — o caso de quem acabou de entrar.
  static CollectionSchedule? get nextCollection => _nextCollection;

  /// Sessão da persona com histórico, aberta pelas credenciais de teste.
  static void startDemoSession() {
    _donor = DonorMockDatasource.demoProfile;
    _nextCollection = ScheduleMockDatasource.demoNext;
    _donations = DonationMockDatasource.demoItems;
    _achievements = DonorMockDatasource.demoAchievements;
  }

  /// Sessão de quem concluiu o cadastro: identidade própria e jornada em
  /// branco, sem coleta agendada nem doações a rastrear.
  static void startRegisteredSession(RegistrationDraft draft) {
    _donor = Donor.fromRegistration(draft);
    _nextCollection = null;
    _donations = const [];
    _achievements = DonorMockDatasource.startingAchievements;
  }

  /// Marca ou remarca a coleta da sessão.
  static void setNextCollection(CollectionSchedule schedule) =>
      _nextCollection = schedule;
}
