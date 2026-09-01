/// Perfis atendidos pelo login mockado.
enum UserRole { doadora, administrador }

/// Sessão autenticada em memória.
class UserSession {
  final String name;
  final String email;
  final UserRole role;

  const UserSession({
    required this.name,
    required this.email,
    required this.role,
  });
}

/// Falha de autenticação com mensagem já pronta para a interface.
class AuthFailure implements Exception {
  final String message;
  const AuthFailure(this.message);

  @override
  String toString() => message;
}
