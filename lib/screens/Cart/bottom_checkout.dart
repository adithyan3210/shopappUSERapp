import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/checkout/checkout_details.dart';
import 'package:shopapp/providers/cart_provider.dart';
import 'package:shopapp/providers/products_provider.dart';
import 'package:shopapp/widgets/subtitle_text.dart';
import 'package:shopapp/widgets/title_text.dart';

class CartBottomSheeetWidget extends StatelessWidget {
  const CartBottomSheeetWidget({super.key, required this.function});
  final Function function;

  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<ProductsProvider>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        border: const Border(
          top: BorderSide(width: 1),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: kBottomNavigationBarHeight + 10,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TitleTextWidget(
                      label:
                          "Items (${cartProvider.getCartItems.length} Products)",
                      fontSize: 17,
                    ),
                    SubTitleTextWidget(
                      label:
                          "₹ ${cartProvider.getTotal(productsProvider: productsProvider).toStringAsFixed(2)}",
                      color: Colors.blue,
                      fontStyle: FontStyle.normal,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    )
                  ],
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 114, 183, 239)),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return CheckOutDetails();
                    },
                  ));
                },
                child: const Text("Place Order",style: TextStyle(color: Colors.black),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
