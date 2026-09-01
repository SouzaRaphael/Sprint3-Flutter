import 'package:lactarehub/domain/entities/donation.dart';
import 'package:lactarehub/domain/repositories/donation_repository.dart';

/// Doação em trânsito, usada na prévia de rastreamento.
class GetCurrentDonation {
  final DonationRepository _repository;
  const GetCurrentDonation(this._repository);

  Future<Donation> call() => _repository.getCurrentDonation();
}
