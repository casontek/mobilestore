
import 'package:equatable/equatable.dart';
import 'package:mobilestore/utils/status.dart';

import '../../models/user.dart';


class ProfileState extends Equatable {
  final User? user;
  final String message;
  final Status status;
  final bool isEditing;
  final String name;
  final String phone;
  final String address;

  const ProfileState({
    this.user,
    this.message = '',
    this.name = '',
    this.phone = '',
    this.address = '',
    this.status = Status.initial,
    this.isEditing = false
  });

  ProfileState copyWith({
    User? user,
    String? message,
    Status? status,
    bool? isEditing,
    String? name,
    String? phone,
    String? address
  }){
    return ProfileState(
      message: message ?? this.message,
      user: user ?? this.user,
      status: status ?? this.status,
      isEditing: isEditing ?? this.isEditing,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      address: address ?? this.address
    );
  }

  @override
  List<Object?> get props => [message, user, status, isEditing, name, phone, address];

}