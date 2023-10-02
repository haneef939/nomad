import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nomad/controllers/auth_controller.dart';
import 'package:nomad/utils/constant.dart';

import '../../../../../controllers/user_controller.dart';

class SearchPeople extends StatefulWidget {
  final AuthController appController;

  const SearchPeople({Key? key, required this.appController}) : super(key: key);

  @override
  _SearchPeopleState createState() => _SearchPeopleState();
}

class _SearchPeopleState extends State<SearchPeople> {
//Dependency injection
  UserController userController = Get.put(UserController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Obx(
        () => Container(
          width: MediaQuery.of(context).size.width * 0.85,
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: TextFormField(
            controller: widget.appController.userNewMessageSearchC.value,
            //keyboardType:TextInputType.number,
            // maxLength: 12,

            decoration: InputDecoration(
              fillColor: Colors.white,
              hintText: "Search Name",
              //  icon: Icon(Icons.phone_iphone),
              labelText: "Send Message to",
              labelStyle: TextStyle(color: KConstant.colorB),
              suffixIcon: Icon(Icons.arrow_forward_ios_rounded,
                  color: KConstant.colorB),
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
            onChanged: (value) {
              filterUsers();
            },
          ),
        ),
      ),
    );
  }

  void filterUsers() {
    final query =
        widget.appController.userNewMessageSearchC.value.text.toLowerCase();
    if (query.isEmpty) {
      // If the search query is empty, show all users
      userController.localList.assignAll(userController.userList);
    } else {
      // Otherwise, filter users based on the query
      final filteredList = userController.userList
          .where((user) => (user.fullName ?? "").toLowerCase().contains(query))
          .toList();
      userController.localList.assignAll(filteredList);
    }
  }
}
