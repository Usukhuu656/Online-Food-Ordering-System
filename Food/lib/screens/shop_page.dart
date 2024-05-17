import 'dart:math';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/product_model.dart';
import 'package:shop_app/provider/globalProvider.dart';
import 'package:shop_app/widgets/productView.dart';
import 'dart:convert';
import 'dart:ui';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  Future<List<ProductModel>> _getData() async {
    String res =
        await DefaultAssetBundle.of(context).loadString("assets/products.json");
    List<ProductModel> data = ProductModel.fromList(jsonDecode(res));
    Provider.of<Global_provider>(context, listen: false).setProducts(data);
    return Provider.of<Global_provider>(context, listen: false).products;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getData(),
      builder: ((context, snapshot) {
        if (snapshot.hasData) {
          List<ProductModel> products = snapshot.data!;
          List<ProductModel> firstProducts = products.skip(17).take(3).toList();
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: 150,
                  color: const Color(0xFFFDD017),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/logo.png',
                        width: 260,
                        height: 55,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Container(
                          width: 410,
                          height: 47,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.0),
                                child: Icon(Icons.search),
                              ),
                              Expanded(
                                child: TextField(
                                  decoration: const InputDecoration(
                                    hintText: 'Search',
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                CarouselSlider(
                  options: CarouselOptions(
                    height: 276,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 3),
                  ),
                  items: firstProducts.map((product) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          width: 456,
                          margin: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: Column(
                            children: [
                              Image.network(
                                product.image ?? 'assets/placeholder.png',
                                width: 456,
                                height: 216,
                                fit: BoxFit.cover,
                              ),
                              const SizedBox(height: 10),
                              Text(
                                product.title ?? '',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                              Text(
                                '\$${product.price?.toStringAsFixed(2) ?? 'N/A'}',
                                style: const TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: SizedBox(
                    height: 220,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                          snapshot.data != null
                              ? snapshot.data!.length > 3
                                  ? 3
                                  : snapshot.data!.length
                              : 0,
                          (index) => Padding(
                            padding: EdgeInsets.only(right: index == 2 ? 0 : 5),
                            child: SizedBox(
                              width: 312,
                              child: ProductViewShop(
                                snapshot.data![index],
                                onFavoritePressed: () {
                                  Provider.of<Global_provider>(context,
                                          listen: false)
                                      .toggleFavorite(snapshot.data![index]);
                                },
                                onCartPressed: () {
                                  Provider.of<Global_provider>(context,
                                          listen: false)
                                      .addCartItems(snapshot.data![index]);
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Wrap(
                    spacing: 20,
                    runSpacing: 10,
                    children: List.generate(
                      snapshot.data != null ? 5 : 0,
                      (index) {
                        final randomIndex =
                            Random().nextInt(snapshot.data!.length);
                        final randomProduct = snapshot.data![randomIndex];
                        return ProductViewShop(
                          randomProduct,
                          onFavoritePressed: () {
                            Provider.of<Global_provider>(context, listen: false)
                                .toggleFavorite(randomProduct);
                          },
                          onCartPressed: () {
                            Provider.of<Global_provider>(context, listen: false)
                                .addCartItems(randomProduct);
                          },
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          );
        } else {
          return const Center(
            child: SizedBox(
              height: 25,
              width: 25,
              child: CircularProgressIndicator(),
            ),
          );
        }
      }),
    );
  }
}
