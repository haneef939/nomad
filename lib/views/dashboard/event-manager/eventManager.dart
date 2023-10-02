import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nomad/controllers/event_controller.dart';
import 'package:nomad/controllers/fields_controller.dart';
import 'package:nomad/controllers/auth_controller.dart';
import 'package:nomad/views/dashboard/event-manager/viewEvents/viewEvent.dart';
import 'createEvents/createEvent.dart';

class EventManager extends StatefulWidget {
  const EventManager({Key? key}) : super(key: key);

  @override
  _EventManagerState createState() => _EventManagerState();
}

class _EventManagerState extends State<EventManager>
    with TickerProviderStateMixin {
  FieldsController fieldsController = Get.put(FieldsController());
  AuthController authController = Get.put(AuthController());
  EventController eventController = Get.put(EventController());

  TabController? tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      initialIndex: 0,
      length: 2,
      vsync: this,
    );
  }

  @override
  void dispose() {
    tabController?.dispose();
    super.dispose();
  }

  var tabIndex = 0;

  @override
  Widget build(BuildContext context) {
    var childList = [
      const CreateEvent(),
      const ViewEvent(),
    ];

    return DefaultTabController(
      length: 2,
      initialIndex: tabIndex,
      child: Scaffold(
          // appBar: AppBar(),
          body: Container(
            height: 100,
            child: TabBar(
              onTap: (index) {
                setState(() {
                  tabIndex = index;
                });
              },
              labelColor: Color(0xffF9683A),
              indicatorColor: Color(0xffF9683A),
              tabs: <Widget>[
                Tab(
                    text: "Create",
                    icon: Icon(
                      Icons.create,
                    )),
                Tab(
                    text: "Upcomming",
                    icon: Icon(
                      Icons.upcoming,
                    )),
              ],
            ),
          ),
          bottomNavigationBar: SingleChildScrollView(child: childList[tabIndex])),
    );
  }

//   Widget createEventWidget() {
//     return SingleChildScrollView(
//       child: Form(
//         key: eventController.eventKey,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             SizedBox(height: 10),
//             TitleField(
//               controller: eventController.eventName.value,
//               hintText: "Event Name",
//               authController: authController,
//             ),
//             TitleField(
//               controller: eventController.eventPlace.value,
//               hintText: "Event Place",
//               authController: authController,
//             ),
//
//             SizedBox(height: 20),
//             Container(
//               width: 290.w,
//               child: ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                     padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
//                     textStyle:
//                         TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
//                 onPressed: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => PlacePicker(
//                         useCurrentLocation: true,
//                         selectInitialPosition: true,
//                         usePlaceDetailSearch: true,
//                         forceSearchOnZoomChanged: true,
//                         apiKey: eventController.apiKey,
//                         // Put YOUR OWN KEY here.
//                         onPlacePicked: (result) {
//                           eventController.lat = result.geometry.location.lng;
//                           eventController.lng = result.geometry.location.lng;
//
//                           // eventController.eventLatLng = LatLng(
//                           //     result.geometry.location.lat,
//                           //     result.geometry.location.lng);
//                           prr(result.geometry.location.lat);
//                           prr(result.geometry.location.lng);
//                           prr(result.formattedAddress);
//                           eventController.eventLocationName =
//                               result.formattedAddress;
//
//                           Navigator.of(context).pop();
//                         },
//                         initialPosition: eventController.kInitialPosition,
//                         //     useCurrentLocation: true,
//                       ),
//                     ),
//                   );
//                 },
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: <Widget>[
//                     Text(
//                       'Address',
//                       style: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.w700,
//                         color: Colors.white,
//                       ),
//                     ),
//                     Icon(
//                       Icons.location_city,
//                       color: Colors.white,
//                     )
//                   ],
//                 ),
//               ),
//             ),
//
//             // Container(
//             //   decoration: BoxDecoration(
//             //       color: Colors.white,
//             //       borderRadius: BorderRadius.all(Radius.circular(10))),
//             //   child: Padding(
//             //     padding: const EdgeInsets.all(10.0),
//             //     child: KPrimaryButton(
//             //       btnText: "Preview Map",
//             //       onPressed: () {
//             //         Navigator.push(
//             //           context,
//             //           MaterialPageRoute(
//             //             builder: (context) => PlacePicker(
//             //               apiKey: eventController.apiKey,
//             //               // Put YOUR OWN KEY here.
//             //               onPlacePicked: (result) {
//             //                 print(result.adrAddress);
//             //                 Navigator.of(context).pop();
//             //               },
//             //               initialPosition: eventController.kInitialPosition,
//             //               useCurrentLocation: true,
//             //             ),
//             //           ),
//             //         );
//             //       },
//             //     ),
//             //   ),
//             // ),
//             // Padding(
//             //   padding: const EdgeInsets.all(8.0),
//             //   child: Container(
//             //       height: 200,
//             //       width: MediaQuery.of(context).size.width,
//             //       child: EventMap()),
//             // ),
//             DateField(
//               controller: eventController.eventDate.value,
//               hintText: "Event Date",
//               authController: authController,
//             ),
//             HourField(
//               controller: eventController.eventHour.value,
//               hintText: "Event Hour",
//               authController: authController,
//             ),
//             SizedBox(height: 15),
//
//             //  Expanded(child: Container()),
//             Align(
//               alignment: Alignment.bottomCenter,
//               child: Container(
//                 child: Padding(
//                   padding: const EdgeInsets.all(10.0),
//                   child: EventButton(
//                     btnText: "Create Event",
//                     onPressed: () {
//                       if (eventController.eventKey.currentState.validate() &&
//                           eventController.verifyField()) {
//                         eventController.registerEvent();
//                       } else {
//                         showToast("Enter all data properly");
//                       }
//
// //                      Get.to(KMapSample());
//                     },
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

// Widget viewEventWidget() {
//   return SingleChildScrollView(
//     child: Container(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           SizedBox(height: 20),
//           if (eventController.eventCreateList != null)
//             Container(
//                 height: 300.h,
//                 child: ListView.builder(
//                     shrinkWrap: true, //just set this property
//
//                     scrollDirection: Axis.horizontal,
//                     itemCount: eventController.eventCreateList.length,
//                     itemBuilder: (_, int index) {
//                       return GestureDetector(
//                         onTap: () {
//                         },
//                         child: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Container(
//                             decoration: BoxDecoration(
//                               color: Colors.deepOrangeAccent,
//                               border: Border.all(
//                                   color: Colors.deepOrangeAccent, width: 0.2),
//                               borderRadius: BorderRadius.circular(20.sp),
//                             ),
//                             alignment: Alignment.center,
//                             child: Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.center,
//                                     children: [
//                                      FadeInImage.assetNetwork(
//                                         width: 100.w,
//                                           placeholder:  "assets/imgs/woman-5.png",
//                                           image:  eventController.eventCreateList[index]
//                                               .eventCreatorImg,
//                                       )  ,
//                                       SizedBox(width: 20.h),
//                                       Column(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.start,
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           Icon(
//                                             Icons.calendar_today_outlined,
//                                             color: Colors.white,
//                                           ),
//                                           Text(
//                                               eventController
//                                                   .eventCreateList[index]
//                                                   .eventDate,
//                                               style: white15Style()),
//                                           SizedBox(height: 10),
//                                           Icon(
//                                             Icons.access_time,
//                                             color: Colors.white,
//                                           ),
//                                           Text(
//                                               eventController
//                                                   .eventCreateList[index]
//                                                   .eventHour,
//                                               style: white15Style()),
//                                         ],
//                                       )
//                                     ],
//                                   ),
//                                   SizedBox(height: 20.h),
//                                   Text(
//                                       eventController.eventCreateList[index]
//                                           .eventCreatorName,
//                                       style: greyLightStyle()),
//                                   SizedBox(height: 20.h),
//                                   Text(
//                                       eventController
//                                           .eventCreateList[index].eventPlace,
//                                       style: white20Style()),
//                                   SizedBox(height: 20.h),
//                                   Text(
//                                       eventController
//                                           .eventCreateList[index].eventName,
//                                       style: white20Style()),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                       );
//                     })),
//           SizedBox(height: 50),
//           Container(
//             decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                     colors: [KConstant.colorA, KConstant.colorB],
//                     begin: Alignment.topCenter,
//                     end: Alignment.bottomCenter),
//                 borderRadius: BorderRadius.all(Radius.circular(20))),
//             height: 200,
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         "6/12",
//                         style: timeStyle(),
//                       ),
//                       Text(
//                         "Activities\nTracked",
//                         style: white20Style(),
//                       ),
//                       Container(),
//                     ],
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Column(
//                         children: [
//                           Text(
//                             "SEPTEMBER",
//                             style: timeMonthStyle(),
//                           ),
//                           Text(
//                             "Activities pendientes",
//                             style: white20Style(),
//                           ),
//                           SizedBox(height: 10.h),
//                           Row(
//                             children: [
//                               Container(
//                                 decoration: BoxDecoration(
//                                     border: Border.all(
//                                       color: Colors.white,
//                                     ),
//                                     borderRadius: BorderRadius.all(
//                                         Radius.circular(10))),
//                                 child: Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: Text(
//                                     "06",
//                                     style: timeMonthStyle(),
//                                   ),
//                                 ),
//                               ),
//                               SizedBox(width: 10.w),
//                               Container(
//                                 decoration: BoxDecoration(
//                                     border: Border.all(
//                                       color: Colors.white,
//                                     ),
//                                     borderRadius: BorderRadius.all(
//                                         Radius.circular(10))),
//                                 child: Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: Text(
//                                     "06",
//                                     style: timeMonthStyle(),
//                                   ),
//                                 ),
//                               ),
//                               SizedBox(width: 10.w),
//                               Container(
//                                 decoration: BoxDecoration(
//                                     border: Border.all(
//                                       color: Colors.white,
//                                     ),
//                                     borderRadius: BorderRadius.all(
//                                         Radius.circular(10))),
//                                 child: Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: Text(
//                                     "06",
//                                     style: timeMonthStyle(),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           SizedBox(height: 10.h),
//                           Row(
//                             children: [
//                               Container(
//                                 decoration: BoxDecoration(
//                                     border: Border.all(
//                                       color: Colors.white,
//                                     ),
//                                     borderRadius: BorderRadius.all(
//                                         Radius.circular(10))),
//                                 child: Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: Text(
//                                     "06",
//                                     style: timeMonthStyle(),
//                                   ),
//                                 ),
//                               ),
//                               SizedBox(width: 10.w),
//                               Container(
//                                 decoration: BoxDecoration(
//                                     border: Border.all(
//                                       color: Colors.white,
//                                     ),
//                                     borderRadius: BorderRadius.all(
//                                         Radius.circular(10))),
//                                 child: Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: Text(
//                                     "06",
//                                     style: timeMonthStyle(),
//                                   ),
//                                 ),
//                               ),
//                               SizedBox(width: 10.w),
//                               Container(
//                                 decoration: BoxDecoration(
//                                     border: Border.all(
//                                       color: Colors.white,
//                                     ),
//                                     borderRadius: BorderRadius.all(
//                                         Radius.circular(10))),
//                                 child: Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: Text(
//                                     "06",
//                                     style: timeMonthStyle(),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                       Icon(
//                         Icons.arrow_forward_ios_outlined,
//                         color: Colors.white,
//                       )
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           SizedBox(height: 50),
//         ],
//       ),
//     ),
//   );
// }
}
