import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nomad/models/user-model.dart';
import 'package:nomad/service/navigation-service.dart';
import 'package:nomad/utils/constant.dart';
import 'package:nomad/utils/flushbar_util.dart';
import 'package:nomad/views/dashboard/dashboard.dart';
import 'package:nomad/views/initial-screens/scan-passport/scanPassport.dart';
import 'package:nomad/widgets/toast.dart';

import 'auth_controller.dart';

class ImageController extends GetxController {
  AuthController authController = Get.put(AuthController());

  //instance of firestore
  File? imageFile;

  final picker = ImagePicker();
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future getImage({bool? isCamera}) async {
    var pickedFile;
    pickedFile = await picker.pickImage(
        source: (isCamera ?? false) ? ImageSource.camera : ImageSource.gallery);

    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
    } else {
      print('No image selected.');
    }

    prr("Image value ${imageFile?.path}");
  }

  uploadPhoto({File? image, String? name}) {
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref =
        storage.ref().child((name ?? "") + DateTime.now().toString());
    UploadTask uploadTask = ref.putFile(image ?? File(""));
    authController.isLoading.value = true;

    uploadTask.then((res) async {
      await res.ref.getDownloadURL();

      if (name == "DP_") {
        authController.userImg.value = await ref.getDownloadURL();
      } else {
        authController.userPassport.value = await ref.getDownloadURL();
      }

      alertBar(NavigationService.navigatorKey.currentContext!,
          KConstant.picUploaded, Colors.black);

      prr(authController.userImg);
      //  updatePic(name: name);

      updatePic(name: name ?? "");

      // if (name == "DP_") {
      //   updatePic(name: name);
      // } else {
      //   authController.registerUser();
      // }
    });
  }

  updatePic({String? name}) async {
    User? user = await auth.currentUser;

    UserModel userModel;

    DocumentReference ref =
        FirebaseFirestore.instance.collection('user').doc(user?.uid);
    if (name == "DP_") {
      userModel =  UserModel(
        userImg: authController.userImg.value,
      );
      ref.update(userModel.getImgDataMap()).then((value) => {
            Get.to(PassportPic()),
          });
    } else {
      userModel = UserModel(
        userPassport: authController.userPassport.value,
      );

      ref.update(userModel.getPassportImgDataMap()).then((value) => {
            Get.to(Dashboard()),
          });
    }
    authController.isLoading.value = false;
  }
}
