import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nomad/controllers/auth_controller.dart';
import 'package:nomad/controllers/fields_controller.dart';
import 'package:nomad/controllers/auth_controller.dart';
import 'package:nomad/utils/constant.dart';
import 'package:nomad/views/initial-screens/forget-password/forgetPassword.dart';
import 'package:nomad/views/initial-screens/terms-of-service/termsOfService.dart';
import 'package:nomad/widgets/buttons/primary_button.dart';
import 'package:nomad/widgets/drop-down/dropGender.dart';
import 'package:nomad/widgets/gradientWidget.dart';
import 'package:nomad/widgets/text-fields/countryField.dart';
import 'package:nomad/widgets/text-fields/dobField.dart';
import 'package:nomad/widgets/text-fields/emailField.dart';
import 'package:nomad/widgets/text-fields/paswrdField.dart';
import 'package:nomad/widgets/text-fields/textField.dart';
import 'package:nomad/widgets/toast.dart';

//import 'package:mystery_word/views/home/recordData.dart';
import 'package:country_picker/country_picker.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  AuthController appController = Get.put(AuthController());
  FieldsController fieldsController = Get.put(FieldsController());
  AuthController authController = Get.put(AuthController());

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
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xffFFA270),
        leading: IconButton(
          icon: Image.asset(KConstant.backWhiteButton),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height - 80.h,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [colorA, colorB],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter),
          ),
          child: Form(
            key: authController.signUpFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Text(
                    "Register",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                ),

                //document number
                TextxField(
                  appController: appController,
                  controller: appController.fullNameController.value,
                  hintText: "Full Name",
                  validator: appController.validateUsername,
                ),

                CountryField(
                    authController: authController,
                    controller: authController.countryController.value,
                    hintText: "Country"),

                //gender dropdown
                DropDownGender(
                  authController: authController,
                ),
                DOBField(
                    authController: authController,
                    controller: authController.dobController.value,
                    hintText: "DOB"),
                EmailField(authController: appController),
                if (authController.userType.value == "email")
                  PasswordField(authController: appController),
                SizedBox(height: 15.h),
                // InkWell(
                //   onTap: () {
                //     print("yes");
                //     if (authController.signUpFormKey.currentState!.validate() &&
                //         authController.validateRegisterForm()) {
                //       Get.to(TermsOfService());
                //     } else {
                //       showToast("Enter all data properly");
                //     }
                //   },
                //   child: Container(
                //     height: 50.h,
                //     width: 290.w,
                //     color: Colors.white,
                //     child: Center(
                //       child: Text("NEXT"),
                //     ),
                //   ),
                // ),
                KPrimaryButton(
                  btnText: "NEXT",
                  onPressed: () {
                    print("yes");
                    if (authController.signUpFormKey.currentState!.validate() &&
                        authController.validateRegisterForm()) {
                      Get.to(TermsOfService());
                    } else {
                      showToast("Enter all data properly");
                    }
                  },
                ),
                SizedBox(height: 15.h),

                Container(
                  width: MediaQuery.of(context).size.width * 0.75,
                  child: Text(
                      "By proceeding you also agree to terms and condition",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white.withOpacity(0.8),
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
