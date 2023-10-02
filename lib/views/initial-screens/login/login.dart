import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nomad/controllers/auth_controller.dart';
import 'package:nomad/utils/constant.dart';
import 'package:nomad/views/initial-screens/forget-password/forgetPassword.dart';
import 'package:nomad/views/initial-screens/register/register.dart';
import 'package:nomad/views/initial-screens/scan-passport/fill-in-data/fillData.dart';
import 'package:nomad/widgets/buttons/primary_button.dart';
import 'package:nomad/widgets/text-fields/emailField.dart';
import 'package:nomad/widgets/text-fields/paswrdField.dart';
import 'package:nomad/widgets/toast.dart';

import '../../../controllers/user_controller.dart';
import '../../dashboard/dashboard.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  AuthController authController = Get.put(AuthController());
  UserController userController = Get.put(UserController());
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    Color colorA = Color(0xffFFA270);
    Color colorB = Color(0xff870000);
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [colorA, colorB],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter),
        ),
        child: Form(
          key: authController.loginFormKey,
          child: SingleChildScrollView(
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          //  color: Colors.black,
                          transform:
                              Matrix4.translationValues(-100.w, -30.h, 0.0),
                          child: Image.asset(KConstant.loginTopIcon),
                        )),
                  ],
                ),
                Container(
                  transform: Matrix4.translationValues(0.0, -100.h, 0.0),
                  child: const Text(
                    "Sign In",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  transform: Matrix4.translationValues(0.0, -100.h, 0.0),
                  width: MediaQuery.of(context).size.width * 0.75,
                  child: const Text(
                    "Welcome to the social media network where you go from the digital nomads from all over the world and you are going to perform the funniest events within your peers",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                EmailField(authController: authController),
                PasswordField(authController: authController),
                // SizedBox(height: 10.h),
                KPrimaryButton(
                    btnText: "Login",
                    onPressed: () async {
                      if (authController.loginFormKey.currentState!
                          .validate()) {
                        User? user = await authController.handleSignInEmail();
                        if (user != null) {
                          userController.getUserData();
                        }
                      } else {
                        showToast("Enter all data properly");
                      }
                    }),
                SizedBox(height: 10.h),
                InkWell(
                  onTap: () => Get.to(ForgetPassword()),
                  child: const Text("Forget Password",
                      style: TextStyle(color: Colors.grey, fontSize: 20)),
                ),
                SizedBox(height: 10.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: Colors.red.shade500,
                            ),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20))),
                        child: Image.asset(KConstant.appleLogin,
                            width: 50, height: 50)),
                    SizedBox(
                      width: 10.w,
                    ),
                    InkWell(
                      onTap: () async {
                        authController.googleLogin();
                      },
                      child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: Colors.red.shade500,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: Image.asset(KConstant.googleLogin,
                              width: 50, height: 50)),
                    )
                  ],
                ),
                SizedBox(height: 10.h),
                InkWell(
                  onTap: () {
                    authController.userType.value = "email";
                    Get.to(Register());
                  },
                  child: Text(
                    "Register",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
