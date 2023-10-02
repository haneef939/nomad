import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nomad/controllers/user_controller.dart';
import 'package:nomad/models/user-model.dart';
import 'package:nomad/views/dashboard/dashboard.dart';
import 'package:nomad/views/dashboard/home/home.dart';
import 'package:nomad/views/initial-screens/add-profile-pic/profilePic.dart';
import 'package:nomad/views/initial-screens/login/login.dart';
import 'package:nomad/views/initial-screens/register/register.dart';
import 'package:nomad/views/initial-screens/terms-of-service/termsOfService.dart';
import 'package:nomad/views/splash/splash.dart';
import 'package:nomad/widgets/toast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'fields_controller.dart';
import 'home_controller.dart';

class AuthController extends GetxController {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  HomeController homeController = Get.put(HomeController());

  FirebaseAuth auth = FirebaseAuth.instance;
  UserController userController = Get.put(UserController());

  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();

  var isLoading = false.obs;

  //text controllers
  var fullNameController = TextEditingController().obs;
  var emailController = TextEditingController().obs;
  var pswrdController = TextEditingController().obs;
  String? genderDropDown;
  String? country;
  var dobController = TextEditingController().obs;
  var countryController = TextEditingController().obs;

  var userSearchController = TextEditingController().obs;
  var userNewMessageSearchC = TextEditingController().obs;

  var timestampDOB = "";

  var timeStamp = "".obs;
  var userType = "".obs;
  var userImg = "".obs;
  var userPassport = "".obs;

  Position? currentPosition;

  @override
  void onReady() {
    super.onReady();
  }

  bool isEmail() {
    if (userType.value == "email")
      return true;
    else
      return false;
  }

  String? validateField(String value) {
    if (GetUtils.isNull(value)) {
      return "Please enter a valid field";
    } else {
      return null;
    }
  }

  String? validateNameField(String value) {
    if (GetUtils.isNull(value) && value.length < 3) {
      return "Please enter a valid field";
    } else {
      return null;
    }
  }

  String? validateUsername(String value) {
    if (GetUtils.isNull(value)) {
      return "Length must be greater than 3";
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

  Future<User?> handleSignInEmail() async {
    try {
      UserCredential result = await auth.signInWithEmailAndPassword(
          email: emailController.value.text,
          password: pswrdController.value.text);
      User? user = result.user;
      return user;
    } catch (e) {
      showToast("${e.toString()}");
      return null;
    }
  }

  checkLoginState() async {
    if (await auth.currentUser != null) {
      // signed in
      userController.getUserData();
      userController.getUsersListData();

      // Get.off(Dashboard());
    } else {
      Get.off(Login());
    }
  }

  checkUserExists() async {
    bool fun = await userExists();
    if (fun) {
      userController.getUserData();
      userController.getUsersListData();
    } else {
      Get.off(Register());
    }
  }

  Future<bool> userExists() async {
    var _instance = FirebaseFirestore.instance;

    return (await _instance
                .collection("user")
                .where("email", isEqualTo: emailController.value.text)
                .get())
            .docs
            .length >
        0;
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    Get.offAll(Splash());
  }

  Future<User?> handleSignUp() async {
    User? user;
    UserCredential result;

    try {
      result = await auth.createUserWithEmailAndPassword(
          email: emailController.value.text,
          password: pswrdController.value.text);
      user = result.user;
      return user;
    } catch (e) {
      showToast(e.toString());
    }
    isLoading.value = false;
    return null;
  }

  googleLogin() async {
    GoogleSignInAccount? gAcc = await signInWithGoogle();
    userType.value = "google";
    emailController.value.text = gAcc?.email ?? "";
    final GoogleSignInAuthentication googleSignInAuthentication =
        await gAcc!.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );
    final UserCredential userCredential =
        await auth.signInWithCredential(credential);
    checkUserExists();
  }

  // get Current Location
  getCurrentLocationBeforeRegistration() {
    Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best,
            forceAndroidLocationManager: true)
        .then((Position position) {
      currentPosition = position;
      prr(currentPosition);
      registerUser();
    }).catchError((e) {
      print(e);
    });
  }

  // get Current Location
  getNearByNomads() {
    Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best,
            forceAndroidLocationManager: true)
        .then((Position position) async {
      currentPosition = position;
      await homeController.allUsersList(position);
    }).catchError((e) {
      print(e);
    });
  }

  checkLocation() async {
    Map<Permission, PermissionStatus> statuses;
    var status = await Permission.location.request();
    if (status.isGranted) {
      // Either the permission was already granted before or the user just granted it.
      getCurrentLocationBeforeRegistration();
    } else {
      showToast("We need your location in order to show nearby nomads");
      // You can request multiple permissions at once.
      statuses = await [
        Permission.location,
      ].request();
      print(statuses[Permission.location]);
      checkLocation();
    }
  }

  registerUser() async {
    auth = FirebaseAuth.instance;
    User? user;
    isLoading.value = true;
    prr("${userType.value} user typeee");
    if ((userType.value == "email")) {
      user = await handleSignUp();
    } else {
      user = await auth.currentUser;
    }
    user ??= await handleSignUp();
    if (user != null) {
      prr("message");
      UserModel userModel = UserModel(
        userId: user.uid,
        fullName: fullNameController.value.text,
        country: countryController.value.text,
        gender: genderDropDown,
        dob: dobController.value.text,
        email: emailController.value.text,
        userType: userType.value,
        userImg: userImg.value,
        userPassport: userPassport.value,
        lat: (currentPosition != null)
            ? currentPosition?.latitude.toString()
            : "",
        lng: (currentPosition != null)
            ? currentPosition?.longitude.toString()
            : "",
        isActive: false,
        createdBy: getTodayDate(),
        updatedBy: getTodayDate(),
      );
      try {
        await createOrUpdateUserData(userModel.setDataMap());

        //  Get.off(Dashboard());
        Get.offAll(ProfilePic());
      } catch (e) {
        showToast('Something went wrong ${e.toString()}');
      }
      isLoading.value = false;
    } else {
      prr("user is null");
    }
  }

  createOrUpdateUserData(Map<String, dynamic> userDataMap) async {
    User? user = auth.currentUser;

    DocumentReference ref =
        FirebaseFirestore.instance.collection('user').doc(user?.uid);
    return ref.set(userDataMap);
  }

  resetPassword() async {
    try {
      await auth.sendPasswordResetEmail(
        email: emailController.value.text,
      );
      showToast('Email has been sent to your email');
      Get.to(Login());
    } catch (e) {
      showToast('Invalid email. Please try again.');
    }
  }

  validateRegisterForm() {
    if (dobController.value.text != "" &&
        genderDropDown != null &&
        countryController.value.text != null)
      return true;
    else
      return false;
  }

  String getTodayDate() {
    return DateTime.now().millisecondsSinceEpoch.toString();
  }

  Future<GoogleSignInAccount?> signInWithGoogle() async {
    return _googleSignIn.signIn();
  }
}
