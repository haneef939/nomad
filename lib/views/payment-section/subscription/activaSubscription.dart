import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nomad/controllers/auth_controller.dart';
import 'package:nomad/utils/constant.dart';
import 'package:nomad/views/initial-screens/forget-password/forgetPassword.dart';
import 'package:nomad/views/payment-section/success/paymentSuccess.dart';
import 'package:nomad/widgets/buttons/primary_button.dart';
import 'package:nomad/widgets/gradientWidget.dart';
import 'package:nomad/widgets/text-fields/emailField.dart';
import 'package:nomad/widgets/text-fields/paswrdField.dart';
import 'package:nomad/widgets/toast.dart';
//import 'package:mystery_word/views/home/recordData.dart';

class ActiveSubs extends StatefulWidget {
  @override
  _ActiveSubsState createState() => _ActiveSubsState();
}

class _ActiveSubsState extends State<ActiveSubs> {
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
                          color: Colors.deepOrangeAccent,
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
                    "Profile created successfully!",
                    style: TextStyle(
                        fontSize: 25.w,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff890000)),
                  ),
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height / 2,
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
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(KConstant.nomadPass),
                        SizedBox(width: 20.w),
                        Image.asset(KConstant.priceTag),
                      ],
                    ),
                  ),
                  Container(),
                  Text(
                    "Activate Subscription",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.75,
                    child: Text(
                      "There is a little left. Join a plan and start looking for adventure companions",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: KPrimaryButton(
                          btnText: "PAY IN", icon: icon, onPressed: () {
                            Get.to(PaymentSuccess());

                      })),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
