import 'package:lactarehub/data/datasources/institutional_mock_datasource.dart';
import 'package:lactarehub/domain/entities/how_it_works_step.dart';
import 'package:lactarehub/domain/entities/impact_stats.dart';
import 'package:lactarehub/domain/repositories/institutional_repository.dart';

/// Conteúdo institucional sobre os dados mockados.
class InstitutionalRepositoryImpl implements InstitutionalRepository {
  static const Duration _latency = Duration(milliseconds: 250);

  @override
  Future<ImpactStats> getImpactStats() async {
    await Future<void>.delayed(_latency);
    return InstitutionalMockDatasource.stats;
  }

  @override
  Future<List<HowItWorksStep>> listHowItWorksSteps() async {
    await Future<void>.delayed(_latency);
    return InstitutionalMockDatasource.howItWorks;
  }
}
