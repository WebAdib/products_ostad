import 'package:flutter/material.dart';

import '../model/product.dart';

class ProductCard extends StatelessWidget {
  final Data products;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const ProductCard(
      {super.key,
      required this.products,
      required this.onEdit,
      required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey),
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.white,
          //     spreadRadius: 5,
          //     offset: Offset(0, 3),
          //   ),
          // ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRect(
                child: Center(
                  child: Container(
                    height: 150,
                    //color: Colors.blue.shade500,
                    child: Image.network(
                      products.img.toString(),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    products.productName.toString(),
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    'Price: \$ ${products.unitPrice} | Quantity: ${products.qty}',
                    style: TextStyle(fontSize: 14, color: Colors.black54),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 10),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: onEdit,
                    icon: Icon(Icons.edit),
                  ),
                  IconButton(
                    onPressed: onDelete,
                    icon: Icon(Icons.delete, color: Colors.red),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
    ;
  }
}
