import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nomad/controllers/admin_controller.dart';
import 'package:nomad/views/dashboard/near-by/nearBy.dart';
import 'package:nomad/widgets/buttons/home_button.dart';
import 'package:nomad/widgets/toast.dart';

import 'notActiveUsers.dart';
//import 'package:mystery_word/views/home/recordData.dart';

class AdminView extends StatefulWidget {
  @override
  _AdminViewState createState() => _AdminViewState();
}

class _AdminViewState extends State<AdminView> {
  Icon icon = Icon(Icons.payment, color: Colors.deepOrange);

  AdminController adminController = Get.put(AdminController());

  @override
  void initState() {
    super.initState();
    getAllUsers();
  }

  getAllUsers() async {
    adminController.showUsersList.value = await adminController.allUsersList();

    adminController.activeUsersList.value = adminController.showUsersList.value
        .where((i) => i.isActive == true)
        .toList();
    adminController.notActiveUsersList.value = adminController
        .showUsersList.value
        .where((i) => i.isActive == false)
        .toList();

    prr("message");
    prr(adminController.activeUsersList.value.length);
    prr(adminController.notActiveUsersList.value.length);
    //setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    Color colorA = Color(0xffFFA270);
    Color colorB = Color(0xff870000);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Admin View",
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 20.h),
                  Text(
                    "User Type",
                    style: TextStyle(
                        fontSize: 25.w,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff890000)),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(),
                    KHomeButton(
                        btnText: "Active Users",
                        onPressed: () {
                          Get.to(NearBy());
                     //     Get.to(ActiveUsers());
                        }),
                    SizedBox(height: 20.h),
                    KHomeButton(
                        btnText: "Not Active Users",
                        onPressed: () {
                          Get.to(NotActiveUsers());
                        }),
                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
