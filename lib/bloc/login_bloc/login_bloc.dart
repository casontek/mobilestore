
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobilestore/bloc/login_bloc/login_event.dart';
import 'package:mobilestore/bloc/login_bloc/login_state.dart';
import 'package:mobilestore/services/sqlite_service.dart';

import '../../utils/status.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final sqlService = SQLiteService();

  LoginBloc() : super(const LoginState()) {

    on<LoginUser>((event, emit) async {
       //login user using credential
       emit(state.copyWith(status: Status.loading));
       final isLogged = await sqlService.login(event.email, event.password);

       if(isLogged) {
         emit(state.copyWith(status: Status.success));
       }
       else {
         emit(state.copyWith(
             status: Status.failed,
             message: 'invalid credentials.'
         ));
       }
    });

    on<ResetLogin>((event, emit) => emit(state.copyWith(status: Status.initial)));

    on<PasswordVisibilityEvent>((event, emit) => emit(state.copyWith(hidePassword: !state.hidePassword)));

    on<EmailChange>((event, emit) => emit(state.copyWith(email: event.email)));

    on<PasswordChange>((event, emit) => emit(state.copyWith(password: event.password)));

  }

}