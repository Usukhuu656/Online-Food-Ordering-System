import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/provider/globalProvider.dart';

class ShoppingCartPage extends StatelessWidget {
  ShoppingCartPage({Key? key});

  int buyAll(BuildContext context, double total) {
    showToast(context, "Purchase successful");
    return 1;
  }

  void showToast(BuildContext context, String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black,
      textColor: Colors.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Global_provider>(
      builder: (context, provider, child) {
        double total = provider.cartItems.fold(
          0,
          (sum, item) => sum + (item.price! * item.count),
        );
        provider.getTotal(total);
        return Scaffold(
          appBar: AppBar(
            title: Text('Shopping Cart'),
          ),
          body: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: provider.cartItems.length,
                  itemBuilder: (context, index) {
                    final item = provider.cartItems[index];
                    return Dismissible(
                      key: Key(item.id.toString()),
                      direction: DismissDirection.endToStart,
                      onDismissed: (direction) {
                        provider.removeFromCart(item);
                        showToast(context, "${item.title} removed from cart");
                      },
                      background: Container(
                        color: Colors.red,
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                      ),
                      child: Card(
                        margin: EdgeInsets.all(8.0),
                        child: ListTile(
                          leading: Container(
                            width: 163,
                            height: 94,
                            child: Image.network(
                              item.image!,
                              fit: BoxFit.cover,
                            ),
                          ),
                          title: Text(item.title!),
                          subtitle: Text('Price: \$${item.price!}'),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(Icons.remove),
                                onPressed: () {
                                  provider.updateCartItemQuantity(
                                    item,
                                    item.count - 1,
                                  );
                                },
                              ),
                              Text('${item.count}'),
                              IconButton(
                                icon: Icon(Icons.add),
                                onPressed: () {
                                  provider.updateCartItemQuantity(
                                    item,
                                    item.count + 1,
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Total: \$${total.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                color: Color(0xFFFFF9C4),
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Icon(Icons.shopping_cart, color: Colors.red, size: 30),
                    SizedBox(width: 10),
                    Text(
                      'Items: ${provider.cartItems.length}',
                      style: TextStyle(fontSize: 18),
                    ),
                    Spacer(),
                    ElevatedButton(
                      onPressed: () {
                        int result = buyAll(context, total);
                        if (result == 1) {
                          provider.clearCartItems();
                        }
                      },
                      child: Text('Payment'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
