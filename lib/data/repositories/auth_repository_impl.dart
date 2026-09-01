import 'package:lactarehub/data/datasources/auth_mock_datasource.dart';
import 'package:lactarehub/domain/entities/registration_draft.dart';
import 'package:lactarehub/domain/entities/test_credential.dart';
import 'package:lactarehub/domain/entities/user_session.dart';
import 'package:lactarehub/domain/repositories/auth_repository.dart';

/// Autenticação sobre os dados mockados.
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

    return UserSession(
      name: account.name,
      email: email.trim().toLowerCase(),
      role: account.role,
    );
  }

  @override
  Future<UserSession> register(RegistrationDraft draft) async {
    await Future<void>.delayed(_latency);

    return UserSession(
      name: draft.fullName,
      email: draft.email,
      role: UserRole.doadora,
    );
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
