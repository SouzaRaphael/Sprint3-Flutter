part of 'app_navigation.dart';

/// Nomes das rotas. Os caminhos espelham os do protótipo em
/// `docs/Lactare-Telas.pdf`.
abstract class AppRoutes {
  static const String splash = '/splash';
  static const String landing = '/';
  static const String login = '/login';
  static const String registration = '/cadastro';
  static const String registrationSuccess = '/cadastro/sucesso';

  /// Casca autenticada com as cinco abas.
  static const String app = '/app';

  static const String testimonials = '/depoimentos';
  static const String writeTestimonial = '/depoimentos/novo';
  static const String articleDetail = '/conteudo/artigo';
  static const String collectionPointDetail = '/pontos/detalhe';
  static const String donationDetail = '/doacoes/detalhe';
}
