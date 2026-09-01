/// Situação de uma etapa na linha do tempo de rastreamento.
enum TrackingStepStatus { concluida, atual, pendente }

/// Etapa do percurso do leite doado, do coletado ao hospital.
class TrackingStep {
  final String title;
  final String description;
  final TrackingStepStatus status;

  const TrackingStep({
    required this.title,
    required this.description,
    required this.status,
  });
}
