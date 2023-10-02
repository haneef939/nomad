import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nomad/controllers/auth_controller.dart';
import 'package:nomad/utils/constant.dart';

class HourField extends StatefulWidget {
  final TextEditingController controller;
  final AuthController authController;
  final String hintText;

  const HourField(
      {Key? key, required this.authController, required this.controller, required this.hintText})
      : super(key: key);

  @override
  _HourFieldState createState() => _HourFieldState();
}

class _HourFieldState extends State<HourField> {
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
          onTap: () {
            _select();
            FocusScope.of(context).requestFocus(new FocusNode());
          },
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

  Future _select() async {
    TimeOfDay initialTime = TimeOfDay.now();

    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: initialTime,
      builder: (BuildContext context, Widget? child) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: child ?? Container(),
        );
      },
    );
    if (pickedTime != null)
      setState(() => {
            //data.registrationdate = picked.toString(),

            widget.controller.text = "${pickedTime.hour} "
          });
  }
}
