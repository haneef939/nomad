import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nomad/controllers/auth_controller.dart';

class PasswordField extends StatefulWidget {
  final AuthController authController;

  const PasswordField({Key? key, required this.authController}) : super(key: key);

  @override
  _PasswordFieldState createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
//Dependency injection

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        width: 290.w,
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: TextFormField(
          obscureText: true,
          controller: widget.authController.pswrdController.value,
          maxLength: 12,
          style: TextStyle(fontSize: 22.0, color: Colors.white),
          decoration: InputDecoration(
            labelText: "Password",
            labelStyle: TextStyle(color: Colors.white, fontSize: 15),
            errorStyle: TextStyle(color: Colors.white, fontSize: 15),
          ),
          validator: (value) {
            return widget.authController.validatePassword(value ?? "");
          },
        ),
      ),
    );
  }
}
