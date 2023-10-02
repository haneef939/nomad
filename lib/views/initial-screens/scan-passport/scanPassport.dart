import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nomad/controllers/auth_controller.dart';
import 'package:nomad/controllers/image_controller.dart';
import 'package:nomad/utils/constant.dart';
import 'package:nomad/views/initial-screens/forget-password/forgetPassword.dart';
import 'package:nomad/views/payment-section/subscription/activaSubscription.dart';
import 'package:nomad/widgets/buttons/primary_button.dart';
import 'package:nomad/widgets/gradientWidget.dart';
import 'package:nomad/widgets/text-fields/emailField.dart';
import 'package:nomad/widgets/text-fields/paswrdField.dart';
import 'package:nomad/widgets/toast.dart';
//import 'package:mystery_word/views/home/recordData.dart';

class PassportPic extends StatefulWidget {
  @override
  _PassportPicState createState() => _PassportPicState();
}

class _PassportPicState extends State<PassportPic> {
  Icon upload_pic = Icon(Icons.cloud_upload_rounded, color: Colors.deepOrange);
  Icon camera_alt = Icon(Icons.camera_alt, color: Colors.deepOrange);
  Icon photo_camera_outlined =
      Icon(Icons.photo_camera_outlined, color: Colors.deepOrange);
  File? imageFile;
  final picker = ImagePicker();

  ImageController profileController = Get.put(ImageController());
  AuthController authController = Get.put(AuthController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    Color colorA = Color(0xffFFA270);
    Color colorB = Color(0xff890000);
    return WillPopScope(
      onWillPop: () => _onWillPop(),
      child: Scaffold(
        backgroundColor: colorB,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Color(0xffFFA270),
          automaticallyImplyLeading: false,

          // leading: IconButton(
          //   icon: Image.asset(KConstant.backWhiteButton),
          //   onPressed: () => Navigator.of(context).pop(),
          // ),
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.transparent,
          elevation: 0,
          child: Container(
            height: 200.h,
            child: Column(
              children: [
                if (imageFile != null)
                  KPrimaryButton(
                      btnText: "Upload Photo",
                      icon: upload_pic,
                      onPressed: () {
                        profileController.uploadPhoto(
                            image: imageFile ?? File(""), name: "PSPRT_");
                        //    Get.to(ActiveSubs());
                      }),
                SizedBox(height: 10.h),
                KPrimaryButton(
                    btnText: "Choose a Photo",
                    icon: camera_alt,
                    onPressed: () {
                      getPicData(isCamera: false);
                      //    Get.to(ActiveSubs());
                    }),
                SizedBox(height: 10.h),
                KPrimaryButton(
                    btnText: "Take a Photo",
                    icon: photo_camera_outlined,
                    onPressed: () {
                      getPicData(isCamera: true);

                      //        Get.to(ActiveSubs());
                    }),
                SizedBox(height: 10.h),
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [colorA, colorB],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Add a Passport picture",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
                Container(
                  height: 10,
                ),

                // Container(
                //   width: MediaQuery.of(context).size.width * 0.75,
                //   child: Text(
                //     "Add a photo so your friends can find you",
                //     style: TextStyle(
                //       color: Colors.white,
                //       fontSize: 20,
                //     ),
                //     textAlign: TextAlign.left,
                //   ),
                // ),
                (imageFile == null)
                    ? Image.asset(KConstant.passportImg,
                        width: 300.w, height: 300.w)
                    : Image.file(imageFile ?? File(""),
                        width: 300, height: 300),
                Container(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future getPicData({bool? isCamera}) async {
    var pickedFile;
    pickedFile = await picker.pickImage(
      source: (isCamera ?? false) ? ImageSource.camera : ImageSource.gallery,
      imageQuality: 25,
    );

    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
    } else {
      print('No image selected.');
    }

    setState(() {});
    prr("Image value ${(imageFile ?? File("")).path}");
  }

  _onWillPop() {
    print("pressed");
  }
}
