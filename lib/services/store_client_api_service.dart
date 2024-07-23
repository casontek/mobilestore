
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mobilestore/constants.dart';
import 'package:mobilestore/models/product.dart';
import 'package:mobilestore/utils/request_result.dart';

import '../utils/status.dart';

class StoreClientApiService {

  Future<Result<List<Product>>> getProducts() async {
    final productsRequest = Uri.https(
        baseUrl,
        '/products'
    );
    try {
      final response = await http.get(productsRequest);
      if(response.statusCode == 200) {
        try {
          final data = jsonDecode(response.body) as List;

          print('@@@@@@@@@@@@@@@@@@@@ $data');
          //checks if their is product
          if (data.isEmpty) {
            return Result(
                'Empty product.',
                Status.failed,
                null
            );
          }

          final products = data.map((e) => Product.fromJson(e)).toList();
          return Result(
              'success',
              Status.success,
              products
          );
        }
        catch (e) {
          print('@@@@@@@@@@@@@@@@@@@@ $e');
          return Result(
              'Internal server error!',
              Status.failed,
              null
          );
        }
      }
      else {
        return Result(
            'Network issue. try again!',
            Status.failed,
            null
        );
      }
    }
    catch(e) {
      return Result(
          'Request failed.',
          Status.failed,
          null);
    }
  }

}