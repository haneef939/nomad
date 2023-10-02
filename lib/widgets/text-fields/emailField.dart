import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nomad/controllers/auth_controller.dart';

class EmailField extends StatefulWidget {
  final AuthController authController;

  const EmailField({Key? key, required this.authController}) : super(key: key);

  @override
  _EmailFieldState createState() => _EmailFieldState();
}

class _EmailFieldState extends State<EmailField> {
//Dependency injection

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 290.w,
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: TextFormField(
        //   enabled: (widget.authController.userType.value == "email") ?? true
        // : false,
        controller: widget.authController.emailController.value,
        //keyboardType:TextInputType.number,
        // maxLength: 12,
        style: TextStyle(fontSize: 22.0, color: Colors.white),

        decoration: InputDecoration(
          //  icon: Icon(Icons.phone_iphone),
          labelText: "Email",
          labelStyle: TextStyle(color: Colors.white, fontSize: 15),
          errorStyle: TextStyle(color: Colors.white, fontSize: 15),
        ),
        validator: (value) {
          return widget.authController.validateEmail(value ?? "");
        },
      ),
    );
  }
}
