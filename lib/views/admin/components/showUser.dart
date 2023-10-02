import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nomad/controllers/admin_controller.dart';
import 'package:nomad/models/user-model.dart';
import 'package:nomad/widgets/buttons/home_button.dart';
import 'package:nomad/widgets/text-style/text-style.dart';

class ShowUser extends StatefulWidget {
  final UserModel userModel;

  const ShowUser({Key? key, required this.userModel}) : super(key: key);

  @override
  _ShowUserState createState() => _ShowUserState();
}

class _ShowUserState extends State<ShowUser> {
  AdminController adminController = Get.put(AdminController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Show User",
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Name",
                  style: black20Style(),
                ),
                Container(
                  height: 10.h,
                ),
                Text(
                  widget.userModel.fullName ?? "",
                  style: black20Style(),
                ),
              ],
            ),
            Container(
              height: 10.h,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Photo",
                  style: black20Style(),
                ),
                Container(
                  height: 10.h,
                ),
                FadeInImage.assetNetwork(
                  width: 300.w,
                  height: 300.h,
                  placeholder: "assets/imgs/woman-5.png",
                  image: widget.userModel.userImg ?? "",
                  fit: BoxFit.cover,
                ),
              ],
            ),
            Container(
              height: 10.h,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Passport",
                  style: black20Style(),
                ),
                Container(
                  height: 10.h,
                ),
                FadeInImage.assetNetwork(
                  width: 300.w,
                  height: 300.h,
                  placeholder: "assets/imgs/woman-5.png",
                  image: widget.userModel.userPassport ?? "",
                  fit: BoxFit.cover,
                ),
              ],
            ),
            Container(
              height: 10.h,
            ),
            KHomeButton(
                btnText: (!(widget.userModel.isActive ?? false))
                    ? "Enable User"
                    : "Disable User",
                onPressed: () {
                  adminController.updateUserType(
                      isActive: !(widget.userModel.isActive ?? false),
                      userModel: widget.userModel);
                }),
            Container(
              height: 20.h,
            ),
          ],
        ),
      ),
    );
  }
}
