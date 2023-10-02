import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nomad/controllers/auth_controller.dart';

class LocationField extends StatefulWidget {
  final TextEditingController controller;
  final AuthController? appController;
  final String hintText;

  const LocationField(
      {Key? key,
      this.appController,
      required this.controller,
      required this.hintText})
      : super(key: key);

  @override
  _LocationFieldState createState() => _LocationFieldState();
}

class _LocationFieldState extends State<LocationField> {
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
          style: TextStyle(fontSize: 22.0, color: Colors.white),

          decoration: InputDecoration(
            //  icon: Icon(Icons.phone_iphone),
            labelText: widget.hintText,
            labelStyle: TextStyle(color: Colors.white, fontSize: 15),
          ),
          validator: (value) {
            return widget.appController?.validateField(value ?? "");
          },
        ),
      ),
    );
  }
}
