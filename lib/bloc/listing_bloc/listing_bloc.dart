
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobilestore/bloc/listing_bloc/listing_event.dart';
import 'package:mobilestore/bloc/listing_bloc/listing_state.dart';
import 'package:mobilestore/models/product.dart';
import 'package:mobilestore/services/store_client_api_service.dart';

import '../../utils/status.dart';

class ListingBloc extends Bloc<ListingEvent, ListingState>{
  final clientService = StoreClientApiService();

  ListingBloc() : super(const ListingState()) {

    on<LoadStoreItems>((event, emit) async {
      emit(state.copyWith(status: Status.loading));
      final result = await clientService.getProducts();
      if(result.status == Status.success) {
        emit(state.copyWith(
            status: Status.success,
            products: result.data
        ));
      }
      else {
        emit(state.copyWith(
            status: Status.failed,
            message: result.message
        ));
      }
    });

    on<FavoriteProduct>((event, emit) {
      List<Product> favoriteProducts = List.from(state.favorites);
      favoriteProducts.add(event.product);
      //update favorite list
      emit(state.copyWith(favorites: favoriteProducts));
    });

    on<RemoveFavorite>((event, emit) {
      List<Product> favoriteProducts = List.from(state.favorites);
      favoriteProducts.removeWhere((favorite) => favorite == event.product);
      //update favorite list
      emit(state.copyWith(favorites: favoriteProducts));
    });

  }

}