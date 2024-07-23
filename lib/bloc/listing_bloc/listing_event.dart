
import 'package:equatable/equatable.dart';

abstract class ListingEvent extends Equatable {}

class LoadStoreItems extends ListingEvent {

  @override
  List<Object?> get props => [];
}