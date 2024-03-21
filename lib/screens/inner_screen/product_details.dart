import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:shopapp/providers/cart_provider.dart';
import 'package:shopapp/services/my_app_functions.dart';
import 'package:shopapp/widgets/appname_text.dart';
import 'package:shopapp/widgets/products/heart_button.dart';
import 'package:shopapp/widgets/subtitle_text.dart';
import 'package:shopapp/widgets/title_text.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/providers/products_provider.dart';

class ProductDetailesScreen extends StatefulWidget {
  static const routeName = "/ProductDetailesScreen";
  const ProductDetailesScreen({super.key});

  @override
  State<ProductDetailesScreen> createState() => _ProductDetailesScreenState();
}

class _ProductDetailesScreenState extends State<ProductDetailesScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final productsProvider = Provider.of<ProductsProvider>(context);
    String? productId = ModalRoute.of(context)!.settings.arguments as String?;
    final getCurrentProduct = productsProvider.findByPrdctId(productId!);
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              if (Navigator.canPop(context)) {
                Navigator.pop(context);
              }
            },
            icon: const Icon(Icons.arrow_back_ios_new)),
        title: const AppNameText(fontSize: 25),
      ),
      body: getCurrentProduct == null
          ? const SizedBox.shrink()
          : SingleChildScrollView(
              child: Column(
                children: [
                  FancyShimmerImage(
                    imageUrl: getCurrentProduct.productImage,
                    width: double.infinity,
                    height: size.height * 0.50,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Text(
                                getCurrentProduct.productTitle,
                                softWrap: true,
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w700),
                              ),
                            ),
                            const SizedBox(width: 10),
                            SubTitleTextWidget(
                              label: "₹ ${getCurrentProduct.productPrice}",
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              HeartButtonWidget(
                                bkgrndColor: Colors.blue.shade200,
                                productId: getCurrentProduct.productId,
                              ),
                              const SizedBox(width: 20),
                              Expanded(
                                child: SizedBox(
                                  height: kBottomNavigationBarHeight - 10,
                                  child: ElevatedButton.icon(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.red,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20))),
                                      onPressed: () async {
                                        if (cartProvider.isProductInCart(
                                            productId:
                                                getCurrentProduct.productId)) {
                                          return;
                                        }
                                        try {
                                          await cartProvider.addToCartFierebase(
                                              productId:
                                                  getCurrentProduct.productId,
                                              qty: 1,
                                              context: context);
                                        } catch (e) {
                                          MyAppFunctions
                                              .showErrorOrWarningDialog(
                                                  context: context,
                                                  fct: () {},
                                                  subtitle: e.toString());
                                        }
                                      },
                                      icon: Icon(
                                        cartProvider.isProductInCart(
                                                productId:
                                                    getCurrentProduct.productId)
                                            ? Icons.check
                                            : Icons.add_shopping_cart_outlined,
                                        size: 18,
                                        color: Colors.white,
                                      ),
                                      label: Text(cartProvider.isProductInCart(
                                              productId:
                                                  getCurrentProduct.productId)
                                          ? "In cart"
                                          : "Add to Cart")),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const TitleTextWidget(label: "About This Item"),
                            SubTitleTextWidget(
                                label:
                                    "In ${getCurrentProduct.productCategory}")
                          ],
                        ),
                        const SizedBox(height: 15),
                        SubTitleTextWidget(
                          label: getCurrentProduct.productDescription,
                          fontSize: 14,
                          fontStyle: FontStyle.normal,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
