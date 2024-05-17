import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/firebase/guest_book_message.dart';
import 'package:shop_app/models/product_model.dart';
import 'package:shop_app/provider/globalProvider.dart';
import 'package:shop_app/firebase/guest_book.dart';
import 'package:shop_app/firebase/app_state.dart';

class Product_detail extends StatelessWidget {
  final ProductModel product;

  const Product_detail(this.product, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Global_provider>(builder: (context, provider, child) {
      ApplicationState appState = Provider.of<ApplicationState>(context);
      List<GuestBookMessage> filterMessage = appState.guestBookMessages
          .where((message) => message.productName == product.title)
          .toList();

      return Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Text(
                  product.category ?? 'Unknown Category',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                height: 200,
                child: product.image != null
                    ? Image.network(
                        product.image!,
                        fit: BoxFit.cover,
                      )
                    : Placeholder(),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      product.title ?? 'Unknown Product',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.favorite),
                      onPressed: () {
                        provider.toggleFavorite(product);
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.description ?? 'No description available',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 5),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.bottomLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'PRICE: \$${product.price ?? 0}',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 16, 0),
                      child: SizedBox(
                        width: 80,
                        height: 60,
                        child: FloatingActionButton(
                          onPressed: () {
                            provider.addCartItems(product);
                          },
                          child: Icon(Icons.shopping_cart),
                          backgroundColor: Color(0xFFFDD017),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Card(
                margin: EdgeInsets.fromLTRB(15, 0, 15, 10),
                child: SizedBox(
                  height: 140,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Comments:',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 6),
                          GuestBook(
                            addMessage: (message) {
                              if (appState.loggedIn) {
                                appState.addMessageToGuestBook(
                                  message,
                                  product.title ?? 'Unknown Product',
                                );
                              } else {}
                            },
                            messages: filterMessage,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
