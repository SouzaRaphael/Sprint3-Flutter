import 'package:lactarehub/domain/repositories/schedule_repository.dart';

/// "Hoje" segundo o protótipo.
///
/// O formulário de agendamento precisa dessa data mesmo quando não há coleta
/// marcada — que é justamente o caso de quem acabou de se cadastrar.
class GetReferenceDate {
  final ScheduleRepository _repository;
  const GetReferenceDate(this._repository);

  DateTime call() => _repository.referenceToday();
}
