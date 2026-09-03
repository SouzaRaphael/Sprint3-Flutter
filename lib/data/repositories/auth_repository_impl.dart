import 'package:lactarehub/data/datasources/auth_mock_datasource.dart';
import 'package:lactarehub/data/datasources/session_mock_datasource.dart';
import 'package:lactarehub/domain/entities/registration_draft.dart';
import 'package:lactarehub/domain/entities/test_credential.dart';
import 'package:lactarehub/domain/entities/user_session.dart';
import 'package:lactarehub/domain/repositories/auth_repository.dart';

/// Autenticação sobre os dados mockados.
///
/// É aqui que a sessão é aberta: entrar pelas credenciais de teste carrega a
/// persona de demonstração; concluir o cadastro carrega a pessoa que acabou
/// de se registrar.
class AuthRepositoryImpl implements AuthRepository {
  /// Latência simulada para que a interface exiba estados de carregamento.
  static const Duration _latency = Duration(milliseconds: 700);

  @override
  Future<UserSession> signIn({
    required String email,
    required String password,
  }) async {
    await Future<void>.delayed(_latency);

    final account = AuthMockDatasource.accounts[email.trim().toLowerCase()];
    if (account == null || account.password != password) {
      throw const AuthFailure('E-mail ou senha incorretos. Confira as '
          'credenciais de teste abaixo.');
    }

    SessionMockDatasource.startDemoSession();

    return UserSession(
      name: account.name,
      email: email.trim().toLowerCase(),
      role: account.role,
    );
  }

  @override
  Future<UserSession> register(RegistrationDraft draft) async {
    await Future<void>.delayed(_latency);

    SessionMockDatasource.startRegisteredSession(draft);

    return UserSession(
      name: draft.fullName,
      email: draft.email,
      role: UserRole.doadora,
    );
  }

  @override
  Future<void> signOut() async {
    await Future<void>.delayed(const Duration(milliseconds: 300));
    SessionMockDatasource.startDemoSession();
  }

  @override
  List<TestCredential> listTestCredentials() => [
    for (final hint in AuthMockDatasource.hints)
      TestCredential(
        roleLabel: hint.role,
        email: hint.email,
        password: hint.password,
      ),
  ];
}
