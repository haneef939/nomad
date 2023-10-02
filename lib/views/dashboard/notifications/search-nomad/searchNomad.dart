import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nomad/controllers/auth_controller.dart';
import 'package:nomad/models/noti-model.dart';
import 'package:nomad/models/search-model.dart';
import 'package:nomad/utils/constant.dart';
import 'package:nomad/widgets/text-fields/searchField.dart';
import 'package:nomad/widgets/text-style/text-style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchNomad extends StatefulWidget {
  const SearchNomad({Key? key}) : super(key: key);

  @override
  _SearchNomadState createState() => _SearchNomadState();
}

class _SearchNomadState extends State<SearchNomad> {
  AuthController appController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Image.asset(KConstant.backOrangeButton),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          "Search",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SearchField(appController: appController),
                Text("Cancel", style: orangeBoldColorBStyle())
              ],
            ),
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Recent Searches",
                  style: blackBoldSmallStyle(),
                ),
                Text(
                  "View in the map",
                  style: orangeBoldSmall15Style(),
                ),
              ],
            ),
            SizedBox(height: 20.h),
            Container(
                child: Expanded(
              child: ListView.separated(
                  shrinkWrap: true,
                  //just set this property
                  separatorBuilder: (context, index) {
                    return Divider();
                  },
                  scrollDirection: Axis.vertical,
                  itemCount: allRecentSearch.length,
                  itemBuilder: (_, int index) {
                    return GestureDetector(
                      onTap: () {
                        // Navigator.push(context,
                        //     MaterialPageRoute(builder: (BuildContext context) {
                        //   return allCategory[index].page;
                        // }));
                      },
                      child: Container(
                        // decoration: BoxDecoration(
                        //   border: Border.all(color: Colors.black, width: 0.2),
                        //   borderRadius: BorderRadius.circular(20.sp),
                        // ),
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                      child: Image.asset(
                                          allRecentSearch[index].image ?? "")),
                                  SizedBox(width: 10.w),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            allRecentSearch[index].personName ?? "",
                                            style: smallSizeStyle(),
                                          ),
                                          SizedBox(width: 10.w),
                                        ],
                                      ),
                                      SizedBox(height: 10.h),
                                    ],
                                  ),
                                  Container(),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            )),
          ],
        ),
      ),
    );
  }
}
