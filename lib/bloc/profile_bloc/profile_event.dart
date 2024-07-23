
import 'package:equatable/equatable.dart';

abstract class ProfileEvent extends Equatable {}

class GetUserData extends ProfileEvent {

  @override
  List<Object?> get props => [];
}

class NameChange extends ProfileEvent {
  final String name;

  NameChange(this.name);

  @override
  List<Object?> get props => [name];
}

class PhoneChange extends ProfileEvent {
  final String phone;

  PhoneChange(this.phone);

  @override
  List<Object?> get props => [phone];
}

class AddressChange extends ProfileEvent {
  final String address;

  AddressChange(this.address);

  @override
  List<Object?> get props => [address];
}