import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nomad/utils/constant.dart';
import 'package:nomad/widgets/buttons/primary_button.dart';
import 'package:nomad/widgets/toast.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpScreen extends StatelessWidget {
  final String? phoneNumber;

  OtpScreen({Key? key, this.phoneNumber}) : super(key: key);

  // //dependency injection
  // AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    Color colorA = Color(0xffFFA270);
    Color colorB = Color(0xff870000);
    return SafeArea(
      child: Scaffold(
        backgroundColor: colorB,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Color(0xffFFA270),
          leading: IconButton(
            icon: Image.asset(KConstant.backWhiteButton),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: Container(
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
              Container(
                //   transform: Matrix4.translationValues(0.0, -100.h, 0.0),
                child: Text(
                  "Verify",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.75,
                child: Text(
                  "We sent you a code to verify your number",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 20.h),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: PinCodeTextField(
                  appContext: context,
                  length: 6,
                  obscureText: true,
                  animationType: AnimationType.fade,
                  // autoFocus: false,
                  keyboardType: TextInputType.number,
                  pinTheme: PinTheme(
                    // shape: PinCodeFieldShape.circle,
                    borderRadius: BorderRadius.circular(10.sp),
                    activeColor: Colors.grey.withOpacity(0.3),
                    fieldHeight: 50.h,
                    fieldWidth: 40.w,
                    inactiveColor: Colors.grey,
                  ),
                  onChanged: (String value) {},
                  onCompleted: (value) {
                    prr("message");
                  },
                ),
              ),
              SizedBox(height: 50.h),
              KPrimaryButton(
                btnText: "Next",
                onPressed: () {},
              ),
              SizedBox(height: 20.h),
              Container(
                width: MediaQuery.of(context).size.width * 0.75,
                child: Text(
                  "You didn't receive it? Submit a new code",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
