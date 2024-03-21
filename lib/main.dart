import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/checkout/add_delvry_address.dart';
import 'package:shopapp/consts/theme_data.dart';
import 'package:shopapp/providers/cart_provider.dart';
import 'package:shopapp/providers/check_out_provider.dart';
import 'package:shopapp/providers/order_provider.dart';
import 'package:shopapp/providers/products_provider.dart';
import 'package:shopapp/providers/theme_provider.dart';
import 'package:shopapp/providers/user_provider.dart';
import 'package:shopapp/providers/view_recently_provider.dart';
import 'package:shopapp/providers/wishlist_provider.dart';
import 'package:shopapp/root_screen.dart';
import 'package:shopapp/screens/Auth/forgott_password.dart';
import 'package:shopapp/screens/Auth/login.dart';
import 'package:shopapp/screens/Auth/register.dart';
import 'package:shopapp/screens/inner_screen/orders/order_screen.dart';
import 'package:shopapp/screens/inner_screen/product_details.dart';
import 'package:shopapp/screens/inner_screen/viewes_recntly.dart';
import 'package:shopapp/screens/inner_screen/whishlist_screen.dart';
import 'package:shopapp/screens/search_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<FirebaseApp>(
        future: Firebase.initializeApp(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const MaterialApp(
              debugShowCheckedModeBanner: false,
              home: Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              home: Scaffold(
                body: Center(
                  child: SelectableText(snapshot.error.toString()),
                ),
              ),
            );
          }
          return MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (_) {
                return ThemeProvider();
              }),
              ChangeNotifierProvider(create: (_) {
                return ProductsProvider();
              }),
              ChangeNotifierProvider(create: (_) {
                return CartProvider();
              }),
              ChangeNotifierProvider(create: (_) {
                return WishlistProvider();
              }),
              ChangeNotifierProvider(create: (_) {
                return ViewedProductProvider();
              }),
              ChangeNotifierProvider(create: (_) {
                return UserProvider();
              }),
              ChangeNotifierProvider(create: (_) {
                return OrderProvider();
              }),
              ChangeNotifierProvider(create: (_) {
                return CheckoutProvider();
              }),
            ],
            child: Consumer<ThemeProvider>(
                builder: (context, themeProvider, child) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: Styles.themeData(
                    isDarkTheme: themeProvider.getIsDarkTheme,
                    context: context),
                home: const RootScreen(),
                routes: {
                  RootScreen.routeName: (context) => const RootScreen(),
                  ProductDetailesScreen.routeName: (context) =>
                      const ProductDetailesScreen(),
                  WhishlistScreen.routeName: (context) =>
                      const WhishlistScreen(),
                  ViewedRecentlyScreen.routName: (context) =>
                      const ViewedRecentlyScreen(),
                  LoginScreen.routeName: (context) => const LoginScreen(),
                  RegisterScreen.routeName: (context) => const RegisterScreen(),
                  OrderScreenFree.routeName: (context) =>
                      const OrderScreenFree(),
                  ForgottPassordScreen.routeName: (context) =>
                      const ForgottPassordScreen(),
                  SearchScreen.routeName: (context) => const SearchScreen(),
                  AddDeliveryAddress.routeName: (context) =>
                      const AddDeliveryAddress(),
                },
              );
            }),
          );
        });
  }
}
