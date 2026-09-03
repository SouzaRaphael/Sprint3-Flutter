import 'package:lactarehub/domain/entities/donation.dart';
import 'package:lactarehub/domain/entities/tracking_step.dart';

/// Histórico de doações da persona de demonstração, com as linhas do tempo
/// de rastreio.
///
/// É catálogo: as doações da sessão atual vêm do `SessionMockDatasource`.
abstract class DonationMockDatasource {
  static final List<Donation> demoItems = [
    Donation(
      code: 'LCT-2104',
      collectedAt: DateTime(2026, 4, 27),
      volumeMilliliters: 460,
      status: DonationStatus.emAndamento,
      collectionPlace: 'Coleta domiciliar · Vila Mariana',
      destinationHospital: 'UTI neonatal do Hospital Pinheiros',
      timeline: [
        TrackingStep(
          title: 'Leite coletado',
          description: '27/abr · 09:30 · em sua casa',
          status: TrackingStepStatus.concluida,
        ),
        TrackingStep(
          title: 'Em análise',
          description: '28/abr · Banco Central Lactare',
          status: TrackingStepStatus.concluida,
        ),
        TrackingStep(
          title: 'Aprovado e pasteurizado',
          description: '29/abr · 460 ml em estoque',
          status: TrackingStepStatus.atual,
        ),
        TrackingStep(
          title: 'Distribuído ao hospital',
          description: 'Em breve · UTI neonatal parceira',
          status: TrackingStepStatus.pendente,
        ),
      ],
    ),
    Donation(
      code: 'LCT-2087',
      collectedAt: DateTime(2026, 4, 12),
      volumeMilliliters: 380,
      status: DonationStatus.distribuida,
      collectionPlace: 'Posto de Coleta Vila Mariana',
      destinationHospital: 'UTI neonatal do Hospital Pinheiros',
      timeline: [
        TrackingStep(
          title: 'Leite coletado',
          description: '12/abr · 10:05 · Posto Vila Mariana',
          status: TrackingStepStatus.concluida,
        ),
        TrackingStep(
          title: 'Em análise',
          description: '13/abr · Banco Central Lactare',
          status: TrackingStepStatus.concluida,
        ),
        TrackingStep(
          title: 'Aprovado e pasteurizado',
          description: '14/abr · 380 ml liberados',
          status: TrackingStepStatus.concluida,
        ),
        TrackingStep(
          title: 'Distribuído ao hospital',
          description: '16/abr · alimentou 3 bebês prematuros',
          status: TrackingStepStatus.concluida,
        ),
      ],
    ),
    Donation(
      code: 'LCT-2043',
      collectedAt: DateTime(2026, 3, 30),
      volumeMilliliters: 250,
      status: DonationStatus.distribuida,
      collectionPlace: 'Coleta domiciliar · Vila Mariana',
      destinationHospital: 'Maternidade Leonor Mendes de Barros',
      timeline: [
        TrackingStep(
          title: 'Leite coletado',
          description: '30/mar · 08:40 · em sua casa',
          status: TrackingStepStatus.concluida,
        ),
        TrackingStep(
          title: 'Em análise',
          description: '31/mar · Banco Central Lactare',
          status: TrackingStepStatus.concluida,
        ),
        TrackingStep(
          title: 'Aprovado e pasteurizado',
          description: '01/abr · 250 ml liberados',
          status: TrackingStepStatus.concluida,
        ),
        TrackingStep(
          title: 'Distribuído ao hospital',
          description: '03/abr · alimentou 2 bebês prematuros',
          status: TrackingStepStatus.concluida,
        ),
      ],
    ),
  ];
}
