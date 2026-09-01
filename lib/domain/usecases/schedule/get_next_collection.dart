import 'package:lactarehub/domain/entities/collection_schedule.dart';
import 'package:lactarehub/domain/repositories/schedule_repository.dart';

/// Próxima coleta agendada da doadora.
class GetNextCollection {
  final ScheduleRepository _repository;
  const GetNextCollection(this._repository);

  Future<CollectionSchedule> call() => _repository.getNextCollection();
}
