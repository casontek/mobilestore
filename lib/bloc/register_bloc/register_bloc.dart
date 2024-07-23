
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobilestore/bloc/register_bloc/register_event.dart';
import 'package:mobilestore/bloc/register_bloc/register_state.dart';
import 'package:mobilestore/models/user.dart';

import '../../services/sqlite_service.dart';
import '../../utils/status.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final sqlService = SQLiteService();

  RegisterBloc() : super(const RegisterState()) {

    on<EmailChange>((event, emit) => emit(state.copyWith(email: event.email)));

    on<PasswordChange>((event, emit) => emit(state.copyWith(password: event.password)));

    on<ConfirmPasswordChange>((event, emit) => emit(state.copyWith(confirmPass: event.password)));

    on<PasswordVisibilityEvent>((event, emit) => emit(state.copyWith(hidePassword: !state.hidePassword)));

    on<RegisterReset>((event, emit) => emit(state.copyWith(status: Status.initial)));

    on<RegisterUser>((event, emit) async {
      emit(state.copyWith(status: Status.loading));
      try {
        final user = User('', event.email, '');
        //create user account
        await sqlService.saveUser(user);
        //add user login credential
        await sqlService.saveLoginCredentials(event.email, event.password);
        emit(state.copyWith(status: Status.success));
      }
      catch(e) {
        emit(state.copyWith(
            status: Status.failed,
            message: 'account creation failed.'
        ));
      }
    });

  }

}