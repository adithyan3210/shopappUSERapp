import 'package:flutter/material.dart';
import 'package:shopapp/models/viewRct_model.dart';
import 'package:uuid/uuid.dart';

class ViewedProductProvider with ChangeNotifier {
  //create map for RecentitemsList
  final Map<String, ViewedProductModel> _viewedtItems = {};
  Map<String, ViewedProductModel> get getViewdItems {
    return _viewedtItems;
  }

//Function for viewedItems

  void addViewdProduct({required String productId}) {
    _viewedtItems.putIfAbsent(
        productId,
        () => ViewedProductModel(
            whishlistId: const Uuid().v4(), productId: productId));

    notifyListeners();
  }
}
