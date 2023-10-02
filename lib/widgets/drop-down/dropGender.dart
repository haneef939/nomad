import 'package:dropdown_below/dropdown_below.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nomad/controllers/auth_controller.dart';
import 'package:nomad/controllers/fields_controller.dart';

class DropDownGender extends StatefulWidget {
  final AuthController authController;

  const DropDownGender({Key? key, required this.authController}) : super(key: key);

  @override
  _DropQuantityTTState createState() => _DropQuantityTTState();
}

class _DropQuantityTTState extends State<DropDownGender> {
  List listData = [];

  List<DropdownMenuItem<Object>> _dropdownItems = [];
  var _selected;

  @override
  void initState() {
    _dropdownItems =
        buildDropdownItems();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  List<DropdownMenuItem<Object>> buildDropdownItems( ) {
    List<DropdownMenuItem<Object>> items = [];
    listData.add("Male");
    listData.add("Female");

    for (var i in listData) {
      items.add(
        DropdownMenuItem(
          value: i,
          child: Text(i),
        ),
      );
    }
    return items;
  }

  onChangeDropdownTests(selected) {
    print(selected);
    setState(() {
      //  _selectedTest = selectedTest;
      widget.authController.genderDropDown = selected;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Container(
          width: MediaQuery.of(context).size.width / 1.25,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: DropdownButtonHideUnderline(
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                new InputDecorator(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10.0),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                    filled: false,
                    hintText:
                        "Gender",
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      // fontSize: 20,
                    ),
                  ),
                  isEmpty: widget.authController.genderDropDown == null,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: new DropdownButton<Object>(
                      value: widget.authController.genderDropDown,
                      style: TextStyle(
                          //    fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: Colors.black),
                      icon: Icon(Icons.arrow_drop_down_sharp,
                          color: Color(0xffF6C634), size: 30),
                      isDense: true,
                      onChanged: onChangeDropdownTests,
                      items: _dropdownItems,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
