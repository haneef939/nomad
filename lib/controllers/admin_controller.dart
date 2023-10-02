import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nomad/models/user-model.dart';
import 'package:nomad/service/navigation-service.dart';
import 'package:nomad/utils/constant.dart';
import 'package:nomad/utils/flushbar_util.dart';
import 'package:nomad/views/admin/adminView.dart';

class AdminController extends GetxController {
  RxList<UserModel> showUsersList = RxList<UserModel>();
  RxList<UserModel> activeUsersList = RxList<UserModel>();
  RxList<UserModel> notActiveUsersList = RxList<UserModel>();

  //show users
  allUsersList() async {
    QuerySnapshot qShot =
        await FirebaseFirestore.instance.collection('user').get();
    return qShot.docs
        .map((doc) => UserModel(
              userId: doc['userId'],
              fullName: doc['fullName'],
              country: doc['country'],
              gender: doc['gender'],
              dob: doc['dob'],
              email: doc['email'],
              userImg: doc['userImg'],
              userPassport: doc['userPassport'],
              userType: doc['userType'],
              isActive: doc['isActive'],
              createdBy: doc['createdBy'],
              updatedBy: doc['updatedBy'],
            ))
        .toList();
  }

  updateUserType({bool? isActive, UserModel? userModel}) async {
    DocumentReference ref =
        FirebaseFirestore.instance.collection('user').doc(userModel?.userId);
    userModel = new UserModel(isActive: isActive);
    return ref.update(userModel.setUserActive()).then((value) => {
          alertBar(NavigationService.navigatorKey.currentContext!,
              KConstant.userType, Colors.black),
          Get.offAll(AdminView()),
        });
  }
}
