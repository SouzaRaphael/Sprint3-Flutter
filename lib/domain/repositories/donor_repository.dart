import 'package:lactarehub/domain/entities/achievement.dart';
import 'package:lactarehub/domain/entities/donor.dart';

/// Perfil e conquistas da doadora autenticada.
abstract class DonorRepository {
  Future<Donor> getProfile();

  Future<List<Achievement>> getAchievements();
}
