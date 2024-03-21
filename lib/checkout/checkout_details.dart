import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/checkout/add_delvry_address.dart';
import 'package:shopapp/checkout/delivery_address_model.dart';
import 'package:shopapp/checkout/payment_summary.dart';
import 'package:shopapp/checkout/single_itemDLVRY.dart';
import 'package:shopapp/providers/check_out_provider.dart';
import 'package:shopapp/widgets/subtitle_text.dart';
import 'package:shopapp/widgets/title_text.dart';

class CheckOutDetails extends StatefulWidget {
  CheckOutDetails({super.key});

  @override
  State<CheckOutDetails> createState() => _CheckOutDetailsState();
}

class _CheckOutDetailsState extends State<CheckOutDetails> {
  bool isAddress = false;
  late DeliveryAddressModel value;

  @override
  Widget build(BuildContext context) {
    CheckoutProvider deliveryAddressProvider = Provider.of(context);
    deliveryAddressProvider.fetchDeliveryAddress();

    return Scaffold(
      appBar: AppBar(
        title: const TitleTextWidget(label: "Delivery Details"),
      ),
      bottomNavigationBar: Container(
        height: 40,
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: ElevatedButton(
          child: deliveryAddressProvider.fetchDeliveryAddressList.isEmpty
              ? const Text("Add new address")
              : const Text("Payment Summary"),
          onPressed: () {
            deliveryAddressProvider.fetchDeliveryAddressList.isEmpty
                ? Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return const AddDeliveryAddress();
                    },
                  ))
                : Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return PaymentSummary(
                        deliveryAddressList: deliveryAddressProvider
                            .fetchDeliveryAddressList.first,
                      );
                    },
                  ));
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return const AddDeliveryAddress();
                },
              ));
            },
            child: const Padding(
              padding: EdgeInsets.all(5),
              child: SubTitleTextWidget(label: "+ ADD NEW ADDRESS"),
            ),
          ),
          const ListTile(
            title: Text("DEFAULT ADDRESS"),
            leading: Icon(Icons.location_on_outlined),
          ),
          const Divider(height: 1),
          deliveryAddressProvider.fetchDeliveryAddressList.isEmpty
              ? const Center(
                  child: Text("No Address"),
                )
              : Column(
                  children: deliveryAddressProvider.fetchDeliveryAddressList
                      .map<Widget>((address) {
                    setState(() {
                      value = address;
                    });
                    return SingleDeliveryItem(
                      name: address.title,
                      mobileNumber: address.mobileNumber,
                      alternateNumber: address.alternateNumber,
                      locality: address.locality,
                      pincode: address.pincode,
                      state: address.state,
                      addressMain: address.addressMain,
                      city: address.city,
                      addressType: "Home",
                    );
                  }).toList(),
                ),
          const Divider(thickness: 0.2),
          SizedBox(
            height: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {},
                  child: const SubTitleTextWidget(label: "EDIT", fontSize: 15),
                ),
                const Divider(thickness: 0.2),
                TextButton(
                  onPressed: () {},
                  child:
                      const SubTitleTextWidget(label: "REMOVE", fontSize: 15),
                )
              ],
            ),
          ),
          const Divider(thickness: 0.2),
        ],
      ),
    );
  }
}
