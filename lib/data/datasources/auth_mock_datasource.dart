import 'package:lactarehub/domain/entities/user_session.dart';

/// Credenciais aceitas pelo login mockado.
///
/// São exatamente as exibidas na caixa "Credenciais de teste" da tela de
/// login, para que o avaliador consiga entrar sem consultar o código.
abstract class AuthMockDatasource {
  static const Map<String, MockAccount> accounts = {
    // 'admin@lactare.com.br': MockAccount(
    //   password: 'admin123',
    //   name: 'Equipe Lactare',
    //   role: UserRole.administrador,
    // ),
    'giovana@email.com': MockAccount(
      password: 'doadora123',
      name: 'Giovana',
      role: UserRole.doadora,
    ),
  };

  /// Rótulos da caixa de credenciais de teste da tela de login.
  static const List<({String role, String email, String password})> hints = [
    // (role: 'Admin', email: 'admin@lactare.com.br', password: 'admin123'),
    (role: 'Doadora', email: 'giovana@email.com', password: 'doadora123'),
  ];
}

class MockAccount {
  final String password;
  final String name;
  final UserRole role;

  const MockAccount({
    required this.password,
    required this.name,
    required this.role,
  });
}
