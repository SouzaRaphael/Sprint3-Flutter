import 'package:lactarehub/data/datasources/collection_point_mock_datasource.dart';
import 'package:lactarehub/domain/entities/collection_point.dart';
import 'package:lactarehub/domain/repositories/collection_point_repository.dart';

/// Pontos da rede sobre os dados mockados.
class CollectionPointRepositoryImpl implements CollectionPointRepository {
  static const Duration _latency = Duration(milliseconds: 250);

  @override
  Future<List<CollectionPoint>> listPoints() async {
    await Future<void>.delayed(_latency);
    return CollectionPointMockDatasource.items;
  }
}
