import 'package:lactarehub/domain/entities/article.dart';
import 'package:lactarehub/domain/repositories/article_repository.dart';

/// Lista os artigos, opcionalmente restritos a uma categoria.
class ListArticles {
  final ArticleRepository _repository;
  const ListArticles(this._repository);

  Future<List<Article>> call({ArticleCategory? category}) async {
    final articles = await _repository.listArticles();
    if (category == null) return articles;
    return articles.where((article) => article.category == category).toList();
  }
}
