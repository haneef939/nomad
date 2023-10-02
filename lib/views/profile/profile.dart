import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nomad/controllers/user_controller.dart';
import 'package:nomad/models/show-events-model.dart';
import 'package:nomad/models/nearby-model.dart';
import 'package:nomad/utils/constant.dart';
import 'package:nomad/views/initial-screens/add-profile-pic/profilePic.dart';
import 'package:nomad/views/initial-screens/login/login.dart';
import 'package:nomad/views/initial-screens/otp-screen/otpSecreen.dart';
import 'package:nomad/views/initial-screens/scan-passport/fill-in-data/fillData.dart';
import 'package:nomad/views/initial-screens/scan-passport/scanPassport.dart';
import 'package:nomad/views/initial-screens/terms-of-service/termsOfService.dart';
import 'package:nomad/views/payment-section/subscription/activaSubscription.dart';
import 'package:nomad/views/payment-section/success/paymentSuccess.dart';
import 'package:nomad/widgets/text-style/text-style.dart';
import '../../controllers/event_controller.dart';
import '../../models/event-model.dart';
import 'dialog/logoutDialog.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    super.initState();
  }

  EventController eventController = Get.put(EventController());
  UserController userController = Get.put(UserController());
  int getSublistLengthForUser(List<EventCreateModel> mainList, String userId) {
    int len = 0;
    for (var sublist in mainList) {
      if ((sublist.acceptedUsers ?? []).contains(userId)) {
        len = len + 1;
      }
    }
    // Return a default value or handle the case where the user is not found.
    return len;
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    Color colorA = Color(0xffF9683A);
    Color colorB = Color(0xff870A00);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black12,
        leading: IconButton(
          icon: Image.asset(KConstant.backWhiteButton),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text("Profile"),
        actions: [
          InkWell(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return LogOutDialogBox(
                      title: "Sign Out",
                      descriptions: "Are you sure you wish to sign out?",
                      text: "Yes",
                    );
                  });
            },
            child: Center(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Sign out",
                style: orangeBoldSmallStyle(),
              ),
            )),
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 50),
              Card(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 15.w),
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              (userController.userModel.userImg != null)
                                  ? FadeInImage.assetNetwork(
                                      width: 100.w,
                                      height: 100.h,
                                      placeholder: "assets/imgs/woman-5.png",
                                      image: userController.userModel.userImg ??
                                          "",
                                      fit: BoxFit.fill,
                                    )
                                  : InkWell(
                                      onTap: () => Get.to(Profile()),
                                      child: Image.asset(
                                        "assets/imgs/home/profile_img.png",
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(userController.userModel.fullName ?? "",
                                  style: greetingsStyle()),
                              SizedBox(height: 5.h),
                              Text(userController.userModel.country ?? "",
                                  style: greyLightStyle()),
                              SizedBox(height: 10.h),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Product Designer with 10+ years of experience in UI/UX field and love hoverboard",
                                  style: greyLightLargeStyle(),
                                ),
                              ),
                              SizedBox(height: 10.h),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                          "${getSublistLengthForUser(eventController.eventsDisplayList ?? [], userController.userModel.userId ?? "")}",
                                          style: orangeBoldStyle()),
                                      Text("Eventos",
                                          style: greyLightLargeStyle()),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text("15", style: orangeBoldStyle()),
                                      Text("Friends",
                                          style: greyLightLargeStyle()),
                                    ],
                                  ),
                                  // Column(
                                  //   children: [
                                  //     Text("15", style: orangeBoldStyle()),
                                  //     Text("Eventos",
                                  //         style: greyLightLargeStyle()),
                                  //   ],
                                  // ),
                                ],
                              ),
                              SizedBox(height: 10.h),
                              // Text("Friends With",
                              //     style: greyLightLargeStyle()),
                              // SizedBox(height: 10.h),
                              // Row(
                              //   children: [
                              //     imgDisplay(),
                              //     imgDisplay(),
                              //     imgDisplay()
                              //   ],
                              // ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 50),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                                width: 100.w,
                                height: 100.w,
                                decoration: const BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: AssetImage(
                                            "assets/imgs/feed/fed_mask.png")))),
                            Container(
                              width: MediaQuery.of(context).size.width / 2.2,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Live life to the fullest and enjoy full freedom",
                                      style: smallSizeStyle(),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      "Yesterday at 10:47 AM",
                                      style: greyLightStyle(),
                                    ),
                                    Container(),
                                  ],
                                ),
                              ),
                            ),
                            const Icon(
                              Icons.arrow_forward_ios_rounded,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget imgDisplay() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          width: 50.w,
          height: 50.w,
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage("assets/imgs/home/profile_img.png")))),
    );
  }

  viewFilter({
    required BuildContext context,
  }) {
    return showDialog(
        context: context,
        builder: (BuildContext context) => viewFilterDialog(context));
  }

  Dialog viewFilterDialog(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      //this right here
      child: Container(
        padding: const EdgeInsets.all(16.0),
        height: 200.h,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      decoration: BoxDecoration(
                          color: Colors.deepOrangeAccent,
                          border: Border.all(
                            color: Colors.deepOrangeAccent,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.notifications_active_outlined,
                          color: Colors.white,
                        ),
                      )),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "1 hour left",
                      style: greetingsStyle(),
                    ),
                    Text(
                      "\"We are going to see Madrid from above\"",
                      overflow: TextOverflow.ellipsis,
                      style: labelsStyle(),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
