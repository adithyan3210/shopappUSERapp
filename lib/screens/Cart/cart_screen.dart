import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/providers/cart_provider.dart';
import 'package:shopapp/providers/products_provider.dart';
import 'package:shopapp/providers/user_provider.dart';
import 'package:shopapp/screens/Cart/bottom_checkout.dart';
import 'package:shopapp/screens/Cart/cart_widget.dart';
import 'package:shopapp/screens/loading_manager.dart';
import 'package:shopapp/services/asset_manager.dart';
import 'package:shopapp/services/my_app_functions.dart';
import 'package:shopapp/widgets/empty_cart.dart';
import 'package:shopapp/widgets/title_text.dart';
import 'package:uuid/uuid.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final productsProvider =
        Provider.of<ProductsProvider>(context, listen: false);
    final cartProvider = Provider.of<CartProvider>(context);
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    return cartProvider.getCartItems.isEmpty
        ? Scaffold(
            body: EmptyBagWidget(
              imagePath: AssetsManager.shoppingBasket,
              title: "Your Cart Is Empty",
              subTitle:
                  "look Like Your Cart Is Empty Add Something And Make me Happy",
              buttonText: "Shop Now",
            ),
          )
        : Scaffold(
            bottomSheet: CartBottomSheeetWidget(function: () async {
              await placeOrderAdvanced(
                cartProvider: cartProvider,
                productsProvider: productsProvider,
                userProvider: userProvider,
              );
            }),
            appBar: AppBar(
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(AssetsManager.logoImage),
              ),
              title: TitleTextWidget(
                  label: "Cart(${cartProvider.getCartItems.length})"),
              actions: [
                IconButton(
                  onPressed: () {
                    MyAppFunctions.showErrorOrWarningDialog(
                      isError: false,
                      context: context,
                      subtitle: "Clear All?",
                      fct: () {
                        cartProvider.clearCartItemFromFirebase();
                        cartProvider.clearLocalCart();
                      },
                    );
                  },
                  icon: const Icon(Icons.delete_forever_rounded),
                )
              ],
            ),
            body: Loadingmanager(
              isLoading: _isLoading,
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: cartProvider.getCartItems.length,
                      itemBuilder: (context, index) {
                        return ChangeNotifierProvider.value(
                            value: cartProvider.getCartItems.values
                                .toList()[index],
                            child: const CartWidget(),
                            
                            );
                      },
                    ),
                  ),
                  const SizedBox(height: kBottomNavigationBarHeight + 30)
                ],
              ),
              
            ),
          );
  }

//orderrrr
  Future<void> placeOrderAdvanced({
    required CartProvider cartProvider,
    required ProductsProvider productsProvider,
    required UserProvider userProvider,
  }) async {
    final auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    if (user == null) {
      return;
    }
    final uid = user.uid;
    try {
      setState(() {
        _isLoading = true;
      });
      cartProvider.getCartItems.forEach((key, value) async {
        final getCurrentProduct =
            productsProvider.findByPrdctId(value.productId);
        final orderId = const Uuid().v4();
        await FirebaseFirestore.instance
            .collection("ordersAdvanced")
            .doc(orderId)
            .set({
          'orderId': orderId,
          'userId': uid,
          'productId': value.productId,
          'productTitle': getCurrentProduct!.productTitle,
          'price':
              double.parse(getCurrentProduct.productPrice) * value.quantity,
          'totalPrice':
              cartProvider.getTotal(productsProvider: productsProvider),
          'quantity': value.quantity,
          'imageUrl': getCurrentProduct.productImage,
          'userName': userProvider.getUserModel!.userName,
          'orderDate': Timestamp.now(),
        });
      });
      await cartProvider.clearCartItemFromFirebase();
      cartProvider.clearLocalCart();
    } catch (e) {
      await MyAppFunctions.showErrorOrWarningDialog(
        context: context,
        subtitle: e.toString(),
        fct: () {},
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
}
