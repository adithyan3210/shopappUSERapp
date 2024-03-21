import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shopapp/checkout/delivery_address_model.dart';

class CheckoutProvider with ChangeNotifier {
  bool isLoading = false;

  TextEditingController name = TextEditingController();
  TextEditingController mobileNumber = TextEditingController();
  TextEditingController alternateNumber = TextEditingController();
  TextEditingController pincode = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController addressMain = TextEditingController();
  TextEditingController locality = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController setLocation = TextEditingController();

  void validator(context) async {
    // Check if a user is logged in
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      Fluttertoast.showToast(msg: "User not logged in");
      return;
    }

    if (name.text.isEmpty) {
      Fluttertoast.showToast(msg: "Firstname is empty");
    } else if (mobileNumber.text.isEmpty) {
      Fluttertoast.showToast(msg: "MobileNumber is empty");
    } else if (alternateNumber.text.isEmpty) {
      Fluttertoast.showToast(msg: "AlternateNumber is empty");
    } else if (pincode.text.isEmpty) {
      Fluttertoast.showToast(msg: "Pincode is empty");
    } else if (state.text.isEmpty) {
      Fluttertoast.showToast(msg: "State is empty");
    } else if (addressMain.text.isEmpty) {
      Fluttertoast.showToast(msg: "Address is empty");
    } else if (locality.text.isEmpty) {
      Fluttertoast.showToast(msg: "Locality is empty");
    } else if (city.text.isEmpty) {
      Fluttertoast.showToast(msg: "City is empty");
    } else {
      isLoading = true;
      notifyListeners();
      await FirebaseFirestore.instance
          .collection("AddDeliveryAddress")
          .doc(user.uid)
          .set({
        "Name": name.text,
        "MobileNumber": mobileNumber.text,
        "AlternateNumber": alternateNumber.text,
        "pincode": pincode.text,
        "State": state.text,
        "Address": addressMain.text,
        "Locality": locality.text,
        "city": city.text,
      }).then((value) async {
        isLoading = false;
        notifyListeners();
        await Fluttertoast.showToast(msg: "Add your delivey Address");
        Navigator.of(context).pop();
        notifyListeners();
      });
      notifyListeners();
    }
  }

  List<DeliveryAddressModel> deliverAddressList = [];

  fetchDeliveryAddress() async {
    List<DeliveryAddressModel> newList = [];
    DeliveryAddressModel deliveryAddressModel;
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      Fluttertoast.showToast(msg: "User not logged in");
      return null;
    }

    DocumentSnapshot db = await FirebaseFirestore.instance
        .collection("AddDeliveryAddress")
        .doc(user.uid)
        .get();
    if (db.exists) {
      deliveryAddressModel = DeliveryAddressModel(
        title: db.get("Name"),
        mobileNumber: db.get("MobileNumber"),
        alternateNumber: db.get("AlternateNumber"),
        city: db.get("city"),
        pincode: db.get("pincode"),
        addressMain: db.get("Address"),
        locality: db.get("Locality"),
        state: db.get("State"),
      );
      newList.add(deliveryAddressModel);
      notifyListeners();
    }
    deliverAddressList = newList;
    notifyListeners();
  }

  List<DeliveryAddressModel> get fetchDeliveryAddressList {
    return deliverAddressList;
  }
}
