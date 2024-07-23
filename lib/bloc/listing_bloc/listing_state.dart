
import 'package:equatable/equatable.dart';
import 'package:mobilestore/models/product.dart';

import '../../utils/status.dart';

class ListingState extends Equatable {
  final Status status;
  final String message;
  final List<Product> products;
  final List<Product> favorites;

  const ListingState({
    this.message = '',
    this.status = Status.initial,
    this.products = const [],
    this.favorites = const []
  });

  ListingState copyWith({
    Status? status,
    String? message,
    List<Product>? products,
    List<Product>? favorites
  }) {
    return ListingState(
      status: status ?? this.status,
      message: message ?? this.message,
      products: products ?? this.products,
      favorites: favorites ?? this.favorites
    );
  }

  @override
  List<Object?> get props => [status, message, products, favorites];

}