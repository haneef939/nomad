import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nomad/controllers/event_controller.dart';
import 'package:nomad/utils/constant.dart';
import 'package:intl/intl.dart';
import 'package:nomad/widgets/text-style/text-style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ViewEvent extends StatefulWidget {
  const ViewEvent({Key? key}) : super(key: key);

  @override
  _ViewEventState createState() => _ViewEventState();
}

class _ViewEventState extends State<ViewEvent> with TickerProviderStateMixin {
  EventController eventController = Get.put(EventController());

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Obx(
        () => Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              (eventController.eventsDisplayList.length != 0)
                  ? Container(
                      height: 300.h,
                      child: ListView.builder(
                          shrinkWrap: true, //just set this property
                          scrollDirection: Axis.horizontal,
                          itemCount: eventController.eventsDisplayList.length,
                          itemBuilder: (_, int index) {
                            return GestureDetector(
                              onTap: () {},
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.deepOrangeAccent,
                                    border: Border.all(
                                        color: Colors.deepOrangeAccent,
                                        width: 0.2),
                                    borderRadius: BorderRadius.circular(20.sp),
                                  ),
                                  alignment: Alignment.center,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image.network(
                                              eventController
                                                      .eventsDisplayList[index]
                                                      .eventCreatorImg ??
                                                  "",
                                              width: 100.w,
                                              height: 100.h,
                                              fit: BoxFit.cover,
                                              errorBuilder:
                                                  (BuildContext context,
                                                      Object error,
                                                      StackTrace? stackTrace) {
                                                return Image.asset(
                                                  "assets/imgs/woman-5.png",
                                                  width: 100.w,
                                                  height: 100.h,
                                                  fit: BoxFit.cover,
                                                );
                                              },
                                            ),
                                            // FadeInImage.assetNetwork(
                                            //   width: 100.w,
                                            //   height: 100.h,
                                            //   fit: BoxFit.cover,
                                            //   placeholder:
                                            //       "assets/imgs/woman-5.png",
                                            //   image: eventController
                                            //           .eventsDisplayList[index]
                                            //           .eventCreatorImg ??
                                            //       "",
                                            // ),
                                            SizedBox(width: 20.h),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Icon(
                                                  Icons.calendar_today_outlined,
                                                  color: Colors.white,
                                                ),
                                                Text(
                                                    DateFormat(
                                                            'dd-MM-yyyy HH:mm:ss')
                                                        .format(DateTime
                                                            .fromMillisecondsSinceEpoch(
                                                                eventController
                                                                        .eventsDisplayList[
                                                                            index]
                                                                        .eventDate ??
                                                                    0)),
                                                    style: white15Style()),
                                                SizedBox(height: 10),
                                                Icon(
                                                  Icons.access_time,
                                                  color: Colors.white,
                                                ),
                                                Text(
                                                    eventController
                                                            .eventsDisplayList[
                                                                index]
                                                            .eventHour ??
                                                        "",
                                                    style: white15Style()),
                                              ],
                                            )
                                          ],
                                        ),
                                        SizedBox(height: 20.h),
                                        Text(
                                            eventController
                                                    .eventsDisplayList[index]
                                                    .eventCreatorName ??
                                                "",
                                            style: greyLightStyle()),
                                        SizedBox(height: 20.h),
                                        Text(
                                            eventController
                                                    .eventsDisplayList[index]
                                                    .eventPlace ??
                                                "",
                                            style: white20Style()),
                                        SizedBox(height: 20.h),
                                        Text(
                                            eventController
                                                    .eventsDisplayList[index]
                                                    .eventName ??
                                                "",
                                            style: white20Style()),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }))
                  : Center(
                      child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Your next events will show up here"),
                    )),
              SizedBox(height: 50),

              //** Show the events that user is subscribed
              Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [KConstant.colorA, KConstant.colorB],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                height: 200,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${eventController.totalEventDoneThisMonth}/${eventController.totalEventThisMonth}",
                            style: timeStyle(),
                          ),
                          Text(
                            "Activities\nTracked",
                            style: white20Style(),
                          ),
                          Container(),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              SizedBox(height: 10.h),

                              // Text(
                              //   "SEPTEMBER",
                              //   style: timeMonthStyle(),
                              // ),
                              Text(
                                "Activities pendientes",
                                style: white20Style(),
                              ),
                              SizedBox(height: 10.h),
                              Container(
                                height: 130,
                                width: 200,
                                child:eventController
                                            .numberOfpendingEventInThisMonth
                                            .isEmpty
                                        ? Center(
                                            child: Text(
                                            "No Pending Activities Found",
                                            textAlign: TextAlign.center,
                                            style: white15Style(),
                                          ))
                                        : GridView.builder(
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount:
                                        3, // Number of columns in the grid
                                    mainAxisSpacing:
                                        16.0, // Spacing between rows
                                    crossAxisSpacing:
                                        16.0, // Spacing between columns
                                  ),
                                  itemCount: eventController
                                      .numberOfpendingEventInThisMonth
                                      .length, // Number of items in the grid
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Center(
                                      child: Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                              color: Colors.white,
                                            ),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10.r))),
                                        child: Padding(
                                          padding: const EdgeInsets.all(9.0),
                                          child: Text(
                                            "${DateTime.fromMillisecondsSinceEpoch(eventController.numberOfpendingEventInThisMonth[index].eventDate!).day}",
                                            style: timeMonthStyle(),
                                          ),
                                        ),
                                      ),
                                      //  Text('Item $index',
                                      //     style: TextStyle(
                                      //         color: Colors.white)),
                                    );
                                  },
                                ),
                              ),
                              //     Row(
                              //       children: [
                              //         Container(
                              //           decoration: BoxDecoration(
                              //               border: Border.all(
                              //                 color: Colors.white,
                              //               ),
                              //               borderRadius: BorderRadius.all(
                              //                   Radius.circular(10.r))),
                              //           child: Padding(
                              //             padding: const EdgeInsets.all(8.0),
                              //             child: Text(
                              //               "06",
                              //               style: timeMonthStyle(),
                              //             ),
                              //           ),
                              //         ),
                              //         SizedBox(width: 10.w),
                              //         Container(
                              //           decoration: BoxDecoration(
                              //               border: Border.all(
                              //                 color: Colors.white,
                              //               ),
                              //               borderRadius: BorderRadius.all(
                              //                   Radius.circular(10.r))),
                              //           child: Padding(
                              //             padding: const EdgeInsets.all(8.0),
                              //             child: Text(
                              //               "06",
                              //               style: timeMonthStyle(),
                              //             ),
                              //           ),
                              //         ),
                              //         SizedBox(width: 10.w),
                              //         Container(
                              //           decoration: BoxDecoration(
                              //               border: Border.all(
                              //                 color: Colors.white,
                              //               ),
                              //               borderRadius: BorderRadius.all(
                              //                   Radius.circular(10.r))),
                              //           child: Padding(
                              //             padding: const EdgeInsets.all(8.0),
                              //             child: Text(
                              //               "06",
                              //               style: timeMonthStyle(),
                              //             ),
                              //           ),
                              //         ),
                              //       ],
                              //     ),
                              //     SizedBox(height: 10.h),
                              //     Row(
                              //       children: [
                              //         Container(
                              //           decoration: BoxDecoration(
                              //               border: Border.all(
                              //                 color: Colors.white,
                              //               ),
                              //               borderRadius: BorderRadius.all(
                              //                   Radius.circular(10.r))),
                              //           child: Padding(
                              //             padding: const EdgeInsets.all(8.0),
                              //             child: Text(
                              //               "06",
                              //               style: timeMonthStyle(),
                              //             ),
                              //           ),
                              //         ),
                              //         SizedBox(width: 10.w),
                              //         Container(
                              //           decoration: BoxDecoration(
                              //               border: Border.all(
                              //                 color: Colors.white,
                              //               ),
                              //               borderRadius: BorderRadius.all(
                              //                   Radius.circular(10.r))),
                              //           child: Padding(
                              //             padding: const EdgeInsets.all(8.0),
                              //             child: Text(
                              //               "06",
                              //               style: timeMonthStyle(),
                              //             ),
                              //           ),
                              //         ),
                              //         SizedBox(width: 10.w),
                              //         Container(
                              //           decoration: BoxDecoration(
                              //               border: Border.all(
                              //                 color: Colors.white,
                              //               ),
                              //               borderRadius: BorderRadius.all(
                              //                   Radius.circular(10.r))),
                              //           child: Padding(
                              //             padding: const EdgeInsets.all(8.0),
                              //             child: Text(
                              //               "06",
                              //               style: timeMonthStyle(),
                              //             ),
                              //           ),
                              //         ),
                              //       ],
                              //     ),
                            ],
                          ),

                          // Icon(
                          //   Icons.arrow_forward_ios_outlined,
                          //   color: Colors.white,
                          // )
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // Container(
              //   decoration: BoxDecoration(
              //       gradient: LinearGradient(
              //           colors: [KConstant.colorA, KConstant.colorB],
              //           begin: Alignment.topCenter,
              //           end: Alignment.bottomCenter),
              //       borderRadius: BorderRadius.all(Radius.circular(20))),
              //   height: 200,
              //   child: Padding(
              //     padding: const EdgeInsets.all(8.0),
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //       crossAxisAlignment: CrossAxisAlignment.center,
              //       children: [
              //         Column(
              //           mainAxisAlignment: MainAxisAlignment.center,
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           children: [
              //             Text(
              //               "6/12",
              //               style: timeStyle(),
              //             ),
              //             Text(
              //               "Activities\nTracked",
              //               style: white20Style(),
              //             ),
              //             Container(),
              //           ],
              //         ),
              //         Row(
              //           mainAxisAlignment: MainAxisAlignment.start,
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           children: [
              //             Column(
              //               children: [
              //                 SizedBox(height: 10.h),

              //                 // Text(
              //                 //   "SEPTEMBER",
              //                 //   style: timeMonthStyle(),
              //                 // ),
              //                 Text(
              //                   "Activities pendientes",
              //                   style: white20Style(),
              //                 ),
              //                 SizedBox(height: 10.h),
              //                 Row(
              //                   children: [
              //                     Container(
              //                       decoration: BoxDecoration(
              //                           border: Border.all(
              //                             color: Colors.white,
              //                           ),
              //                           borderRadius: BorderRadius.all(
              //                               Radius.circular(10))),
              //                       child: Padding(
              //                         padding: const EdgeInsets.all(8.0),
              //                         child: Text(
              //                           "06",
              //                           style: timeMonthStyle(),
              //                         ),
              //                       ),
              //                     ),
              //                     SizedBox(width: 10.w),
              //                     Container(
              //                       decoration: BoxDecoration(
              //                           border: Border.all(
              //                             color: Colors.white,
              //                           ),
              //                           borderRadius: BorderRadius.all(
              //                               Radius.circular(10))),
              //                       child: Padding(
              //                         padding: const EdgeInsets.all(8.0),
              //                         child: Text(
              //                           "06",
              //                           style: timeMonthStyle(),
              //                         ),
              //                       ),
              //                     ),
              //                     SizedBox(width: 10.w),
              //                     Container(
              //                       decoration: BoxDecoration(
              //                           border: Border.all(
              //                             color: Colors.white,
              //                           ),
              //                           borderRadius: BorderRadius.all(
              //                               Radius.circular(10))),
              //                       child: Padding(
              //                         padding: const EdgeInsets.all(8.0),
              //                         child: Text(
              //                           "06",
              //                           style: timeMonthStyle(),
              //                         ),
              //                       ),
              //                     ),
              //                   ],
              //                 ),
              //                 SizedBox(height: 10.h),
              //                 Row(
              //                   children: [
              //                     Container(
              //                       decoration: BoxDecoration(
              //                           border: Border.all(
              //                             color: Colors.white,
              //                           ),
              //                           borderRadius: BorderRadius.all(
              //                               Radius.circular(10))),
              //                       child: Padding(
              //                         padding: const EdgeInsets.all(8.0),
              //                         child: Text(
              //                           "06",
              //                           style: timeMonthStyle(),
              //                         ),
              //                       ),
              //                     ),
              //                     SizedBox(width: 10.w),
              //                     Container(
              //                       decoration: BoxDecoration(
              //                           border: Border.all(
              //                             color: Colors.white,
              //                           ),
              //                           borderRadius: BorderRadius.all(
              //                               Radius.circular(10))),
              //                       child: Padding(
              //                         padding: const EdgeInsets.all(8.0),
              //                         child: Text(
              //                           "06",
              //                           style: timeMonthStyle(),
              //                         ),
              //                       ),
              //                     ),
              //                     SizedBox(width: 10.w),
              //                     Container(
              //                       decoration: BoxDecoration(
              //                           border: Border.all(
              //                             color: Colors.white,
              //                           ),
              //                           borderRadius: BorderRadius.all(
              //                               Radius.circular(10))),
              //                       child: Padding(
              //                         padding: const EdgeInsets.all(8.0),
              //                         child: Text(
              //                           "06",
              //                           style: timeMonthStyle(),
              //                         ),
              //                       ),
              //                     ),
              //                   ],
              //                 ),
              //               ],
              //             ),
              //             // Icon(
              //             //   Icons.arrow_forward_ios_outlined,
              //             //   color: Colors.white,
              //             // )
              //           ],
              //         ),
              //       ],
              //     ),
              //   ),
              // ),

              SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
