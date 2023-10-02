import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nomad/controllers/auth_controller.dart';
import 'package:nomad/utils/constant.dart';

class TitleField extends StatefulWidget {
  final TextEditingController controller;
  final AuthController authController;
  final String hintText;

  const TitleField(
      {Key? key,
      required this.authController,
      required this.controller,
      required this.hintText})
      : super(key: key);

  @override
  _TitleFieldState createState() => _TitleFieldState();
}

class _TitleFieldState extends State<TitleField> {
//Dependency injection

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0),
      child: Container(
        width: 290.w,
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: TextFormField(
          controller: widget.controller,
          //keyboardType:TextInputType.number,
          //  maxLength: 12,
          style: TextStyle(fontSize: 22.0, color: Colors.black),

          decoration: InputDecoration(
            //  icon: Icon(Icons.phone_iphone),
            labelText: widget.hintText,
            labelStyle: TextStyle(color: KConstant.colorA, fontSize: 15),
          ),
          validator: (value) {
            return widget.authController.validateNameField(value ?? "");
          },
        ),
      ),
    );
  }
}
