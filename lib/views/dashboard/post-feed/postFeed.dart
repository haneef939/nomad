import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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

import 'create-post/createPost.dart';
import 'dialog/dialog.dart';
//import 'package:mystery_word/views/home/recordData.dart';

class PostFeed extends StatefulWidget {
  @override
  _PostFeedState createState() => _PostFeedState();
}

class _PostFeedState extends State<PostFeed> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    Color colorA = Color(0xffF9683A);
    Color colorB = Color(0xff870A00);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Text(
                "Feed",
                style: greyBoldLargeStyle(),
              ),
              SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: 6,
                  itemBuilder: (context, i) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 15.w),
                      child: Card(
                        child: Container(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                            width: 60.w,
                                            height: 60.w,
                                            decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                    fit: BoxFit.fill,
                                                    image: AssetImage(
                                                        "assets/imgs/home/profile_img.png")))),
                                        SizedBox(width: 10),
                                        Column(
                                          children: [
                                            Text(
                                              "Alan Demott",
                                              style: greyBoldStyle(),
                                            ),
                                            Text(
                                              "5 mins ago",
                                            ),
                                            Container(),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Icon(Icons.share, color: Colors.grey),
                                        Container(),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Image.asset(
                                "assets/imgs/feed/feed_img.png",
                                fit: BoxFit.fill,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Image.asset(
                                        "assets/imgs/feed/icon_heart.png"),
                                    Icon(Icons.message_sharp,
                                        color: Colors.grey),
                                  ],
                                ),
                              ),
                              SizedBox(height: 10),
                              Divider(height: 1, color: Colors.grey),
                              SizedBox(height: 10),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Going on a trip to America, looking for someone to join me on this epic journey through American Lifestyle",
                                  style: greyLightStyle(),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(CreatePost());
        },
        child: Icon(Icons.add, color: Colors.white, size: 29),
        backgroundColor: KConstant.colorB,
        tooltip: 'Capture Picture',
        elevation: 5,
        splashColor: Colors.grey,
      ),
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
