import 'package:lactarehub/domain/entities/collection_schedule.dart';

/// Agendamento de coletas.
abstract class ScheduleRepository {
  Future<CollectionSchedule> getNextCollection();

  Future<CollectionSchedule> confirm();

  Future<CollectionSchedule> create(CollectionSchedule schedule);

  /// Janelas de horário oferecidas no formulário de agendamento.
  List<String> listAvailableWindows();
}
