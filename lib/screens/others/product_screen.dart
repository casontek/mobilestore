
import 'package:cached_network_image/cached_network_image.dart';
import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:mobilestore/models/product.dart';
import 'package:mobilestore/widgets/custom_text_widget.dart';

class ProductScreen extends StatefulWidget {

  const ProductScreen({super.key});

  @override
  State<StatefulWidget> createState() => _ProductScreen();

}

class _ProductScreen extends State<ProductScreen> {

  @override
  Widget build(BuildContext context) {
    final Product product = ModalRoute.of(context)!.settings.arguments as Product;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 42),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: CachedNetworkImage(
                      imageUrl: product.image ?? '',
                      fit: BoxFit.contain,
                      errorWidget: (_, url, data) {
                        return Container(
                          color: Colors.grey,
                          width: double.infinity,
                          height: 240,
                        );
                      },
                      progressIndicatorBuilder: (_, url, progress) {
                        return Container(
                          color: Colors.grey,
                          width: double.infinity,
                          height: 240,
                        );
                      }
                  ),
                )
              ),
              const SizedBox(height: 10.0),
              Expanded(child: Text(
                  product.title ?? '',
                  style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary
                  ),
                  textAlign: TextAlign.start
              )),
              customTextWidget(
                  label: '${product.category}',
                  size: 16,
                  weight: FontWeight.normal,
                  textColor: Theme.of(context).colorScheme.secondary
              ),
              RatingBar(
                  filledIcon: Icons.star,
                  isHalfAllowed: true,
                  emptyIcon: Icons.star_border,
                  halfFilledIcon: Icons.star_half,
                  onRatingChanged: (value) => debugPrint('$value'),
                  initialRating: product.rating?.rate ?? 0.0,
                  size: 28.0,
                  maxRating: 5
              ),
              const SizedBox(height: 4.0),
              customTextWidget(
                  label: 'Price: ${product.price}',
                  size: 16,
                  weight: FontWeight.bold,
                  textColor: Theme.of(context).colorScheme.secondary
              ),
              const SizedBox(height: 10.0),
              Expanded(child: Text(
                  product.description ?? '',
                  style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.normal,
                      color: Theme.of(context).colorScheme.primary
                  ),
                  textAlign: TextAlign.start
              ))
            ],
          )
        )
      )
    );
  }

}