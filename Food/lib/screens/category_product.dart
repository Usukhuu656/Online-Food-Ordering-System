import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/product_model.dart';
import 'package:shop_app/provider/globalProvider.dart';
import 'package:shop_app/widgets/productView.dart';

class CategoryPage extends StatefulWidget {
  final List<ProductModel> allProducts;

  const CategoryPage({required this.allProducts});

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  String selectedCategory = '';
  late List<ProductModel> filteredProducts;

  @override
  void initState() {
    super.initState();
    filteredProducts = widget.allProducts;
  }

  void filterProducts(String category) {
    setState(() {
      selectedCategory = category;
      filteredProducts = widget.allProducts
          .where((product) => product.category == category)
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Categories')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildCategoryButton('Burger', Colors.blue),
                buildCategoryButton('Pizza', Colors.green),
                buildCategoryButton('Pasta', Colors.red),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildCategoryButton('Sandwich', Colors.orange),
                buildCategoryButton('Meat', Colors.purple),
                buildCategoryButton('Soup', Colors.teal),
              ],
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 20.0, 0, 10.0),
                  child: Text(
                    'Products',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: filteredProducts.length,
                    itemBuilder: (context, index) {
                      final product = filteredProducts[index];
                      return ProductViewShop(
                        product,
                        onFavoritePressed: () {
                          Provider.of<Global_provider>(context, listen: false)
                              .toggleFavorite(product);
                        },
                        onCartPressed: () {
                          Provider.of<Global_provider>(context, listen: false)
                              .addCartItems(product);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCategoryButton(String category, Color color) {
    return ElevatedButton(
      onPressed: () => filterProducts(category),
      style: ElevatedButton.styleFrom(
        primary: color,
        minimumSize: Size(145, 50),
      ),
      child: Text(
        category,
        style: TextStyle(fontSize: 13, color: Colors.black),
      ),
    );
  }
}
