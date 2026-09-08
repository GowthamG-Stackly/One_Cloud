import 'package:flutter/foundation.dart';

class UserProvider extends ChangeNotifier {
  // Registered user details
  String _registeredName = '';
  String _registeredEmail = '';
  String _registeredPassword = '';

  // Currently logged-in user
  String _name = '';
  String _email = '';
  bool _isLoggedIn = false;

  String get name => _name;
  String get email => _email;
  bool get isLoggedIn => _isLoggedIn;

  // REGISTER
  void register(String name, String email, String password) {
    _registeredName = name;
    _registeredEmail = email;
    _registeredPassword = password;

    notifyListeners();
  }

  // CHECK LOGIN
  bool validateLogin(String email, String password) {
    return email == _registeredEmail && password == _registeredPassword;
  }

  // LOGIN
  void login(String email) {
    _name = _registeredName;
    _email = email;
    _isLoggedIn = true;

    notifyListeners();
  }

  bool emailExists(String email) {
    return email == _registeredEmail;
  }

  void resetPassword(String email, String newPassword) {
    if (email == _registeredEmail) {
      _registeredPassword = newPassword;
      notifyListeners();
    }
  }

  // LOGOUT
  void logout() {
    _name = '';
    _email = '';
    _isLoggedIn = false;

    notifyListeners();
  }
}
