import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nomad/controllers/fields_controller.dart';
import 'package:nomad/controllers/auth_controller.dart';

class CountryField extends StatefulWidget {
  final TextEditingController controller;
  final AuthController authController;
  final String hintText;

  const CountryField(
      {Key? key, required this.authController, required this.controller, required this.hintText})
      : super(key: key);

  @override
  _CountryFieldState createState() => _CountryFieldState();
}

class _CountryFieldState extends State<CountryField> {
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
            showCountryPicker(
              context: context,
              showPhoneCode: false,
              countryListTheme: CountryListThemeData(
                flagSize: 25,

                backgroundColor:Color(0xffFFA270),
                textStyle: TextStyle(fontSize: 16, color: Colors.white),

                //Optional. Sets the border radius for the bottomsheet.
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
                //Optional. Styles the search field.
                inputDecoration: InputDecoration(
                  labelText: 'Search',
                  labelStyle: TextStyle(fontSize: 16, color: Colors.white),
                  helperStyle: TextStyle(fontSize: 16, color: Colors.white),
                  hintText: 'Start typing to search',
                  hintStyle: TextStyle(fontSize: 16, color: Colors.white),
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: const Color(0xFF8C98A8).withOpacity(0.2),
                    ),
                  ),
                ),
              ),
              // optional. Shows phone code before the country name.
              onSelect: (Country country) {
                print('Select country: ${country.displayName}');
                widget.authController.countryController.value.text =
                    country.name;
                setState(() {});
              },
            );
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
