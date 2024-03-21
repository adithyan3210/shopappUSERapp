import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/models/cart_model.dart';
import 'package:shopapp/providers/cart_provider.dart';
import 'package:shopapp/providers/products_provider.dart';
import 'package:shopapp/screens/Cart/qty_btm_sheet.dart';
import 'package:shopapp/widgets/products/heart_button.dart';
import 'package:shopapp/widgets/subtitle_text.dart';
import 'package:shopapp/widgets/title_text.dart';

class CartWidget extends StatelessWidget {
  const CartWidget({Key? key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final cartModel = Provider.of<CartModel>(context);
    final productsProvider = Provider.of<ProductsProvider>(context);
    final getCurrentProduct =
        productsProvider.findByPrdctId(cartModel.productId);
    final cartProvider = Provider.of<CartProvider>(context);

    return Builder(builder: (context) {
      return Column(
        children: [
          getCurrentProduct == null
              ? const SizedBox.shrink()
              : FittedBox(
                  child: IntrinsicWidth(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: FancyShimmerImage(
                              imageUrl: getCurrentProduct.productImage,
                              height: size.height * 0.2,
                              width: size.height * 0.2,
                            ),
                          ),
                          const SizedBox(width: 10),
                          IntrinsicWidth(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      width: size.width * 0.6,
                                      child: TitleTextWidget(
                                          maxLines: 2,
                                          label:
                                              getCurrentProduct.productTitle),
                                    ),
                                    Column(
                                      children: [
                                        IconButton(
                                          onPressed: () async {
                                            cartProvider
                                                .removeCartItemFromFirebase(
                                              cartId: cartModel.cartId,
                                              productId:
                                                  getCurrentProduct.productId,
                                              qty: cartModel.quantity,
                                            );
                                          },
                                          icon: const Icon(Icons.clear),
                                          color: Colors.red,
                                        ),
                                        HeartButtonWidget(
                                          productId:
                                              getCurrentProduct.productId,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    SubTitleTextWidget(
                                      label:
                                          "₹ ${getCurrentProduct.productPrice}",
                                      color: Colors.blue,
                                    ),
                                    const Spacer(),
                                    OutlinedButton.icon(
                                      onPressed: () async {
                                        await showModalBottomSheet(
                                          backgroundColor: Theme.of(context)
                                              .scaffoldBackgroundColor,
                                          shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(30),
                                              topRight: Radius.circular(30),
                                            ),
                                          ),
                                          context: context,
                                          builder: (context) {
                                            return QtyBottomSheetWidget(
                                              cartModel: cartModel,
                                            );
                                          },
                                        );
                                      },
                                      icon: const Icon(IconlyLight.arrowDown2),
                                      label: Text("Qty:${cartModel.quantity}"),
                                      style: OutlinedButton.styleFrom(
                                        side: const BorderSide(width: 1),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
          const Divider(),
        ],
      );
    });
  }
}
