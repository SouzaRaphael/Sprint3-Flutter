import 'package:flutter/foundation.dart';
import 'package:lactarehub/core/di/service_locator.dart';
import 'package:lactarehub/domain/entities/collection_point.dart';

/// Estado do mapa de pontos de coleta.
class CollectionPointsController extends ChangeNotifier {
  List<CollectionPoint> _points = const [];
  CollectionPoint? _selected;
  CollectionPointType? _typeFilter;
  bool _onlyOpenNow = false;
  String _query = '';
  bool _isLoading = true;

  List<CollectionPoint> get points => _points;
  CollectionPoint? get selected => _selected;
  CollectionPointType? get typeFilter => _typeFilter;
  bool get onlyOpenNow => _onlyOpenNow;
  bool get isLoading => _isLoading;

  /// Rótulos da barra de filtros: "Todos" seguido dos tipos.
  List<String> get filterLabels => [
    'Todos',
    for (final type in CollectionPointType.values) type.label,
  ];

  int get selectedFilterIndex =>
      _typeFilter == null ? 0 : _typeFilter!.index + 1;

  Future<void> load() async {
    _isLoading = true;
    notifyListeners();
    await _refresh();
    _isLoading = false;
    notifyListeners();
  }

  Future<void> _refresh() async {
    _points = await ServiceLocator.listCollectionPoints(
      type: _typeFilter,
      onlyOpenNow: _onlyOpenNow,
      query: _query,
    );

    // Mantém a seleção só enquanto ela continuar visível no filtro atual.
    if (_selected != null && !_points.contains(_selected)) _selected = null;
    _selected ??= _points.isEmpty ? null : _points.first;
  }

  Future<void> selectFilter(int index) async {
    _typeFilter = index == 0 ? null : CollectionPointType.values[index - 1];
    await _refresh();
    notifyListeners();
  }

  Future<void> toggleOpenNow() async {
    _onlyOpenNow = !_onlyOpenNow;
    await _refresh();
    notifyListeners();
  }

  Future<void> search(String query) async {
    _query = query;
    await _refresh();
    notifyListeners();
  }

  void select(CollectionPoint point) {
    _selected = point;
    notifyListeners();
  }
}
