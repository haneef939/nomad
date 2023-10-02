import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FieldsController extends GetxController {
  //text controllers
  var postTitleC = TextEditingController().obs;
  var postPrivacyC = TextEditingController().obs;



  var timestampDOB = "";

  // RxList<UserModel> users = RxList<UserModel>([]);

  @override
  void onReady() {
    super.onReady();
  }

  String? validateField(String value) {
    if (GetUtils.isNull(value)) {
      return "Please enter a valid field";
    } else {
      return null;
    }
  }

  String? validateEmail(String value) {
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value);
    if (!emailValid) {
      return "Please enter a valid field";
    } else {
      return null;
    }
  }

  String? validatePassword(String value) {
    if (GetUtils.isNull(value) || value.length < 6) {
      return "Length must be greater than 5";
    } else {
      return null;
    }
  }


}
