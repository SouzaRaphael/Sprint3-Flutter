import 'package:lactarehub/domain/entities/article.dart';
import 'package:lactarehub/domain/repositories/article_repository.dart';

/// Seleção curta de leituras para os carrosséis das telas da doadora.
class ListFeaturedArticles {
  final ArticleRepository _repository;
  const ListFeaturedArticles(this._repository);

  Future<List<Article>> call() => _repository.listFeatured();
}
