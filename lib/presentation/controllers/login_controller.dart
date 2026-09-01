import 'package:flutter/foundation.dart';
import 'package:lactarehub/core/di/service_locator.dart';
import 'package:lactarehub/domain/entities/user_session.dart';

/// Estado da tela de login.
class LoginController extends ChangeNotifier {
  bool _isLoading = false;
  bool _obscurePassword = true;
  String? _errorMessage;
  UserSession? _session;

  bool get isLoading => _isLoading;
  bool get obscurePassword => _obscurePassword;
  String? get errorMessage => _errorMessage;
  UserSession? get session => _session;

  void togglePasswordVisibility() {
    _obscurePassword = !_obscurePassword;
    notifyListeners();
  }

  /// Devolve `true` quando a autenticação foi bem-sucedida.
  Future<bool> signIn({required String email, required String password}) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _session = await ServiceLocator.signIn(email: email, password: password);
      return true;
    } on AuthFailure catch (failure) {
      _errorMessage = failure.message;
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
