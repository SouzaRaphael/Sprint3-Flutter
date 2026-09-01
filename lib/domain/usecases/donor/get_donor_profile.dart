import 'package:lactarehub/domain/entities/donor.dart';
import 'package:lactarehub/domain/repositories/donor_repository.dart';

/// Recupera o perfil da doadora autenticada.
class GetDonorProfile {
  final DonorRepository _repository;
  const GetDonorProfile(this._repository);

  Future<Donor> call() => _repository.getProfile();
}
