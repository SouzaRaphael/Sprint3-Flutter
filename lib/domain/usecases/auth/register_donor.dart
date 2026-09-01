import 'package:lactarehub/domain/entities/registration_draft.dart';
import 'package:lactarehub/domain/entities/user_session.dart';
import 'package:lactarehub/domain/repositories/auth_repository.dart';

/// Conclui o cadastro de uma nova doadora.
class RegisterDonor {
  final AuthRepository _repository;
  const RegisterDonor(this._repository);

  Future<UserSession> call(RegistrationDraft draft) => _repository.register(draft);
}
