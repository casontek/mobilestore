
import 'package:equatable/equatable.dart';

abstract class EntryEvent extends Equatable {}

class CheckLogin extends EntryEvent {

  @override
  List<Object?> get props => [];
}