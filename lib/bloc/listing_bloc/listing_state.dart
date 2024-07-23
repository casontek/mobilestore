
import 'package:equatable/equatable.dart';
import 'package:mobilestore/models/product.dart';

import '../../utils/status.dart';

class ListingState extends Equatable {
  final Status status;
  final String message;
  final List<Product> products;

  const ListingState({
    this.message = '',
    this.status = Status.initial,
    this.products = const []
  });

  ListingState copyWith({
    Status? status,
    String? message,
    List<Product>? products
  }) {
    return ListingState(
      status: status ?? this.status,
      message: message ?? this.message,
      products: products ?? this.products
    );
  }

  @override
  List<Object?> get props => [status, message, products];

}