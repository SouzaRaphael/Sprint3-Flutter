import 'package:lactarehub/domain/entities/test_credential.dart';
import 'package:lactarehub/domain/repositories/auth_repository.dart';

/// Contas de demonstração exibidas na tela de login.
class GetTestCredentials {
  final AuthRepository _repository;
  const GetTestCredentials(this._repository);

  List<TestCredential> call() => _repository.listTestCredentials();
}
