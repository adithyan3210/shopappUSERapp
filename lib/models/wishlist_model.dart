import 'package:flutter/material.dart';

class WhishlistModel with ChangeNotifier {
  final String whishlistId;
  final String productId;

  WhishlistModel({
    required this.whishlistId,
    required this.productId,
  });
}
