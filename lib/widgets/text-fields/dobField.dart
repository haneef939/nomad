import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nomad/controllers/fields_controller.dart';
import 'package:nomad/controllers/auth_controller.dart';

class DOBField extends StatefulWidget {
  final TextEditingController controller;
  final AuthController authController;
  final String hintText;

  const DOBField(
      {Key? key, required this.authController, required this.controller, required this.hintText})
      : super(key: key);

  @override
  _DOBFieldState createState() => _DOBFieldState();
}

class _DOBFieldState extends State<DOBField> {
//Dependency injection

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        width: MediaQuery.of(context).size.width / 1.25,
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: InkWell(
          onTap: () {
            showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1900, 1),
              lastDate: DateTime.now(),
            ).then((pickedDate) {
              //do whatever you want

              widget.authController.timestampDOB =
                  (pickedDate ?? DateTime.now()).millisecondsSinceEpoch.toString();

              var onlyDate =
                  "${pickedDate?.day}-${pickedDate?.month}-${pickedDate?.year}";

              widget.authController.dobController.value.text =
                  onlyDate.toString();
            });
          },
          child: TextFormField(
            enabled: false,
            controller: widget.controller,
            //keyboardType:TextInputType.number,
            //  maxLength: 12,
            style: TextStyle(fontSize: 22.0, color: Colors.white),

            decoration: InputDecoration(
              //  icon: Icon(Icons.phone_iphone),
              labelText: widget.hintText,
              labelStyle: TextStyle(color: Colors.white, fontSize: 15),
            ),
          ),
        ),
      ),
    );
  }
}
