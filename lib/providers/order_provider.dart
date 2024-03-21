import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopapp/models/orders_model.dart';

class OrderProvider with ChangeNotifier {
  final List<OrderModelAdvanced> orders = [];
  List<OrderModelAdvanced> get getOrders => orders;

  Future<List<OrderModelAdvanced>> fetchOrders() async {
    final auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    var uid = user!.uid;
    try {
      await FirebaseFirestore.instance
          .collection("ordersAdvanced")
          .where('userId', isEqualTo: uid)
          .orderBy('orderDate', descending: false)
          .get()
          .then((orderSnapShot) {
        orders.clear();
        for (var element in orderSnapShot.docs) {
          orders.insert(
            0,
            OrderModelAdvanced(
              orderId: element.get('orderId'),
              userId: element.get('userId'),
              productId: element.get('productId'),
              productTitle: element.get('productTitle').toString(),
              userName: element.get('userName'),
              price: element.get('price').toString(),
              imageUrl: element.get('imageUrl'),
              quantity: element.get('quantity').toString(),
              orderDate: element.get('orderDate'),
            ),
          );
        }
      });
      return orders;
    } catch (e) {
      rethrow;
    }
  }
}
