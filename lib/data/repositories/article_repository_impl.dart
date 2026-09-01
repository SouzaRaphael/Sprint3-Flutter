import 'package:lactarehub/data/datasources/article_mock_datasource.dart';
import 'package:lactarehub/domain/entities/article.dart';
import 'package:lactarehub/domain/repositories/article_repository.dart';

/// Conteúdo educativo sobre os dados mockados.
class ArticleRepositoryImpl implements ArticleRepository {
  static const Duration _latency = Duration(milliseconds: 250);

  @override
  Future<List<Article>> listArticles() async {
    await Future<void>.delayed(_latency);
    return ArticleMockDatasource.items;
  }

  @override
  Future<List<Article>> listFeatured() async {
    await Future<void>.delayed(_latency);
    return ArticleMockDatasource.items
        .where((article) => ArticleMockDatasource.featuredIds.contains(article.id))
        .toList();
  }
}
