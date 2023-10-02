import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nomad/controllers/auth_controller.dart';
import 'package:nomad/utils/constant.dart';
import 'package:nomad/views/initial-screens/login/login.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  AuthController appController = Get.put(AuthController());

   @override
  void initState() {
    super.initState();
    initFunction();
  }

  initFunction() async {
    //  isProfileSetup = false;
    //  bpController.canEmail.value = true;
    Future.delayed(KConstant.splashDuration, () {
      appController.checkLoginState();
    });
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    Color colorA = Color(0xffF9683A);
    Color colorB = Color(0xff870A00);
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [colorA, colorB],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: MediaQuery.of(context).size.width,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: AssetImage(KConstant.splashIcon),
              )),
            ),
          ],
        ),
      ),
    );
  }
}
