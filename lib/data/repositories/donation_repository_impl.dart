import 'package:lactarehub/data/datasources/donation_mock_datasource.dart';
import 'package:lactarehub/domain/entities/donation.dart';
import 'package:lactarehub/domain/repositories/donation_repository.dart';

/// Histórico de doações sobre os dados mockados.
class DonationRepositoryImpl implements DonationRepository {
  static const Duration _latency = Duration(milliseconds: 250);

  @override
  Future<List<Donation>> listDonations() async {
    await Future<void>.delayed(_latency);
    return DonationMockDatasource.items;
  }

  @override
  Future<Donation> getCurrentDonation() async {
    await Future<void>.delayed(_latency);
    return DonationMockDatasource.items.firstWhere(
      (donation) => donation.status != DonationStatus.distribuida,
      orElse: () => DonationMockDatasource.items.first,
    );
  }
}
