import 'package:flutter/foundation.dart';
import 'package:lactarehub/core/di/service_locator.dart';
import 'package:lactarehub/domain/entities/article.dart';

/// Estado da aba Conteúdo.
class ContentController extends ChangeNotifier {
  List<Article> _articles = const [];
  ArticleCategory? _category;
  bool _isLoading = true;

  List<Article> get articles => _articles;
  ArticleCategory? get category => _category;
  bool get isLoading => _isLoading;

  /// "Todos" seguido das categorias, na ordem do enum.
  List<String> get filterLabels => [
    'Todos',
    for (final category in ArticleCategory.values) category.label,
  ];

  int get selectedFilterIndex => _category == null ? 0 : _category!.index + 1;

  Future<void> load() async {
    _isLoading = true;
    notifyListeners();
    _articles = await ServiceLocator.listArticles(category: _category);
    _isLoading = false;
    notifyListeners();
  }

  Future<void> selectFilter(int index) async {
    _category = index == 0 ? null : ArticleCategory.values[index - 1];
    await load();
  }
}
