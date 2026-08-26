import '../models/user_role.dart';

class AuthService {
  bool _isLoggedIn = false;
  UserRole? _role;

  bool get isLoggedIn => _isLoggedIn;

  UserRole? get role => _role;

  Future<bool> login(
      String email,
      String password,
      UserRole role,
      ) async {
    // Temporary login simulation.
    await Future.delayed(
      const Duration(seconds: 1),
    );

    if (email.trim().isEmpty || password.isEmpty) {
      return false;
    }

    _isLoggedIn = true;
    _role = role;

    return true;
  }

  void logout() {
    _isLoggedIn = false;
    _role = null;
  }
}
