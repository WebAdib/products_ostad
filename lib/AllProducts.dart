import 'package:flutter/material.dart';

import 'ProductController.dart';
import 'widget/productCard.dart';

class AllProducts extends StatefulWidget {
  const AllProducts({super.key});

  @override
  State<AllProducts> createState() => _AllProductsState();
}

class _AllProductsState extends State<AllProducts> {
  final ProductController _productController = ProductController();
  void productDialog(
      {String? id, String? name, String? img, int? qty, int? unitPrice}) {
    TextEditingController productNameController = TextEditingController();
    TextEditingController productImgController = TextEditingController();
    TextEditingController productQuantityController = TextEditingController();
    TextEditingController productUnitPriceController = TextEditingController();

    productNameController.text = name ?? "";
    productImgController.text = img ?? "";
    productQuantityController.text = qty != null ? qty.toString() : "0";
    productUnitPriceController.text =
        unitPrice != null ? unitPrice.toString() : "0";

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(id == null ? 'Add Product' : 'Update Product'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: productNameController,
              decoration: InputDecoration(labelText: 'Product Name'),
            ),
            TextField(
              controller: productImgController,
              decoration: InputDecoration(labelText: 'Product Img'),
            ),
            TextField(
              controller: productQuantityController,
              decoration: InputDecoration(labelText: 'Product Quantity'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: productUnitPriceController,
              decoration: InputDecoration(labelText: 'Unit Price'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Cancel')),
                ElevatedButton(
                    onPressed: () {
                      if (id != null) {
                        _productController.updateProducts(
                          id,
                          productNameController.text,
                          productImgController.text,
                          int.parse(productQuantityController.text),
                          int.parse(productUnitPriceController.text),
                        );
                      } else {
                        _productController.createProducts(
                          productNameController.text,
                          productImgController.text,
                          int.parse(productQuantityController.text),
                          int.parse(productUnitPriceController.text),
                        );
                      }
                      fetchData();
                      Navigator.pop(context);
                      setState(() {});
                    },
                    child: Text(id == null ? 'Add Product' : 'Update Product')),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> fetchData() async {
    await _productController.fetchProducts();
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      appBar: AppBar(
        title: Text('All Products'),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 0,
          crossAxisSpacing: 0,
          childAspectRatio: 0.65,
        ),
        itemCount: _productController.products.length,
        itemBuilder: (context, index) {
          var products = _productController.products[index];
          return ProductCard(
            products: products,
            onEdit: () => productDialog(
                id: products.sId,
                name: products.productName,
                img: products.img,
                qty: products.qty,
                unitPrice: products.unitPrice),
            onDelete: () {
              _productController.deleteProducts(products.sId.toString()).then(
                (value) {
                  if (value == true) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Product deleted successfully.'),
                    ));
                    fetchData();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Failed to delete product.'),
                    ));
                    fetchData();
                  }
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => productDialog(),
        child: Icon(Icons.add),
      ),
    );
  }
}
/*
Card(
            elevation: 4,
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: ListTile(
              leading: SizedBox(
                height: 70,
                width: 50,
                child: Image.network(products.img.toString()),
              ),
              title: Text(
                products.productName.toString(),
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                  'Price: \$ ${products.unitPrice} | Qty: ${products.qty}'),
              //////////////////////////////////////////////////////////////// Edit and Delete
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                      onPressed: () => productDialog(
                          id: products.sId,
                          name: products.productName,
                          img: products.img,
                          qty: products.qty,
                          unitPrice: products.unitPrice),
                      icon: Icon(Icons.edit)),
                  IconButton(
                    onPressed: () {
                      _productController
                          .deleteProducts(products.sId.toString())
                          .then((value) {
                        if (value == true) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Product deleted successfully.'),
                          ));
                          fetchData();
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Failed to delete product.'),
                          ));
                          fetchData();
                        }
                      });
                    },
                    icon: Icon(Icons.delete),
                    color: Colors.red,
                  ),
                ],
              ),
            ),
          );
 */
