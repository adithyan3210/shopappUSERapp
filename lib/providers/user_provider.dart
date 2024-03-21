import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopapp/models/user_model.dart';

class UserProvider with ChangeNotifier {
  UserModel? userModel;
  UserModel? get getUserModel {
    return userModel;
  }

  Future<UserModel?> fetchUserInfo() async {
    final auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    if (user == null) {
      return null;
    }
    String uid = user.uid;
    try {
      final userDoc =
          await FirebaseFirestore.instance.collection("users").doc(uid).get();
          final userDocDict=userDoc.data();
          userModel=UserModel(userId: userDoc.get("userId"), 
          userName: userDoc.get("userName"),
           userImage: userDoc.get("userImage"),
           userEmail: userDoc.get("userEmail"), 
           createdAt: userDoc.get("createdAt"), 
           userCart: userDocDict!.containsKey("userCart")?userDoc.get("userCart"):[],
            userWishlist: userDocDict.containsKey("userWishlist")?userDoc.get("userWishlist"):[], 
            );
            return userModel;
    } on FirebaseAuthException {
      rethrow;
    } catch (error) {
      rethrow;
    }
  }
}

