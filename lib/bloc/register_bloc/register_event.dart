
import 'package:equatable/equatable.dart';

abstract class RegisterEvent extends Equatable {}

class RegisterUser extends RegisterEvent {
  final String email;
  final String password;

  RegisterUser(this.email, this.password);

  @override
  List<Object?> get props => [email, password];

}

class RegisterReset extends RegisterEvent {
  @override
  List<Object?> get props => [];
}

class EmailChange extends RegisterEvent {
  final String email;

  EmailChange(this.email);

  @override
  List<Object?> get props => [email];
}

class PasswordChange extends RegisterEvent {
  final String password;

  PasswordChange(this.password);

  @override
  List<Object?> get props => [password];
}

class ConfirmPasswordChange extends RegisterEvent {
  final String password;

  ConfirmPasswordChange(this.password);

  @override
  List<Object?> get props => [password];
}