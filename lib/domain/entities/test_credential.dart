/// Credencial de demonstração exibida na tela de login.
///
/// Faz parte do domínio porque o protótipo precisa expor as contas de teste
/// ao avaliador sem que a interface conheça a camada de dados.
class TestCredential {
  final String roleLabel;
  final String email;
  final String password;

  const TestCredential({
    required this.roleLabel,
    required this.email,
    required this.password,
  });
}
