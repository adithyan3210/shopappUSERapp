import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shopapp/models/cart_model.dart';
import 'package:shopapp/providers/products_provider.dart';
import 'package:shopapp/services/my_app_functions.dart';
import 'package:uuid/uuid.dart';

class CartProvider with ChangeNotifier {
  //create mao for cartList
  final Map<String, CartModel> _cartItems = {};
  Map<String, CartModel> get getCartItems {
    return _cartItems;
  }

  final usersDb = FirebaseFirestore.instance.collection("users");
  final _auth = FirebaseAuth.instance;
  //Cart FireBase
  Future<void> addToCartFierebase(
      {required String productId,
      required int qty,
      required BuildContext context}) async {
    final User? user = _auth.currentUser;
    if (user == null) {
      MyAppFunctions.showErrorOrWarningDialog(
        context: context,
        fct: () {},
        subtitle: "Please login fist",
      );
      return;
    }

    final uid = user.uid;
    final cartId = const Uuid().v4();
    try {
      await usersDb.doc(uid).update({
        'userCart': FieldValue.arrayUnion([
          {
            'cartId': cartId,
            'productId': productId,
            'quantity': qty,
          }
        ])
      });
      await fetchCart();
      Fluttertoast.showToast(
        msg: "Item has been aded",
        backgroundColor: Colors.white,
        webShowClose: false,
      );
    } catch (e) {
      rethrow;
    }
  }

  //fetch read display---cart items
  Future<void> fetchCart() async {
    final User? user = _auth.currentUser;
    if (user == null) {
      _cartItems.clear();
      return;
    }
    try {
      final userDoc = await usersDb.doc(user.uid).get();
      final data = userDoc.data();
      if (data == null || !data.containsKey('userCart')) {
        return;
      }
      final length = userDoc.get("userCart").length;
      for (int index = 0; index < length; index++) {
        _cartItems.putIfAbsent(
          userDoc.get("userCart")[index]['productId'],
          () => CartModel(
            cartId: userDoc.get("userCart")[index]['cartId'],
            productId: userDoc.get("userCart")[index]['productId'],
            quantity: userDoc.get("userCart")[index]['quantity'],
          ),
        );
      }
    } catch (e) {
      rethrow;
    }
    notifyListeners();
  }

  //clear cart from firebase and cart
  Future<void> removeCartItemFromFirebase({
    required String cartId,
    required String productId,
    required int qty,
  }) async {
    final User? user = _auth.currentUser;
    try {
      await usersDb.doc(user!.uid).update({
        'userCart': FieldValue.arrayRemove([
          {
            'cartId': cartId,
            'productId': productId,
            'quantity': qty,
          }
        ])
      });
      _cartItems.remove(productId);
      Fluttertoast.showToast(
        msg: "Item has been removed",
        webShowClose: false,
      );
    } catch (e) {
      rethrow;
    }
  }

  //////////////clear cart from firebase and cart
  Future<void> clearCartItemFromFirebase() async {
    final User? user = _auth.currentUser;
    try {
      await usersDb.doc(user!.uid).update(
        {
          'userCart': [],
        },
      );
      //   await fetchCart();
      _cartItems.clear();
      Fluttertoast.showToast(msg: "Cart has been cleared");
    } catch (e) {
      rethrow;
    }
  }

  //////////////clear cart from firebase and cart
  Future<void> clearCartItemFromFirebaseOrderTime() async {
    final User? user = _auth.currentUser;
    try {
      await usersDb.doc(user!.uid).update(
        {
          'userCart': [],
        },
      );
      //   await fetchCart();
      _cartItems.clear();
    } catch (e) {
      rethrow;
    }
  }

//Function for carting
  void addProductToCart({required String productId}) {
    _cartItems.putIfAbsent(
      productId,
      () => CartModel(
          cartId: const Uuid().v4(), productId: productId, quantity: 1),
    );
    notifyListeners();
  }

  bool isProductInCart({required String productId}) {
    return _cartItems.containsKey(productId);
  }

//Calculating total
  double getTotal({required ProductsProvider productsProvider}) {
    double total = 0.0;
    _cartItems.forEach((key, value) {
      final getCurrentProduct = productsProvider.findByPrdctId(value.productId);
      if (getCurrentProduct == null) {
        total += 0;
      } else {
        total += double.parse(getCurrentProduct.productPrice) * value.quantity;
      }
    });
    return total;
  }

  double getAllTotal(
      {required ProductsProvider productsProvider,
      double shippingCharge = 99.0}) {
    double allTotal =
        getTotal(productsProvider: productsProvider) + shippingCharge;
    return allTotal;
  }

  //QTY Get
  int getQty() {
    int total = 0;
    _cartItems.forEach((key, value) {
      total += value.quantity;
    });
    return total;
  }

  //update QTY
  void updateQty({required String productId, required int qty}) {
    _cartItems.update(
      productId,
      (cartItem) => CartModel(
        cartId: cartItem.cartId,
        productId: productId,
        quantity: qty,
      ),
    );
    notifyListeners();
  }

  void clearLocalCart() {
    _cartItems.clear();
    notifyListeners();
  }

  void removeOneItem({required String productId}) {
    _cartItems.remove(productId);
    notifyListeners();
  }
}
