import 'package:lactarehub/domain/entities/impact_stats.dart';
import 'package:lactarehub/domain/repositories/institutional_repository.dart';

/// Números da rede exibidos na landing.
class GetImpactStats {
  final InstitutionalRepository _repository;
  const GetImpactStats(this._repository);

  Future<ImpactStats> call() => _repository.getImpactStats();
}
