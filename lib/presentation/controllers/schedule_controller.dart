import 'package:flutter/foundation.dart';
import 'package:lactarehub/core/di/service_locator.dart';
import 'package:lactarehub/domain/entities/collection_point.dart';
import 'package:lactarehub/domain/entities/collection_schedule.dart';
import 'package:lactarehub/domain/entities/donor.dart';

/// Estado do formulário de agendamento de coleta.
class ScheduleController extends ChangeNotifier {
  CollectionSchedule? _current;
  Donor? _donor;
  List<CollectionPoint> _points = const [];
  List<String> _availableWindows = const [];

  /// "Hoje" do protótipo. Vem do caso de uso, e não da coleta atual, porque
  /// quem acabou de se cadastrar ainda não tem coleta marcada.
  DateTime _referenceToday = DateTime.now();

  CollectionMode _mode = CollectionMode.domiciliar;
  DateTime? _date;
  String? _timeWindow;
  CollectionPoint? _selectedPoint;
  String _notes = '';

  bool _isLoading = true;
  bool _isSubmitting = false;

  CollectionSchedule? get current => _current;
  Donor? get donor => _donor;
  List<CollectionPoint> get points => _points;
  List<String> get availableWindows => _availableWindows;
  CollectionMode get mode => _mode;
  DateTime? get date => _date;
  String? get timeWindow => _timeWindow;
  CollectionPoint? get selectedPoint => _selectedPoint;
  bool get isLoading => _isLoading;
  bool get isSubmitting => _isSubmitting;

  /// A coleta domiciliar usa o bairro cadastrado; as demais exigem um ponto.
  bool get requiresPoint => _mode != CollectionMode.domiciliar;

  bool get canSubmit =>
      _date != null &&
      _timeWindow != null &&
      (!requiresPoint || _selectedPoint != null);

  /// Datas oferecidas: os próximos catorze dias a partir da referência.
  List<DateTime> get selectableDates => [
    for (var offset = 1; offset <= 14; offset++)
      DateTime(
        _referenceToday.year,
        _referenceToday.month,
        _referenceToday.day + offset,
      ),
  ];

  Future<void> load() async {
    _isLoading = true;
    notifyListeners();

    _current = await ServiceLocator.getNextCollection();
    _donor = await ServiceLocator.getDonorProfile();
    _points = await ServiceLocator.listCollectionPoints();
    _availableWindows = ServiceLocator.getAvailableWindows();
    _referenceToday = ServiceLocator.getReferenceDate();
    _mode = _current?.mode ?? CollectionMode.domiciliar;

    _isLoading = false;
    notifyListeners();
  }

  void selectMode(CollectionMode mode) {
    _mode = mode;
    if (!requiresPoint) _selectedPoint = null;
    notifyListeners();
  }

  void selectDate(DateTime date) {
    _date = date;
    notifyListeners();
  }

  void selectTimeWindow(String window) {
    _timeWindow = window;
    notifyListeners();
  }

  void selectPoint(CollectionPoint point) {
    _selectedPoint = point;
    notifyListeners();
  }

  void updateNotes(String notes) => _notes = notes;

  /// Grava o novo agendamento e devolve a coleta criada.
  Future<CollectionSchedule?> submit() async {
    final date = _date;
    final window = _timeWindow;
    if (!canSubmit || date == null || window == null) return null;

    _isSubmitting = true;
    notifyListeners();

    final startHour = int.tryParse(window.substring(0, 2)) ?? 10;
    final place = requiresPoint
        ? (_selectedPoint?.name ?? '')
        : (_donor?.neighborhood ?? '');

    final schedule = await ServiceLocator.scheduleCollection(
      CollectionSchedule(
        id: 'agd-${date.month}${date.day}-$startHour',
        scheduledAt: DateTime(date.year, date.month, date.day, startHour),
        timeWindow: window,
        mode: _mode,
        place: place,
        isConfirmed: true,
        referenceToday: _referenceToday,
        notes: _notes,
      ),
    );

    _current = schedule;
    _isSubmitting = false;
    notifyListeners();
    return schedule;
  }
}
