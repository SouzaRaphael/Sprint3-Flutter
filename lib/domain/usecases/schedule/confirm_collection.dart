import 'package:lactarehub/domain/entities/collection_schedule.dart';
import 'package:lactarehub/domain/repositories/schedule_repository.dart';

/// Confirma a presença na coleta já agendada.
class ConfirmCollection {
  final ScheduleRepository _repository;
  const ConfirmCollection(this._repository);

  Future<CollectionSchedule?> call() => _repository.confirm();
}
