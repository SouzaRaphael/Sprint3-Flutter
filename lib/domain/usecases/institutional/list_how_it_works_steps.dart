import 'package:lactarehub/domain/entities/how_it_works_step.dart';
import 'package:lactarehub/domain/repositories/institutional_repository.dart';

/// Passos da seção "Em 3 passos" da landing.
class ListHowItWorksSteps {
  final InstitutionalRepository _repository;
  const ListHowItWorksSteps(this._repository);

  Future<List<HowItWorksStep>> call() => _repository.listHowItWorksSteps();
}
