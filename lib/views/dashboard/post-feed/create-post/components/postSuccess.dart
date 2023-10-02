import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nomad/controllers/auth_controller.dart';
import 'package:nomad/utils/constant.dart';
import 'package:nomad/views/initial-screens/forget-password/forgetPassword.dart';
import 'package:nomad/widgets/buttons/primary_button.dart';
import 'package:nomad/widgets/gradientWidget.dart';
import 'package:nomad/widgets/text-fields/emailField.dart';
import 'package:nomad/widgets/text-fields/paswrdField.dart';
import 'package:nomad/widgets/toast.dart';
//import 'package:mystery_word/views/home/recordData.dart';

class PostSuccess extends StatefulWidget {
  @override
  _PostSuccessState createState() => _PostSuccessState();
}

class _PostSuccessState extends State<PostSuccess> {
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
        child: SafeArea(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height ,
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
                      "Post created successfully!",
                      style: TextStyle(
                          fontSize: 25.w,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff890000)),
                    ),
                  ],
                ),
              ),
            Container()
            ],
          ),
        ),
      ),
    );
  }
}
