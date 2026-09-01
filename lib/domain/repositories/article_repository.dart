import 'package:lactarehub/domain/entities/article.dart';

/// Conteúdo educativo da rede.
abstract class ArticleRepository {
  Future<List<Article>> listArticles();

  /// Seleção curta usada nos carrosséis de leitura.
  Future<List<Article>> listFeatured();
}
