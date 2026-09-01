import 'package:lactarehub/data/datasources/donor_mock_datasource.dart';
import 'package:lactarehub/domain/entities/achievement.dart';
import 'package:lactarehub/domain/entities/donor.dart';
import 'package:lactarehub/domain/repositories/donor_repository.dart';

/// Perfil da doadora sobre os dados mockados.
class DonorRepositoryImpl implements DonorRepository {
  static const Duration _latency = Duration(milliseconds: 250);

  @override
  Future<Donor> getProfile() async {
    await Future<void>.delayed(_latency);
    return DonorMockDatasource.profile;
  }

  @override
  Future<List<Achievement>> getAchievements() async {
    await Future<void>.delayed(_latency);
    return DonorMockDatasource.achievements;
  }
}
