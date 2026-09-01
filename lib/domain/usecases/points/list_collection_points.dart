import 'package:lactarehub/domain/entities/collection_point.dart';
import 'package:lactarehub/domain/repositories/collection_point_repository.dart';

/// Lista os pontos de coleta, opcionalmente filtrados.
///
/// O filtro vive no caso de uso — assim a tela não repete regra de negócio.
class ListCollectionPoints {
  final CollectionPointRepository _repository;
  const ListCollectionPoints(this._repository);

  Future<List<CollectionPoint>> call({
    CollectionPointType? type,
    bool onlyOpenNow = false,
    String query = '',
  }) async {
    final points = await _repository.listPoints();
    final normalized = query.trim().toLowerCase();

    return points.where((point) {
      if (type != null && point.type != type) return false;
      if (onlyOpenNow && !point.isOpenNow) return false;
      if (normalized.isEmpty) return true;
      return point.name.toLowerCase().contains(normalized) ||
          point.neighborhood.toLowerCase().contains(normalized) ||
          point.address.toLowerCase().contains(normalized);
    }).toList();
  }
}
