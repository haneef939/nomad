import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nomad/controllers/fields_controller.dart';
import 'package:nomad/controllers/auth_controller.dart';
import 'package:nomad/models/newMessageModel.dart';
import 'package:nomad/models/noti-model.dart';
import 'package:nomad/models/search-model.dart';
import 'package:nomad/utils/constant.dart';
import 'package:nomad/views/dashboard/post-feed/create-post/components/text-fields/privacyField.dart';
import 'package:nomad/widgets/buttons/primary_button.dart';
import 'package:nomad/widgets/text-fields/searchField.dart';
import 'package:nomad/widgets/text-style/text-style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'components/postSuccess.dart';
import 'components/text-fields/locationField.dart';
import 'components/text-fields/titleField.dart';

class CreatePost extends StatefulWidget {
  const CreatePost({Key? key}) : super(key: key);

  @override
  _CreatePostState createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  FieldsController fieldsController = Get.put(FieldsController());

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            indicatorColor: KConstant.colorA,
            onTap: (index) {
              // Tab index when user select it, it start from zero
            },
            tabs: [
              Tab(
                  icon: Icon(Icons.photo_camera_outlined,
                      color: KConstant.colorA)),
              Tab(icon: Icon(Icons.video_library, color: KConstant.colorA)),
            ],
          ),
          title: Text(
            "New Post",
            style: TextStyle(color: Colors.black),
          ),
          elevation: 0,
          leading: IconButton(
            icon: Image.asset(KConstant.backOrangeButton),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: TabBarView(
          children: [
            createPostWidget(),
            createPostWidget(),
          ],
        ),
      ),
    );
  }

  Widget createPostWidget() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [KConstant.colorA, KConstant.colorB],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 50),
          TitleField(
            controller: fieldsController.postTitleC.value,
            hintText: "Title",
          ),
          PrivacyField(
            controller: fieldsController.postPrivacyC.value,
            hintText: "Privacy",
          ),
          LocationField(
            controller: fieldsController.postPrivacyC.value,
            hintText: "Location",
          ),
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Photo",
                  style: white20Style(),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Icon(Icons.add, color: KConstant.colorA),
                  ),
                )
              ],
            ),
          ),
          Expanded(child: Container()),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: KPrimaryButton(
                  btnText: "Preview Post",
                  onPressed: () {
                    Get.to(PostSuccess());
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
