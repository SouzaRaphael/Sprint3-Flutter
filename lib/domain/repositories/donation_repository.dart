import 'package:lactarehub/domain/entities/donation.dart';

/// Histórico e rastreamento das doações.
abstract class DonationRepository {
  Future<List<Donation>> listDonations();

  /// Doação mais recente ainda em trânsito na rede.
  Future<Donation> getCurrentDonation();
}
