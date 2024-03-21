import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/models/product_model.dart';
import 'package:shopapp/providers/cart_provider.dart';
import 'package:shopapp/providers/view_recently_provider.dart';
import 'package:shopapp/screens/inner_screen/product_details.dart';
import 'package:shopapp/services/my_app_functions.dart';
import 'package:shopapp/widgets/products/heart_button.dart';
import 'package:shopapp/widgets/subtitle_text.dart';

class LatestArrivalProductsWidget extends StatelessWidget {
  const LatestArrivalProductsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final productsModel = Provider.of<ProductModel>(context);
    final cartProvider = Provider.of<CartProvider>(context);

    final viewedProdProvider = Provider.of<ViewedProductProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: GestureDetector(
        onTap: () async {
          viewedProdProvider.addViewdProduct(
              productId: productsModel.productId);
          await Navigator.pushNamed(context, ProductDetailesScreen.routeName,
              arguments: productsModel.productId);
        },
        child: SizedBox(
          width: size.width * 0.42,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: FancyShimmerImage(
                    imageUrl: productsModel.productImage,
                    height: size.width * 0.20,
                    width: size.width * 0.3,
                  ),
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Flexible(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      productsModel.productTitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    FittedBox(
                      child: Row(
                        children: [
                          HeartButtonWidget(
                            productId: productsModel.productId,
                          ),
                          IconButton(
                            onPressed: () async {
                              if (cartProvider.isProductInCart(
                                  productId: productsModel.productId)) {
                                return;
                              }
                              try {
                                await cartProvider.addToCartFierebase(
                                    productId: productsModel.productId,
                                    qty: 1,
                                    context: context);
                              } catch (e) {
                                MyAppFunctions.showErrorOrWarningDialog(
                                    context: context,
                                    fct: () {},
                                    subtitle: e.toString());
                              }
                            },
                            icon: Icon(
                              cartProvider.isProductInCart(
                                productId: productsModel.productId,
                              )
                                  ? Icons.check
                                  : Icons.add_shopping_cart_outlined,
                            ),
                          ),
                        ],
                      ),
                    ),
                    FittedBox(
                      child: SubTitleTextWidget(
                        label: "₹ ${productsModel.productPrice}",
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OldestArrivalProductsWidget extends StatelessWidget {
  const OldestArrivalProductsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final productsModel = Provider.of<ProductModel>(context);
    final cartProvider = Provider.of<CartProvider>(context);

    final viewedProdProvider = Provider.of<ViewedProductProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: GestureDetector(
        onTap: () async {
          viewedProdProvider.addViewdProduct(
              productId: productsModel.productId);
          await Navigator.pushNamed(context, ProductDetailesScreen.routeName,
              arguments: productsModel.productId);
        },
        child: SizedBox(
          width: size.width * 0.42,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: FancyShimmerImage(
                    imageUrl: productsModel.productImage,
                    height: size.width * 0.20,
                    width: size.width * 0.3,
                  ),
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Flexible(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      productsModel.productTitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    FittedBox(
                      child: Row(
                        children: [
                          HeartButtonWidget(
                            productId: productsModel.productId,
                          ),
                          IconButton(
                            onPressed: () async {
                              if (cartProvider.isProductInCart(
                                  productId: productsModel.productId)) {
                                return;
                              }
                              try {
                                await cartProvider.addToCartFierebase(
                                    productId: productsModel.productId,
                                    qty: 1,
                                    context: context);
                              } catch (e) {
                                MyAppFunctions.showErrorOrWarningDialog(
                                    context: context,
                                    fct: () {},
                                    subtitle: e.toString());
                              }
                            },
                            icon: Icon(
                              cartProvider.isProductInCart(
                                productId: productsModel.productId,
                              )
                                  ? Icons.check
                                  : Icons.add_shopping_cart_outlined,
                            ),
                          ),
                        ],
                      ),
                    ),
                    FittedBox(
                      child: SubTitleTextWidget(
                        label: "₹ ${productsModel.productPrice}",
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
