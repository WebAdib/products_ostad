import 'dart:convert';

import 'package:http/http.dart';
import 'package:products_ostad/urls/urls.dart';
import 'package:http/http.dart' as http;

class ProductController {
  List products = [];
  Future<void> fetchProducts() async {
    final url = Uri.parse(Urls.readProduct);
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      products = data['data'];
      // Process the products here
    } else {
      // Handle error
    }
  }
}
