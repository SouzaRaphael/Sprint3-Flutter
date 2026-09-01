import 'dart:ui';

/// Trilhas de conteúdo educativo do aplicativo.
enum ArticleCategory { beneficios, comoArmazenar, amamentacao, cuidados, bastidores }

extension ArticleCategoryLabel on ArticleCategory {
  String get label => switch (this) {
    ArticleCategory.beneficios => 'Benefícios',
    ArticleCategory.comoArmazenar => 'Como armazenar',
    ArticleCategory.amamentacao => 'Amamentação',
    ArticleCategory.cuidados => 'Cuidados',
    ArticleCategory.bastidores => 'Bastidores',
  };
}

/// Artigo educativo apresentado na aba Conteúdo.
class Article {
  final String id;
  final String title;
  final String summary;
  final ArticleCategory category;
  final int readingMinutes;

  /// Cor sólida da capa — o design usa blocos de cor, não fotos.
  final Color coverColor;

  /// Corpo do artigo, um parágrafo por item.
  final List<String> paragraphs;

  final String author;

  const Article({
    required this.id,
    required this.title,
    required this.summary,
    required this.category,
    required this.readingMinutes,
    required this.coverColor,
    required this.paragraphs,
    required this.author,
  });

  String get readingLabel => '$readingMinutes min de leitura';
}
