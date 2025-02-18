import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OrderModelAdvanced with ChangeNotifier {
  final String orderId;
  final String userId;
  final String productId;
  final String productTitle;
  final String userName;
  final String price;
  final String imageUrl;
  final String quantity;
  final Timestamp orderDate;

  OrderModelAdvanced({
    required this.orderId,
    required this.userId,
    required this.productId,
    required this.productTitle,
    required this.userName,
    required this.price,
    required this.imageUrl,
    required this.quantity,
    required this.orderDate,
  });
}
