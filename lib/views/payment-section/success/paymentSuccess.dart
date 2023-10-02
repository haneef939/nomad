import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nomad/controllers/auth_controller.dart';
import 'package:nomad/utils/constant.dart';
import 'package:nomad/views/dashboard/dashboard.dart';
import 'package:nomad/views/initial-screens/forget-password/forgetPassword.dart';
import 'package:nomad/widgets/buttons/home_button.dart';
import 'package:nomad/widgets/buttons/primary_button.dart';
import 'package:nomad/widgets/gradientWidget.dart';
import 'package:nomad/widgets/text-fields/emailField.dart';
import 'package:nomad/widgets/text-fields/paswrdField.dart';
import 'package:nomad/widgets/toast.dart';
//import 'package:mystery_word/views/home/recordData.dart';

class PaymentSuccess extends StatefulWidget {
  @override
  _PaymentSuccessState createState() => _PaymentSuccessState();
}

class _PaymentSuccessState extends State<PaymentSuccess> {
  AuthController appController = Get.put(AuthController());
  Icon icon = Icon(Icons.payment, color: Colors.deepOrange);

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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipOval(
                      child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [colorA, colorB],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xffE61628),
                                blurRadius: 10.0,
                              ),
                            ],
                            borderRadius: new BorderRadius.only(
                              topLeft: const Radius.circular(30.0),
                              topRight: const Radius.circular(30.0),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 100.w,
                            ),
                          ))),
                  SizedBox(height: 20.h),
                  Text(
                    "Payment succeed !",
                    style: TextStyle(
                        fontSize: 25.w,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff890000)),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(),
                    Text(
                      "Sign Up was successful",
                      style: TextStyle(
                          color: Colors.deepOrangeAccent,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.75,
                      child: Text(
                        "You can start using the application now",
                        style:
                            TextStyle(color: Color(0xff890000), fontSize: 20),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Align(
                        alignment: Alignment.bottomCenter,
                        child: KHomeButton(
                            btnText: "Home",
                            onPressed: () {
                              Get.offAll(Dashboard());
                            })),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
