import 'package:lactarehub/data/datasources/session_mock_datasource.dart';
import 'package:lactarehub/domain/entities/donation.dart';
import 'package:lactarehub/domain/repositories/donation_repository.dart';

/// Histórico de doações da sessão atual.
class DonationRepositoryImpl implements DonationRepository {
  static const Duration _latency = Duration(milliseconds: 250);

  @override
  Future<List<Donation>> listDonations() async {
    await Future<void>.delayed(_latency);
    return SessionMockDatasource.donations;
  }

  @override
  Future<Donation?> getCurrentDonation() async {
    await Future<void>.delayed(_latency);

    final donations = SessionMockDatasource.donations;
    if (donations.isEmpty) return null;

    return donations.firstWhere(
      (donation) => donation.status != DonationStatus.distribuida,
      orElse: () => donations.first,
    );
  }
}
