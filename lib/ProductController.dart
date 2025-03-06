import 'dart:convert';

import 'package:http/http.dart';
import 'package:products_ostad/urls/urls.dart';
import 'package:http/http.dart' as http;

class ProductController {
  List products = [];
  /////////////////////////////////////////////////////////// Fetch the products
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

  ////////////////////////////////////////////////////////////////Create Product
  Future<void> createProducts(
      String name, String img, int qty, int unitPrice) async {
    final response = await http.post(
      Uri.parse(Urls.createProduct),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "ProductName": name,
        "ProductCode": DateTime.now().millisecondsSinceEpoch,
        "Img": img,
        "Qty": qty,
        "UnitPrice": unitPrice,
        "TotalPrice": qty * unitPrice
      }),
    );

    if (response.statusCode == 201) {
      fetchProducts();
    } else {
      // Handle error
    }
  }
}
