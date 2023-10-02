import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nomad/controllers/auth_controller.dart';

class TextxField extends StatefulWidget {
  final TextEditingController controller;
  final AuthController appController;
  final String hintText;
  final Function validator;

  const TextxField(
      {Key? key,
      required this.appController,
      required this.controller,
      required this.hintText,
      required this.validator
      
      })
      : super(key: key);

  @override
  _TextxFieldState createState() => _TextxFieldState();
}

class _TextxFieldState extends State<TextxField> {
//Dependency injection

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        width: MediaQuery.of(context).size.width / 1.25,
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: TextFormField(
          controller: widget.controller,
          //keyboardType:TextInputType.number,
          //  maxLength: 12,
          style: TextStyle(fontSize: 22.0, color: Colors.white),
          decoration: InputDecoration(
            //  icon: Icon(Icons.phone_iphone),
            labelText: widget.hintText,
            labelStyle: TextStyle(color: Colors.white, fontSize: 15),
            errorStyle: TextStyle(color: Colors.white, fontSize: 15),
          ),
          validator: (value) {
            return widget.appController.validatePassword(value ?? "");
          },
        ),
      ),
    );
  }
}
