import 'package:lactarehub/domain/entities/how_it_works_step.dart';
import 'package:lactarehub/domain/entities/impact_stats.dart';

/// Conteúdo institucional da landing pública.
abstract class InstitutionalRepository {
  Future<ImpactStats> getImpactStats();

  Future<List<HowItWorksStep>> listHowItWorksSteps();
}
