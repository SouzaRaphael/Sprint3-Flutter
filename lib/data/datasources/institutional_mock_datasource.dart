import 'package:lactarehub/domain/entities/how_it_works_step.dart';
import 'package:lactarehub/domain/entities/impact_stats.dart';

/// Conteúdo institucional apresentado na landing pública.
abstract class InstitutionalMockDatasource {
  static const ImpactStats stats = ImpactStats(
    litersCollected: 847,
    collectionYear: 2024,
    babiesAssisted: 8470,
    donorsInNetwork: 1284,
    connectedBanks: 17,
    states: 5,
    highlightedStates: ['MS', 'AL', 'RJ', 'SP'],
  );

  static const List<HowItWorksStep> howItWorks = [
    HowItWorksStep(
      number: '01',
      title: 'Cadastre-se',
      description: '2 minutos pelo celular, com triagem digital guiada por '
          'enfermeiros do BLH mais próximo.',
      icon: HowItWorksIcon.pessoa,
    ),
    HowItWorksStep(
      number: '02',
      title: 'Receba a coleta',
      description: 'Coleta domiciliar agendada via WhatsApp ou entregue em '
          'qualquer ponto da rede.',
      icon: HowItWorksIcon.local,
    ),
    HowItWorksStep(
      number: '03',
      title: 'Acompanhe o impacto',
      description: 'Cada mL rastreado: veja quantos bebês foram atendidos com '
          'a sua doação.',
      icon: HowItWorksIcon.coracao,
    ),
  ];
}
