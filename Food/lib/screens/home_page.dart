import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shop_app/models/product_model.dart';
import 'package:shop_app/screens/category_product.dart';
import 'shopping_cart_page.dart';
import 'shop_page.dart';
import 'favorite_page.dart';
import 'profile_page.dart';

Future<List<ProductModel>> _getProducts(BuildContext context) async {
  final String jsonString =
      await DefaultAssetBundle.of(context).loadString('assets/products.json');
  final List<dynamic> jsonList = json.decode(jsonString);
  return jsonList.map((json) => ProductModel().fromJson(json)).toList();
}

class HomePage extends StatefulWidget {
  final String loggedInCustomer;

  HomePage({Key? key, required this.loggedInCustomer}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ProductModel>>(
      future: _getProducts(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          return Scaffold(
            body: getPages(snapshot.data ?? []),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: selectedIndex,
              onTap: (index) {
                setState(() {
                  selectedIndex = index;
                });
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.shop),
                  label: 'Menu',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.menu),
                  label: 'Category',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_basket),
                  label: 'Shopping Cart',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.favorite),
                  label: 'Favorite',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Profile',
                ),
              ],
            ),
          );
        }
      },
    );
  }

  Widget getPages(List<ProductModel> products) {
    return IndexedStack(
      index: selectedIndex,
      children: [
        ShopPage(),
        CategoryPage(allProducts: products),
        ShoppingCartPage(),
        FavoritePage(),
        ProfilePage(loggedInCustomer: widget.loggedInCustomer),
      ],
    );
  }
}
