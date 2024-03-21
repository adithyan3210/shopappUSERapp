import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/checkout/address_textfield.dart';
import 'package:shopapp/providers/check_out_provider.dart';
import 'package:shopapp/widgets/title_text.dart';

class AddDeliveryAddress extends StatefulWidget {
  static const routeName = "/AddDeliveryAddress";
  const AddDeliveryAddress({super.key});

  @override
  State<AddDeliveryAddress> createState() => _AddDeliveryAddressState();
}
// enum AddressType {
//   Home,
//   Work,
//   Others,
// }

class _AddDeliveryAddressState extends State<AddDeliveryAddress> {
  // var myType = AddressType.Home;
  @override
  Widget build(BuildContext context) {
    CheckoutProvider checkoutProvider = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const TitleTextWidget(label: "Add Delivery Address"),
      ),
      bottomNavigationBar: Container(
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          height: 48,
          child: checkoutProvider.isLoading == false
              ? MaterialButton(
                  child: const Text(
                    "Add Address",
                    style: TextStyle(color: Colors.black),
                  ),
                  color: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  onPressed: () {
                    checkoutProvider.validator(context);
                  },
                )
              : const Center(
                  child: CircularProgressIndicator(),
                )),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 30),
              CustomTextField(
                labText: "Name",
                controller: checkoutProvider.name,
              ),
              const SizedBox(height: 20),
              CustomTextField(
                labText: "Mobile Number",
                controller: checkoutProvider.mobileNumber,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              CustomTextField(
                labText: "Alternate Number",
                controller: checkoutProvider.alternateNumber,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              CustomTextField(
                labText: "Pincode",
                controller: checkoutProvider.pincode,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              CustomTextField(
                labText: "State",
                controller: checkoutProvider.state,
              ),
              const SizedBox(height: 20),
              CustomTextField(
                labText: "Address(House name,building,street,area)",
                controller: checkoutProvider.addressMain,
              ),
              const SizedBox(height: 20),
              CustomTextField(
                labText: "Locality/Town",
                controller: checkoutProvider.locality,
              ),
              const SizedBox(height: 20),
              CustomTextField(
                labText: "City/District",
                controller: checkoutProvider.city,
              ),

              // InkWell(
              //   onTap: () {},
              //   child: Container(
              //     height: 47,
              //     width: double.infinity,
              //     child: Column(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: [Text("Set Location")],
              //     ),
              //   ),
              // ),
              // Divider(),
              // ListTile(
              //   title: Text("Address Type"),
              // ),
              // RadioListTile(
              //   value: AddressType.Home,
              //   groupValue: myType,
              //   title: Text("Home"),
              //   onChanged: (value) {},
              //   secondary: Icon(Icons.home),
              // ),
              // RadioListTile(
              //   value: AddressType.Work,
              //   groupValue: "groupValue",
              //   title: Text("Work"),
              //   onChanged: (value) {},
              //   secondary: Icon(Icons.work),
              // ),
              // RadioListTile(
              //   value: AddressType.
              //   groupValue: "groupValue",
              //   title: Text("Other"),
              //   onChanged: (value) {},
              //   secondary: Icon(Icons.devices_other_sharp),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
