import 'package:lactarehub/domain/entities/user_session.dart';
import 'package:lactarehub/domain/repositories/auth_repository.dart';

/// Autentica uma pessoa com e-mail e senha.
class SignIn {
  final AuthRepository _repository;
  const SignIn(this._repository);

  Future<UserSession> call({required String email, required String password}) =>
      _repository.signIn(email: email, password: password);
}
