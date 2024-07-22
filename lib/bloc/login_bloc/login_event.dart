
import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {}

class LoginUser extends LoginEvent {
  final String email;
  final String password;

  LoginUser(this.email, this.password);

  @override
  List<Object?> get props => [email, password];

}

class ResetLogin extends LoginEvent {

  @override
  List<Object?> get props => [];
}

class PasswordVisibilityEvent extends LoginEvent {
  PasswordVisibilityEvent();

  @override
  List<Object?> get props => [];

}

class EmailChange extends LoginEvent {
  final String email;

  EmailChange(this.email);

  @override
  List<Object?> get props => [email];
}

class PasswordChange extends LoginEvent {
  final String password;

  PasswordChange(this.password);

  @override
  List<Object?> get props => [password];
}