
import 'package:equatable/equatable.dart';

import '../../utils/status.dart';

class LoginState extends Equatable {
  final String email;
  final String password;
  final bool hidePassword;
  final Status status;
  final String message;

  const LoginState({
    this.email = '',
    this.password = '',
    this.message = '',
    this.hidePassword = true,
    this.status = Status.initial,
  });

  LoginState copyWith({
    String? email,
    String? password,
    bool? hidePassword,
    String? message,
    Status? status,
  }) {
    return LoginState(
        email: email ?? this.email,
        message: message ?? this.message,
        password: password ?? this.password,
        hidePassword: hidePassword ?? this.hidePassword,
        status: status ?? this.status
    );
  }

  bool get isValidPassword => password.isNotEmpty;
  String? get isValidEmail => validateEmail();

  String? validateEmail() {
    if(email.isEmpty) {
      return 'email address is required.';
    }
    else {
      final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');

      if (!emailRegex.hasMatch(email)) {
        return 'Please enter a valid email';
      }
    }

    return null;
  }

  String? validatePassword() {
    if(password.isEmpty) {
      return 'password is required.';
    }
    else {
      final passwordRegExp = RegExp(r'^(?=.*[A-Z])(?=.*\d)[A-Za-z\d]{6,}$',);
      return passwordRegExp.hasMatch(password) ? null : 'Invalid password.';
    }
  }

  @override
  List<Object?> get props => [email, password, status, message, hidePassword];

}