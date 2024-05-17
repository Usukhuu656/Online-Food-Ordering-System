import 'package:flutter/material.dart';
import 'package:shop_app/models/product_model.dart';
import 'package:shop_app/screens/product_detail.dart';

class ProductViewShop extends StatefulWidget {
  final ProductModel product;
  final VoidCallback onFavoritePressed;
  final VoidCallback onCartPressed;

  const ProductViewShop(this.product,
      {required this.onFavoritePressed, required this.onCartPressed, Key? key})
      : super(key: key);

  @override
  _ProductViewShopState createState() => _ProductViewShopState();
}

class _ProductViewShopState extends State<ProductViewShop> {
  bool isFavorite = false;

  void onTap(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => Product_detail(widget.product)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(context),
      child: Card(
        elevation: 4.0,
        margin: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 143.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(widget.product.image!),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          widget.product.title!,
                          style: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          '\$${widget.product.price!.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 14.0,
                            color: Color.fromARGB(255, 185, 125, 42),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.favorite),
                  onPressed: widget.onFavoritePressed,
                ),
                IconButton(
                  icon: Icon(Icons.shopping_cart),
                  onPressed: widget.onCartPressed,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
