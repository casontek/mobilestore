
import 'package:equatable/equatable.dart';
import 'package:mobilestore/models/product.dart';

abstract class ListingEvent extends Equatable {}

class LoadStoreItems extends ListingEvent {

  @override
  List<Object?> get props => [];
}

class FavoriteProduct extends ListingEvent {
  final Product product;

  FavoriteProduct(this.product);

  @override
  List<Object?> get props => [product];

}

class RemoveFavorite extends ListingEvent {
  final Product product;

  RemoveFavorite(this.product);

  @override
  List<Object?> get props => [product];

}