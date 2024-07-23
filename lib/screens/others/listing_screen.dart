
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobilestore/bloc/listing_bloc/listing_bloc.dart';
import 'package:mobilestore/bloc/listing_bloc/listing_event.dart';
import 'package:mobilestore/bloc/listing_bloc/listing_state.dart';
import 'package:mobilestore/models/product.dart';
import 'package:mobilestore/widgets/custom_button_widget.dart';
import 'package:mobilestore/widgets/custom_text_widget.dart';

import '../../utils/status.dart';

class ListingScreen extends StatelessWidget {

  const ListingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => ListingBloc(),
        child: const _ListingScreenProvider()
    );
  }

}

class _ListingScreenProvider extends StatefulWidget {

  const _ListingScreenProvider();

  @override
  State<StatefulWidget> createState() => _ListingScreen();

}

class _ListingScreen extends State<_ListingScreenProvider> {
  double horizontalPadding = 18.0;
  double itemSpacing = 12.0;

  @override
  void initState() {
    super.initState();
    context.read<ListingBloc>().add(LoadStoreItems());
  }

  @override
  Widget build(BuildContext context) {
    double itemWidth = (MediaQuery.of(context).size.width - ((horizontalPadding * 2) + itemSpacing))/ 2;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
            statusBarColor: Theme.of(context).colorScheme.surface,
            statusBarIconBrightness: Brightness.dark
        ));
    return BlocBuilder<ListingBloc, ListingState>(
        builder: (context, state) {
          return Scaffold(
              appBar: state.status == Status.success ?
                AppBar(
                    title: const Text('Kings Mobile Store'),
                    titleTextStyle: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontFamily: 'Roboto',
                      fontSize: 23,
                  ),
                    //backgroundColor: Theme.of(context).colorScheme.secondary,
                    actions: <Widget>[
                      IconButton(
                        icon: const Icon(Icons.person),
                        color: Theme.of(context).colorScheme.primary,
                        onPressed: () => Navigator.pushNamed(context, '/profile'),
                      )
                    ]
                ) : null,
              backgroundColor: Theme.of(context).colorScheme.surface,
              body: SafeArea(
                  child: BlocBuilder<ListingBloc, ListingState>(
                      builder: (context, state) {
                        return state.status == Status.loading ?
                        const Center(child: SizedBox(
                            width: 35,
                            height: 35,
                            child: CircularProgressIndicator(
                                strokeWidth: 8.0,
                                strokeCap: StrokeCap.round,
                                color: Colors.grey
                            )
                        )) :
                        state.status == Status.failed ?
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                customTextWidget(
                                    label: state.message,
                                    size: 14,
                                    weight: FontWeight.normal,
                                    textColor: Theme.of(context).colorScheme.primary
                                ),
                                const SizedBox(height: 8.0),
                                customButtonWidget(
                                    label: 'Reload Product',
                                    context: context,
                                    onClick: () =>
                                        context.read<ListingBloc>().add(LoadStoreItems())
                                )
                              ],
                            )
                        ) :
                        SingleChildScrollView(
                          padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 8.0),
                          child: Wrap(
                            spacing: itemSpacing,
                            runSpacing: itemSpacing,
                            alignment: WrapAlignment.center,
                            children: [
                              ...state.products.map((product) =>
                                  productItemWidget(
                                      product: product,
                                      itemWidth: itemWidth,
                                      context: context,
                                      favorites: state.favorites,
                                      onSelect: (product) {
                                        Navigator.pushNamed(
                                          context,
                                          '/product',
                                          arguments: product,
                                        );
                                      },
                                      onFavorite: (product, favorite) {
                                        context.read<ListingBloc>().add(favorite ?
                                        RemoveFavorite(product) : FavoriteProduct(product));
                                      }
                                  ))
                            ],
                          ),
                        );
                      })
              )
          );
        });
  }

}

Widget productItemWidget({
  required Product product,
  required double itemWidth,
  required BuildContext context,
  required List<Product> favorites,
  required Function(Product product) onSelect,
  required Function(Product product, bool isFavorite) onFavorite
}) {
  bool isFavorite = favorites.contains(product);

  return GestureDetector(
    onTap: () => onSelect(product),
    child: Container(
      width: itemWidth,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: Colors.grey.withOpacity(0.3)
      ),
      child: Stack(
        children: [
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: CachedNetworkImage(
                        imageUrl: product.image ?? '',
                        fit: BoxFit.contain,
                        width: itemWidth,
                        height: itemWidth,
                        errorWidget: (_, url, data) {
                          return Container(
                            color: Colors.grey,
                            width: itemWidth,
                            height: itemWidth,
                          );
                        },
                        progressIndicatorBuilder: (_, url, progress) {
                          return Container(
                            color: Colors.grey,
                            width: itemWidth,
                            height: itemWidth,
                          );
                        }
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    product.title ?? '',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Roboto',
                        color: Theme.of(context).colorScheme.primary
                    ),
                    maxLines: 1,
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    'Price: ${product.price}',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Roboto',
                        color: Theme.of(context).colorScheme.secondary
                    ),
                    maxLines: 1,
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              )
          ),
          Positioned(
              bottom: 4.0,
              right: 6.0,
              child: GestureDetector(
                onTap: () => onFavorite(product, isFavorite),
                child: Icon(
                    isFavorite ? Icons.favorite_rounded :
                    Icons.favorite_border_rounded,
                    color: Colors.pink
                )
              )
          )
        ],
      ),
    )
  );
}