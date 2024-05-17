import 'package:flutter/material.dart';
import 'package:shop_app/models/product_model.dart';
import 'package:shop_app/models/users.dart';

class Global_provider extends ChangeNotifier {
  List<ProductModel> products = [];
  List<ProductModel> cartItems = [];
  List<ProductModel> favorites = [];
  List<UserModel> users = [];
  List<String> comments = [];
  String? loggedInUsername;
  double total = 0;
  int currentIdx = 0;
  void setUsers(List<UserModel> data) {
    users = data;
    notifyListeners();
  }

  void setProducts(List<ProductModel> data) {
    products = data;
    notifyListeners();
  }

  void addCartItems(ProductModel item) {
    int existingIndex = cartItems.indexWhere((cartItem) => cartItem == item);
    if (existingIndex != -1) {
      cartItems[existingIndex].count += 1;
    } else {
      item.count = 1;
      cartItems.add(item);
    }
    notifyListeners();
  }

  void clearCartItems() {
    cartItems.clear();
    notifyListeners();
  }

  void getTotal(double total1) {
    total = total1;
    notifyListeners();
  }

  double setTotal() {
    return total;
  }

  void changeCurrentIdx(int idx) {
    currentIdx = idx;
    notifyListeners();
  }

  void toggleFavorite(ProductModel product) {
    if (favorites.contains(product)) {
      favorites.remove(product);
    } else {
      favorites.add(product);
    }
    notifyListeners();
  }

  void removeFromCart(ProductModel product) {
    cartItems.remove(product);
    notifyListeners();
  }

  void removeFromFavorites(ProductModel product) {
    favorites.remove(product);
    notifyListeners();
  }

  void updateCartItemQuantity(ProductModel product, int newQuantity) {
    if (newQuantity < 0) {
      return;
    }
    int index = cartItems.indexWhere((item) => item == product);

    if (index != -1) {
      cartItems[index].count = newQuantity;
      notifyListeners();
    }
  }

  void login(String username) {
    loggedInUsername = username;
    notifyListeners();
  }

  String? getUsername() {
    return loggedInUsername;
  }

  void addComment(ProductModel product, String comment, String? username) {
    if (username != null) {
      final formattedComment = '$username: $comment';
      product.comments.add(formattedComment);
      comments.add(formattedComment);
      notifyListeners();
    }
  }
}
