import 'package:flutter/material.dart';

import 'ProductController.dart';

class AllProducts extends StatefulWidget {
  const AllProducts({super.key});

  @override
  State<AllProducts> createState() => _AllProductsState();
}

class _AllProductsState extends State<AllProducts> {
  final ProductController _productController = ProductController();
  void productDialog() {
    TextEditingController productNameController = TextEditingController();
    TextEditingController productImgController = TextEditingController();
    TextEditingController productQuantityController = TextEditingController();
    TextEditingController productUnitPriceController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add Product'),
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
                      //productDialog();
                    },
                    child: Text('Cancel')),
                ElevatedButton(onPressed: () {}, child: Text('Add Product')),
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
      appBar: AppBar(
        title: Text('All Products'),
      ),
      body: ListView.builder(
        itemCount: _productController.products.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 4,
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: ListTile(
              leading: SizedBox(
                height: 70,
                width: 50,
                child: Image.network(
                    'https://istorepreowned.co.za/cdn/shop/products/iPhone_13_Pro_Gold_d0f87a71-e692-4282-aa59-83608a1bd7ed.png?v=1710874226'),
              ),
              title: Text(
                'iPhone 13 Pro',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text('Price: \$1000 | Qty: 20'),
              //////////////////////////////////////////////////////////////// Edit and Delete
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                      onPressed: () => productDialog(), icon: Icon(Icons.edit)),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.delete),
                    color: Colors.red,
                  ),
                ],
              ),
            ),
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
