import 'package:lactarehub/domain/entities/tracking_step.dart';

/// Situação de uma doação dentro do fluxo do banco de leite.
enum DonationStatus { emAnalise, emAndamento, aprovada, distribuida }

extension DonationStatusLabel on DonationStatus {
  String get label => switch (this) {
    DonationStatus.emAnalise => 'Em análise',
    DonationStatus.emAndamento => 'Em andamento',
    DonationStatus.aprovada => 'Aprovada',
    DonationStatus.distribuida => 'Distribuída',
  };
}

/// Uma doação de leite humano, do recolhimento à entrega no hospital.
class Donation {
  /// Código de rastreio exibido para a doadora, ex.: `LCT-2104`.
  final String code;
  final DateTime collectedAt;
  final int volumeMilliliters;
  final DonationStatus status;
  final String collectionPlace;
  final String destinationHospital;
  final List<TrackingStep> timeline;

  const Donation({
    required this.code,
    required this.collectedAt,
    required this.volumeMilliliters,
    required this.status,
    required this.collectionPlace,
    required this.destinationHospital,
    required this.timeline,
  });
}
