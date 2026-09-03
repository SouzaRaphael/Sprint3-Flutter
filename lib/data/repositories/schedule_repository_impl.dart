import 'package:lactarehub/data/datasources/schedule_mock_datasource.dart';
import 'package:lactarehub/data/datasources/session_mock_datasource.dart';
import 'package:lactarehub/domain/entities/collection_schedule.dart';
import 'package:lactarehub/domain/repositories/schedule_repository.dart';

/// Agenda de coletas da sessão atual.
///
/// As alterações ficam em memória: confirmar ou reagendar reflete nas demais
/// telas enquanto o aplicativo estiver aberto.
class ScheduleRepositoryImpl implements ScheduleRepository {
  static const Duration _latency = Duration(milliseconds: 400);

  @override
  Future<CollectionSchedule?> getNextCollection() async {
    await Future<void>.delayed(const Duration(milliseconds: 250));
    return SessionMockDatasource.nextCollection;
  }

  @override
  Future<CollectionSchedule?> confirm() async {
    await Future<void>.delayed(_latency);

    final current = SessionMockDatasource.nextCollection;
    if (current == null) return null;

    SessionMockDatasource.setNextCollection(
      current.copyWith(isConfirmed: true),
    );
    return SessionMockDatasource.nextCollection;
  }

  @override
  Future<CollectionSchedule> create(CollectionSchedule schedule) async {
    await Future<void>.delayed(_latency);
    SessionMockDatasource.setNextCollection(schedule);
    return schedule;
  }

  @override
  List<String> listAvailableWindows() => ScheduleMockDatasource.availableWindows;

  @override
  DateTime referenceToday() => ScheduleMockDatasource.today;
}
