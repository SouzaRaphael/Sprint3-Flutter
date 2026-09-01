import 'package:lactarehub/domain/entities/collection_schedule.dart';

/// Agenda de coletas em memória.
///
/// Confirmar ou reagendar altera este estado durante a sessão, o que dá
/// retorno visual real às ações sem depender de backend.
abstract class ScheduleMockDatasource {
  /// Data de referência do protótipo — mantém as telas coerentes entre si.
  static final DateTime today = DateTime(2026, 5, 4);

  static CollectionSchedule next = CollectionSchedule(
    id: 'agd-0508',
    scheduledAt: DateTime(2026, 5, 8, 10),
    timeWindow: '10h às 12h',
    mode: CollectionMode.domiciliar,
    place: 'Vila Mariana',
    isConfirmed: false,
    referenceToday: today,
  );

  /// Janelas de horário oferecidas no formulário de agendamento.
  static const List<String> availableWindows = [
    '08h às 10h',
    '10h às 12h',
    '14h às 16h',
    '16h às 18h',
  ];
}
