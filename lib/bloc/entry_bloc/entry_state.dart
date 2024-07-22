
import 'package:equatable/equatable.dart';

import '../../utils/status.dart';

class EntryState extends Equatable {
  final String message;
  final LoginStatus status;

  const EntryState({
    this.message = '',
    this.status = LoginStatus.initial
  });

  EntryState copyWith({
    String? message,
    bool? isLogged,
    LoginStatus? status
  }) {
    return EntryState(
      message: message ?? this.message,
      status: status ?? this.status
    );
  }

  @override
  List<Object?> get props => [message, status];

}

enum LoginStatus {
  initial,
  hasLogged,
  notLogged,
  notRegistered
}
