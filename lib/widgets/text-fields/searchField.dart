import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nomad/controllers/auth_controller.dart';
import 'package:nomad/utils/constant.dart';

class SearchField extends StatefulWidget {
  final AuthController appController;

  const SearchField({Key? key, required this.appController}) : super(key: key);

  @override
  _SearchFieldState createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
//Dependency injection

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Container(
          height: 50.h,
          width: MediaQuery.of(context).size.width / 1.5,
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: TextFormField(
            controller: widget.appController.userSearchController.value,
            //keyboardType:TextInputType.number,
            // maxLength: 12,

            decoration: InputDecoration(
              //  icon: Icon(Icons.phone_iphone),
              hintText: "Email",
              prefixIcon: Icon(Icons.search, color: KConstant.colorB),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
                borderSide: BorderSide(
                  color: KConstant.colorA,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
                borderSide: BorderSide(
                  color: KConstant.colorA,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
                borderSide: BorderSide(
                  color: KConstant.colorA,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
                borderSide: BorderSide(
                  color: KConstant.colorA,
                ),
              ),
            ),
            validator: (value) {
              return widget.appController.validateField(value ?? "");
            },
          ),
        ),
    );
  }
}
