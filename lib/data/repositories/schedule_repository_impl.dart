import 'package:lactarehub/data/datasources/schedule_mock_datasource.dart';
import 'package:lactarehub/domain/entities/collection_schedule.dart';
import 'package:lactarehub/domain/repositories/schedule_repository.dart';

/// Agenda de coletas sobre os dados mockados.
///
/// As alterações ficam em memória: confirmar ou reagendar reflete nas demais
/// telas enquanto o aplicativo estiver aberto.
class ScheduleRepositoryImpl implements ScheduleRepository {
  static const Duration _latency = Duration(milliseconds: 400);

  @override
  Future<CollectionSchedule> getNextCollection() async {
    await Future<void>.delayed(const Duration(milliseconds: 250));
    return ScheduleMockDatasource.next;
  }

  @override
  Future<CollectionSchedule> confirm() async {
    await Future<void>.delayed(_latency);
    ScheduleMockDatasource.next =
        ScheduleMockDatasource.next.copyWith(isConfirmed: true);
    return ScheduleMockDatasource.next;
  }

  @override
  Future<CollectionSchedule> create(CollectionSchedule schedule) async {
    await Future<void>.delayed(_latency);
    ScheduleMockDatasource.next = schedule;
    return ScheduleMockDatasource.next;
  }

  @override
  List<String> listAvailableWindows() => ScheduleMockDatasource.availableWindows;
}
