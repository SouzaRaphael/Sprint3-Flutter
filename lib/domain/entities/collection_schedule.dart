/// Modalidade escolhida para entregar o leite.
enum CollectionMode { domiciliar, postoDeColeta, banco }

extension CollectionModeLabel on CollectionMode {
  String get label => switch (this) {
    CollectionMode.domiciliar => 'Coleta domiciliar',
    CollectionMode.postoDeColeta => 'Levar a um posto',
    CollectionMode.banco => 'Levar ao BLH',
  };

  String get description => switch (this) {
    CollectionMode.domiciliar =>
      'Uma equipe busca o leite no endereço cadastrado.',
    CollectionMode.postoDeColeta =>
      'Entregue em um dos postos parceiros da rede.',
    CollectionMode.banco =>
      'Entregue diretamente no Banco de Leite Humano.',
  };
}

/// Coleta agendada da doadora.
class CollectionSchedule {
  final String id;
  final DateTime scheduledAt;
  final String timeWindow;
  final CollectionMode mode;
  final String place;
  final bool isConfirmed;
  final String notes;

  /// "Hoje" segundo o protótipo — permite calcular "em 4 dias" sem que a
  /// interface precise conhecer uma data fixa.
  final DateTime referenceToday;

  const CollectionSchedule({
    required this.id,
    required this.scheduledAt,
    required this.timeWindow,
    required this.mode,
    required this.place,
    required this.isConfirmed,
    required this.referenceToday,
    this.notes = '',
  });

  CollectionSchedule copyWith({
    DateTime? scheduledAt,
    String? timeWindow,
    CollectionMode? mode,
    String? place,
    bool? isConfirmed,
    String? notes,
  }) => CollectionSchedule(
    id: id,
    scheduledAt: scheduledAt ?? this.scheduledAt,
    timeWindow: timeWindow ?? this.timeWindow,
    mode: mode ?? this.mode,
    place: place ?? this.place,
    isConfirmed: isConfirmed ?? this.isConfirmed,
    referenceToday: referenceToday,
    notes: notes ?? this.notes,
  );

  /// Linha de contexto do card: `Coleta domiciliar · Vila Mariana`.
  String get summary => '${mode.label} · $place';
}
