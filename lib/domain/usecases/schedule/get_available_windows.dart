import 'package:lactarehub/domain/repositories/schedule_repository.dart';

/// Janelas de horário disponíveis para a coleta.
class GetAvailableWindows {
  final ScheduleRepository _repository;
  const GetAvailableWindows(this._repository);

  List<String> call() => _repository.listAvailableWindows();
}
