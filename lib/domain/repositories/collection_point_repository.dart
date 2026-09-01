import 'package:lactarehub/domain/entities/collection_point.dart';

/// Pontos de coleta exibidos no mapa.
abstract class CollectionPointRepository {
  Future<List<CollectionPoint>> listPoints();
}
