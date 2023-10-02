import 'dart:ui';

import 'package:flutter/material.dart';

class KConstant {
  static const BASEIMAGEURL = "assets/imgs/";

  // static const LOTTIEBASEURL = "assets/anim/";
  static final splashIcon = BASEIMAGEURL + "splash_icon.png";
  static final loginTopIcon = BASEIMAGEURL + "login_top.png";
  static final appName = 'Nomad Digital';
  static final appleLogin = BASEIMAGEURL + 'apple_login.png';
  static final googleLogin = BASEIMAGEURL + 'google_login.png';
  static final backWhiteButton = BASEIMAGEURL + 'back_button.png';
  static final backOrangeButton = BASEIMAGEURL + 'back_orange_btn.png';
  static final passportImg = BASEIMAGEURL + 'passport_img.png';
  static final profilePic = BASEIMAGEURL + 'profile_pic.png';
  static final nomadPass = BASEIMAGEURL + 'nomad_pass.png';
  static final priceTag = BASEIMAGEURL + 'price_tag.png';
  static final smallPerson = BASEIMAGEURL + 'notification_person.png';

  static final splashDuration = Duration(milliseconds: 3);
  static final refreshApp = Duration(seconds: 3);
  static final Color colorA = Color(0xffF9683A);
  static final Color colorB = Color(0xff870A00);

  static final String picUploaded = "Picture has been uploaded";
  static final String userType = "User state is modified";

  static final Icon upload_pic =
      Icon(Icons.cloud_upload_rounded, color: Colors.deepOrange);
  static final Icon camera_alt =
      Icon(Icons.camera_alt, color: Colors.deepOrange);
  static final Icon photo_camera_outlined =
      Icon(Icons.photo_camera_outlined, color: Colors.deepOrange);
}

const String qFamFont = "Quicksand";
const String wFamFont = "WorkSan";
const String sFamFont = "Sarabun";
const String rFamFont = "Raleway";
