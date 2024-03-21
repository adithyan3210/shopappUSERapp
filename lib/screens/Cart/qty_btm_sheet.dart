import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/models/cart_model.dart';
import 'package:shopapp/providers/cart_provider.dart';
import 'package:shopapp/widgets/subtitle_text.dart';

class QtyBottomSheetWidget extends StatelessWidget {
  const QtyBottomSheetWidget({super.key, required this.cartModel});
  final CartModel cartModel;

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    return Column(
      children: [
        const SizedBox(height: 20),
        Container(
          height: 6,
          width: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12), color: Colors.grey),
        ),
        const SizedBox(height: 20),
        Expanded(
          child: ListView.builder(
            itemCount: 25,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  cartProvider.updateQty(
                      productId: cartModel.productId, qty: index + 1);
                  Navigator.pop(context); 
                },
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: SubTitleTextWidget(label: "${index + 1}"),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
