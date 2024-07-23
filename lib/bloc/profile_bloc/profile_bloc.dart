
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobilestore/bloc/profile_bloc/profile_event.dart';
import 'package:mobilestore/bloc/profile_bloc/profile_state.dart';
import 'package:mobilestore/models/user.dart';
import 'package:mobilestore/services/sqlite_service.dart';
import 'package:mobilestore/utils/status.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final sqlService = SQLiteService();

  ProfileBloc() : super(const ProfileState()) {

    on<GetUserData>((event, emit) async {
      //gets signed user from local db
      final user = await sqlService.getUser();
      if(user != null) {
        emit(state.copyWith(
            user: user,
            status: Status.loaded
        ));
      }
    });

    on<ResetState>((event, emit) => emit(state.copyWith(status: Status.initial)));

    on<NameChange>((event, emit) => emit(state.copyWith(name: event.name)));

    on<PhoneChange>((event, emit) => emit(state.copyWith(phone: event.phone)));

    on<AddressChange>((event, emit) => emit(state.copyWith(address: event.address)));

    on<EditProfile>((event, emit) => emit(state.copyWith(isEditing: true)));

    on<SubmitEdit>((event, emit) async {
      emit(state.copyWith(isEditing: false));
      //update user from local db
      final user = User(state.name, state.user!.email, state.user?.picture, state.phone, state.address);
      final result = await sqlService.updateUser(user);
      if(!result) {
        emit(state.copyWith(
            isEditing: true,
            status: Status.failed,
            message: 'failed to update!'
        ));
      }
    });

  }

}