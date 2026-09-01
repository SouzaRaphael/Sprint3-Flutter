import 'package:lactarehub/domain/entities/collection_schedule.dart';
import 'package:lactarehub/domain/repositories/schedule_repository.dart';

/// Registra uma nova coleta a partir do formulário de agendamento.
class ScheduleCollection {
  final ScheduleRepository _repository;
  const ScheduleCollection(this._repository);

  Future<CollectionSchedule> call(CollectionSchedule schedule) =>
      _repository.create(schedule);
}
