import 'package:lactarehub/domain/entities/donation.dart';
import 'package:lactarehub/domain/repositories/donation_repository.dart';

/// Lista o histórico de doações da doadora.
class ListDonations {
  final DonationRepository _repository;
  const ListDonations(this._repository);

  Future<List<Donation>> call() => _repository.listDonations();
}
