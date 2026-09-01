import 'package:lactarehub/domain/entities/achievement.dart';
import 'package:lactarehub/domain/repositories/donor_repository.dart';

/// Lista as medalhas da trilha da doadora.
class GetAchievements {
  final DonorRepository _repository;
  const GetAchievements(this._repository);

  Future<List<Achievement>> call() => _repository.getAchievements();
}
