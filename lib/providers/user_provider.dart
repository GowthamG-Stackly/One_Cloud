// import 'package:flutter/foundation.dart';

// class UserProvider extends ChangeNotifier {
//   // Registered user details
//   String _registeredName = '';
//   String _registeredEmail = '';
//   String _registeredPassword = '';

//   // Currently logged-in user
//   String _name = '';
//   String _email = '';
//   bool _isLoggedIn = false;

//   String get name => _name;
//   String get email => _email;
//   bool get isLoggedIn => _isLoggedIn;

//   // REGISTER
//   void register(String name, String email, String password) {
//     _registeredName = name;
//     _registeredEmail = email;
//     _registeredPassword = password;

//     notifyListeners();
//   }

//   // CHECK LOGIN
//   bool validateLogin(String email, String password) {
//     return email == _registeredEmail && password == _registeredPassword;
//   }

//   // LOGIN
//   void login(String email) {
//     _name = _registeredName;
//     _email = email;
//     _isLoggedIn = true;

//     notifyListeners();
//   }

//   bool emailExists(String email) {
//     return email == _registeredEmail;
//   }

//   void resetPassword(String email, String newPassword) {
//     if (email == _registeredEmail) {
//       _registeredPassword = newPassword;
//       notifyListeners();
//     }
//   }

//   // LOGOUT
//   void logout() {
//     _name = '';
//     _email = '';
//     _isLoggedIn = false;

//     notifyListeners();
//   }
// }

import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserState {
  final String registeredName;
  final String registeredEmail;
  final String registeredPassword;
  final String name;
  final String email;
  final bool isLoggedIn;

  const UserState({
    this.registeredName = '',
    this.registeredEmail = '',
    this.registeredPassword = '',
    this.name = '',
    this.email = '',
    this.isLoggedIn = false,
  });

  UserState copyWith({
    String? registeredName,
    String? registeredEmail,
    String? registeredPassword,
    String? name,
    String? email,
    bool? isLoggedIn,
  }) {
    return UserState(
      registeredName: registeredName ?? this.registeredName,
      registeredEmail: registeredEmail ?? this.registeredEmail,
      registeredPassword: registeredPassword ?? this.registeredPassword,
      name: name ?? this.name,
      email: email ?? this.email,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
    );
  }
}

class UserNotifier extends Notifier<UserState> {
  @override
  UserState build() {
    return const UserState();
  }

  // REGISTER
  void register(String name, String email, String password) {
    state = state.copyWith(
      registeredName: name,
      registeredEmail: email,
      registeredPassword: password,
    );
  }

  // CHECK LOGIN
  bool validateLogin(String email, String password) {
    return email == state.registeredEmail &&
        password == state.registeredPassword;
  }

  // LOGIN
  void login(String email) {
    state = state.copyWith(
      name: state.registeredName,
      email: email,
      isLoggedIn: true,
    );
  }

  // CHECK EMAIL
  bool emailExists(String email) {
    return email == state.registeredEmail;
  }

  // RESET PASSWORD
  void resetPassword(String email, String newPassword) {
    if (email == state.registeredEmail) {
      state = state.copyWith(registeredPassword: newPassword);
    }
  }

  // LOGOUT
  void logout() {
    state = state.copyWith(name: '', email: '', isLoggedIn: false);
  }
}

final userProvider = NotifierProvider<UserNotifier, UserState>(
  UserNotifier.new,
);
