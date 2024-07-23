
import 'package:equatable/equatable.dart';
import '../../utils/status.dart';

class RegisterState extends Equatable {
  final String email;
  final String password;
  final String confirmPass;
  final bool hidePassword;
  final Status status;
  final String message;

  const RegisterState({
    this.email = '',
    this.password = '',
    this.hidePassword = true,
    this.message = '',
    this.confirmPass = '',
    this.status = Status.initial,
  });

  RegisterState copyWith({
    String? email,
    String? password,
    String? confirmPass,
    bool? hidePassword,
    String? message,
    Status? status,
  }) {
    return RegisterState(
        email: email ?? this.email,
        message: message ?? this.message,
        password: password ?? this.password,
        hidePassword: hidePassword ?? this.hidePassword,
        confirmPass: confirmPass ?? this.confirmPass,
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
    return null;
  }

  String? validateConfirmPassword() {
    if(confirmPass != password) {
      return 'password not match';
    }

    return null;
  }

  @override
  List<Object?> get props => [email, password, status, message, confirmPass, hidePassword];

}