import 'package:lactarehub/domain/entities/collection_schedule.dart';

/// Agendamento de coletas.
abstract class ScheduleRepository {
  /// Nula quando não há coleta marcada.
  Future<CollectionSchedule?> getNextCollection();

  Future<CollectionSchedule?> confirm();

  Future<CollectionSchedule> create(CollectionSchedule schedule);

  /// Janelas de horário oferecidas no formulário de agendamento.
  List<String> listAvailableWindows();

  /// "Hoje" segundo o protótipo, usado para montar as datas do formulário.
  DateTime referenceToday();
}
