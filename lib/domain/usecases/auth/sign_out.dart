import 'package:lactarehub/domain/repositories/auth_repository.dart';

/// Encerra a sessão da doadora.
class SignOut {
  final AuthRepository _repository;
  const SignOut(this._repository);

  Future<void> call() => _repository.signOut();
}
