
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobilestore/bloc/profile_bloc/profile_event.dart';
import 'package:mobilestore/bloc/profile_bloc/profile_state.dart';
import 'package:mobilestore/services/sqlite_service.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final sqlService = SQLiteService();

  ProfileBloc() : super(const ProfileState()) {

    on<GetUserData>((event, emit) async {
      //gets signed user from local db
      final user = await sqlService.getUser();
      if(user != null) {
        emit(state.copyWith(user: user));
      }

    });

    on<NameChange>((event, emit) => emit(state.copyWith(name: event.name)));

    on<PhoneChange>((event, emit) => emit(state.copyWith(phone: event.phone)));

  }

}