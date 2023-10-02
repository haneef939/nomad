import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nomad/controllers/auth_controller.dart';
import 'package:nomad/models/user-model.dart';
import 'package:nomad/service/navigation-service.dart';
import 'package:nomad/views/admin/adminView.dart';
import 'package:nomad/views/dashboard/dashboard.dart';
import 'package:nomad/views/profile/dialog/account.dart';
import 'package:nomad/views/profile/dialog/logoutDialog.dart';
import 'package:nomad/widgets/toast.dart';

class UserController extends GetxController {
  UserModel userModel = new UserModel();
  RxList<UserModel> userList = <UserModel>[].obs;
  RxList<UserModel> localList = <UserModel>[].obs;
  FirebaseAuth auth = FirebaseAuth.instance;
  var isActive = true.obs;
  var userRole = "".obs;

  Future<UserModel?> getUserData({BuildContext? context}) async {
    var collection = FirebaseFirestore.instance.collection('user');
    var docSnapshot = await collection.doc(auth.currentUser?.uid).get();
    if (docSnapshot.exists) {
      Map<String, dynamic>? doc = docSnapshot.data();
      userModel = UserModel(
        userId: doc?['userId'],
        fullName: doc?['fullName'],
        country: doc?['country'],
        gender: doc?['gender'],
        dob: doc?['dob'],
        email: doc?['email'],
        followers: doc?['followers'],
        following: doc?['following'],
        userType: doc?['userType'],
        userRole: doc?['userRole'],
        userImg: doc?['userImg'],
        userPassport: doc?['userPassport'],
        isActive: doc?['isActive'],
        createdBy: doc?['createdBy'],
        updatedBy: doc?['updatedBy'],
      );
      isActive.value = userModel.isActive ?? false;
      userRole.value = userModel.userRole ?? "";

      if (userRole.value == "admin") {
        Get.offAll(AdminView());
      } else {
        Get.off(Dashboard());
      }

      // if (!isActive.value)
      //   showDialog(
      //       barrierDismissible: false,
      //       context: NavigationService.navigatorKey.currentContext,
      //       builder: (BuildContext context) {
      //         return AccountDialogBox(
      //           title: "Account Disable",
      //           descriptions: "Ask admin to enable",
      //         );
      //       });

      prr("userModel.fullName ${userModel.fullName}");
      // Call setState if needed.
    }
    return null;
  }

  Future<void> getUsersListData() async {
    try {
      var collection = FirebaseFirestore.instance.collection('user');
      var querySnapshot = await collection.get();

      if (querySnapshot.docs.isNotEmpty) {
        userList.clear(); // Clear the existing user list
        for (var doc in querySnapshot.docs) {
          Map<String, dynamic>? docData = doc.data();
          UserModel user = UserModel(
            userId: docData?['userId'],
            fullName: docData?['fullName'],
            country: docData?['country'],
            gender: docData?['gender'],
            dob: docData?['dob'],
            followers: docData?['followers'],
            following: docData?['following'],
            email: docData?['email'],
            userType: docData?['userType'],
            userRole: docData?['userRole'],
            userImg: docData?['userImg'],
            userPassport: docData?['userPassport'],
            isActive: docData?['isActive'],
            createdBy: docData?['createdBy'],
            updatedBy: docData?['updatedBy'],
          );
          userList.add(user);
        }
      }
    } catch (e) {
      // Handle errors if needed
      print('Error getting users: $e');
    }
  }
}
