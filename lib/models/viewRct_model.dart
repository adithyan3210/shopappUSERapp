import 'package:flutter/material.dart';

class ViewedProductModel with ChangeNotifier {
  final String whishlistId;
  final String productId;

  ViewedProductModel({
    required this.whishlistId,
    required this.productId,
  });
}
