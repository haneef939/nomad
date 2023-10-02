import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nomad/controllers/admin_controller.dart';
import 'package:nomad/controllers/auth_controller.dart';
import 'package:nomad/utils/constant.dart';
import 'package:nomad/views/dashboard/dashboard.dart';
import 'package:nomad/views/initial-screens/forget-password/forgetPassword.dart';
import 'package:nomad/widgets/buttons/home_button.dart';
import 'package:nomad/widgets/buttons/primary_button.dart';
import 'package:nomad/widgets/gradientWidget.dart';
import 'package:nomad/widgets/text-fields/emailField.dart';
import 'package:nomad/widgets/text-fields/paswrdField.dart';
import 'package:nomad/widgets/text-style/text-style.dart';
import 'package:nomad/widgets/toast.dart';

import 'components/showUser.dart';
//import 'package:mystery_word/views/home/recordData.dart';

class ActiveUsers extends StatefulWidget {
  @override
  _ActiveUsersState createState() => _ActiveUsersState();
}

class _ActiveUsersState extends State<ActiveUsers> {
  Icon icon = Icon(Icons.payment, color: Colors.deepOrange);

  AdminController adminController = Get.put(AdminController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Active Users",
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [userList()],
        ),
      ),
    );
  }

  userList() {
    if (adminController.activeUsersList != null) {
      return ListView.builder(
          shrinkWrap: true, //just set this property
          scrollDirection: Axis.vertical,
          itemCount: adminController.activeUsersList.length,
          itemBuilder: (_, int index) {
            return GestureDetector(
              onTap: () {
                Get.to(ShowUser(
                  userModel: adminController.activeUsersList[index],
                ));
                //  onTapList(index: index,userModel: adminController.activeUsersList[index]);
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(width: 0.2),
                    borderRadius: BorderRadius.circular(20.sp),
                  ),
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            FadeInImage.assetNetwork(
                              width: 100.w,
                              height: 100.h,
                              placeholder: "assets/imgs/woman-5.png",
                              image: adminController
                                      .activeUsersList[index].userImg ??
                                  "",
                              fit: BoxFit.cover,
                            ),
                            SizedBox(width: 20.h),
                            Text(
                                adminController
                                        .activeUsersList[index].fullName ??
                                    "",
                                style: black15Style()),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          });
    } else {
      return Container();
    }
  }
}
