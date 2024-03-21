import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/checkout/delivery_address_model.dart';
import 'package:shopapp/checkout/single_itemDLVRY.dart';
import 'package:shopapp/providers/cart_provider.dart';
import 'package:shopapp/providers/products_provider.dart';
import 'package:shopapp/providers/user_provider.dart';
import 'package:shopapp/screens/order_done.dart';
import 'package:shopapp/services/my_app_functions.dart';
import 'package:shopapp/widgets/subtitle_text.dart';
import 'package:uuid/uuid.dart';

class PaymentSummary extends StatefulWidget {
  final DeliveryAddressModel deliveryAddressList;
  PaymentSummary({required this.deliveryAddressList});

  @override
  State<PaymentSummary> createState() => _PaymentSummaryState();
}

class _PaymentSummaryState extends State<PaymentSummary> {
  String _paymentOption = '';

  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<ProductsProvider>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    CartProvider orderProvider = Provider.of<CartProvider>(context);
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    orderProvider.getCartItems;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Payment Summary"),
      ),
      bottomNavigationBar: ListTile(
        title: const Text("Total Amount"),
        subtitle: SubTitleTextWidget(
          label:
              "₹ ${cartProvider.getAllTotal(productsProvider: productsProvider).toStringAsFixed(2)}",
          color: Colors.blue,
        ),
        trailing: SizedBox(
          width: 160,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              onPressed: () {
                placeOrderAdvanced(
                    cartProvider: cartProvider,
                    productsProvider: productsProvider,
                    userProvider: userProvider);
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) {
                    return const OrderDoneSplash();
                  },
                ));
              },
              child: const Text(
                "Place Order",
                style: TextStyle(color: Colors.black),
              )),
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: ListView.builder(
            itemCount: 1,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  SingleDeliveryItem(
                    name: widget.deliveryAddressList.title,
                    addressMain: widget.deliveryAddressList.addressMain,
                    locality: widget.deliveryAddressList.locality,
                    city: widget.deliveryAddressList.city,
                    pincode: widget.deliveryAddressList.pincode,
                    state: widget.deliveryAddressList.state,
                    mobileNumber: widget.deliveryAddressList.mobileNumber,
                    alternateNumber: widget.deliveryAddressList.alternateNumber,
                  ),
                  const Divider(),
                  // ExpansionTile(
                  //   title: Text("order Item 10"),
                  //   children: [
                  //     OrderItem(),
                  //     OrderItem(),
                  //     OrderItem(),
                  //     OrderItem(),
                  //     OrderItem(),
                  //     OrderItem(),
                  //   ],
                  // ),
                  const Divider(),
                  ListTile(
                    minVerticalPadding: 5,
                    leading: const Text(
                      "Sub Total",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    trailing: Text(
                      "₹ ${cartProvider.getTotal(productsProvider: productsProvider).toStringAsFixed(2)}",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  const ListTile(
                    minVerticalPadding: 5,
                    leading: Text(
                      "Shiping charges",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    trailing: Text(
                      "RS 99.0",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  const ListTile(
                    minVerticalPadding: 5,
                    leading: Text(
                      "Discount charges",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    trailing: Text(
                      "RS 000",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Divider(),
                  const ListTile(
                    title: Text("Payment Options"),
                  ),
                  RadioListTile(
                    title: const Text('Cash on Delivery'),
                    value: 'Cash on Delivery',
                    groupValue: _paymentOption,
                    onChanged: (value) {
                      setState(() {
                        _paymentOption = value as String;
                      });
                    },
                  ),
                  RadioListTile(
                    title: const Text('Online Payment'),
                    value: 'Online Payment',
                    groupValue: _paymentOption,
                    onChanged: (value) {
                      setState(() {
                        _paymentOption = value as String;
                      });
                    },
                  ),
                ],
              );
            },
          )),
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
      setState(() {});
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
          "productTitle": getCurrentProduct!.productTitle,
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
      setState(() {});
    }
  }
}
