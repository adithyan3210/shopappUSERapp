import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/providers/cart_provider.dart';
import 'package:shopapp/providers/products_provider.dart';
import 'package:shopapp/providers/view_recently_provider.dart';
import 'package:shopapp/screens/inner_screen/product_details.dart';
import 'package:shopapp/services/my_app_functions.dart';
import 'package:shopapp/widgets/products/heart_button.dart';
import 'package:shopapp/widgets/subtitle_text.dart';
import 'package:shopapp/widgets/title_text.dart';

class ProductWidget extends StatefulWidget {
  const ProductWidget({
    super.key,
    required this.productId,
  });
  final String productId;

  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<ProductsProvider>(context);
    final getCurrentProduct = productsProvider.findByPrdctId(widget.productId);
    final cartProvider = Provider.of<CartProvider>(context);
    final viewedProductProvider = Provider.of<ViewedProductProvider>(context);
    Size size = MediaQuery.of(context).size;
    return getCurrentProduct == null
        ? const SizedBox.shrink()
        : Padding(
            padding: const EdgeInsets.all(5.0),
            child: GestureDetector(
              onTap: () async {
                viewedProductProvider.addViewdProduct(
                    productId: getCurrentProduct.productId);
                await Navigator.pushNamed(
                    context, ProductDetailesScreen.routeName,
                    arguments: getCurrentProduct.productId);
              },
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: FancyShimmerImage(
                      imageUrl: getCurrentProduct.productImage,
                      width: double.infinity,
                      height: size.height * 0.22,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Row(
                      children: [
                        Flexible(
                          flex: 4,
                          child: TitleTextWidget(
                            label: getCurrentProduct.productTitle,
                            fontSize: 15,
                            maxLines: 2,
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: HeartButtonWidget(
                            productId: getCurrentProduct.productId,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          flex: 1,
                          child: SubTitleTextWidget(
                            label: "₹ ${getCurrentProduct.productPrice}",
                            color: Colors.blue,
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                        ),
                        Flexible(
                          child: Material(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.lightBlue,
                            child: InkWell(
                              onTap: () async {
                                if (cartProvider.isProductInCart(
                                    productId: getCurrentProduct.productId)) {
                                  return;
                                }
                                try {
                                  await cartProvider.addToCartFierebase(
                                      productId: getCurrentProduct.productId,
                                      qty: 1,
                                      context: context);
                                } catch (e) {
                                  MyAppFunctions.showErrorOrWarningDialog(
                                      context: context,
                                      fct: () {},
                                      subtitle: e.toString());
                                }
                              },
                              splashColor: Colors.red,
                              borderRadius: BorderRadius.circular(12),
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: Icon(
                                  cartProvider.isProductInCart(
                                          productId:
                                              getCurrentProduct.productId)
                                      ? Icons.check
                                      : Icons.add_shopping_cart_outlined,
                                  size: 18,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
