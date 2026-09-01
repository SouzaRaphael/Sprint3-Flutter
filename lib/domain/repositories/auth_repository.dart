import 'package:lactarehub/domain/entities/registration_draft.dart';
import 'package:lactarehub/domain/entities/test_credential.dart';
import 'package:lactarehub/domain/entities/user_session.dart';

/// Autenticação e cadastro de novas doadoras.
abstract class AuthRepository {
  /// Lança [AuthFailure] quando as credenciais não conferem.
  Future<UserSession> signIn({required String email, required String password});

  Future<UserSession> register(RegistrationDraft draft);

  /// Contas de demonstração mostradas na tela de login.
  List<TestCredential> listTestCredentials();
}
