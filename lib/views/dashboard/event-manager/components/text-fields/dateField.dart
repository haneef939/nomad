import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nomad/controllers/auth_controller.dart';
import 'package:nomad/utils/constant.dart';

import '../../../../../controllers/event_controller.dart';

class DateField extends StatefulWidget {
  final TextEditingController controller;
  final AuthController authController;
  final String hintText;
  int dateValue;

  DateField(
      {Key? key,
      required this.authController,
      required this.controller,
      required this.dateValue,
      required this.hintText})
      : super(key: key);

  @override
  _DateFieldState createState() => _DateFieldState();
}

class _DateFieldState extends State<DateField> {
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
            _selectDate();
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          decoration: InputDecoration(
            //  icon: Icon(Icons.phone_iphone),
            labelText: widget.hintText,
            labelStyle: TextStyle(color: KConstant.colorA, fontSize: 15),
          ),
          validator: (value) {
            return widget.authController.validateField(value ?? "");
          },
        ),
      ),
    );
  }

  Future _selectDate() async {
    EventController eventController = Get.put(EventController());
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: new DateTime.now(),
        firstDate: new DateTime.now(),
        lastDate: new DateTime(2030));
    if (picked != null) {
      setState(() {
        //data.registrationdate = picked.toString(),
        widget.dateValue = picked.millisecondsSinceEpoch;
        eventController.eventDate1.value = picked.millisecondsSinceEpoch;
        widget.controller.text = "${picked.day}-${picked.month}-${picked.year}";
      });
    }
  }
}
