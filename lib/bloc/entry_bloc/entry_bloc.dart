
import 'package:bloc/bloc.dart';
import 'package:mobilestore/bloc/entry_bloc/entry_event.dart';
import 'package:mobilestore/bloc/entry_bloc/entry_state.dart';

import '../../services/sqlite_service.dart';

class EntryBloc extends Bloc<EntryEvent, EntryState> {
  final sqlService = SQLiteService();

  EntryBloc() : super(const EntryState()) {
    on<CheckLogin>((event, emit) async {
        //check if any user is logged
        final isLogged = await sqlService.isLogged();
        if(isLogged) {
          emit(state.copyWith(
              status: LoginStatus.hasLogged,
              message: 'User is logged.'
          ));
        }
        else {
          emit(state.copyWith(
              status: LoginStatus.notLogged,
              message: 'User not logged.'
          ));
        }
    });
  }

}