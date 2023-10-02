import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nomad/controllers/event_controller.dart';
import 'package:nomad/controllers/fields_controller.dart';
import 'package:nomad/controllers/auth_controller.dart';
import 'package:nomad/models/nearby-model.dart';
import 'package:nomad/models/newMessageModel.dart';
import 'package:nomad/models/noti-model.dart';
import 'package:nomad/models/search-model.dart';
import 'package:nomad/models/upcomming-events-model.dart';
import 'package:nomad/utils/constant.dart';
import 'package:nomad/views/dashboard/event-manager/addPeople/addPeople.dart';
import 'package:nomad/views/dashboard/event-manager/components/button/event_button.dart';
import 'package:nomad/views/dashboard/event-manager/components/text-fields/dateField.dart';
import 'package:nomad/views/dashboard/event-manager/components/text-fields/hourField.dart';
import 'package:nomad/views/dashboard/event-manager/components/text-fields/titleField.dart';
import 'package:nomad/views/dashboard/event-manager/statistics/statistics.dart';
import 'package:nomad/views/dashboard/post-feed/create-post/components/text-fields/privacyField.dart';
import 'package:nomad/widgets/buttons/primary_button.dart';
import 'package:nomad/widgets/successMessage.dart';
import 'package:nomad/widgets/text-fields/searchField.dart';
import 'package:nomad/widgets/text-style/text-style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nomad/widgets/toast.dart';

class CreateEvent extends StatefulWidget {
  const CreateEvent({Key? key}) : super(key: key);

  @override
  _CreateEventState createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent>
    with TickerProviderStateMixin {
   EventController eventController = Get.put(EventController());
  FieldsController fieldsController = Get.put(FieldsController());
  AuthController authController = Get.put(AuthController());

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: eventController.eventKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TitleField(
            controller: eventController.eventName.value,
            hintText: "Event Name",
            authController: authController,
          ),
          TitleField(
            controller: eventController.eventPlace.value,
            hintText: "Event Place",
            authController: authController,
          ),

          SizedBox(height: 20),
          Container(
            width: 290.w,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                  textStyle:
                      TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Container()
                      //  PlacePicker(
                      //   useCurrentLocation: true,
                      //   selectInitialPosition: true,
                      //   usePlaceDetailSearch: true,
                      //   forceSearchOnZoomChanged: true,
                      //   apiKey: eventController.apiKey,
                      //   // Put YOUR OWN KEY here.
                      //   onPlacePicked: (result) {
                      //     eventController.lat = result.geometry.location.lng;
                      //     eventController.lng = result.geometry.location.lng;

                      //     // eventController.eventLatLng = LatLng(
                      //     //     result.geometry.location.lat,
                      //     //     result.geometry.location.lng);
                      //     prr(result.geometry.location.lat);
                      //     prr(result.geometry.location.lng);
                      //     prr(result.formattedAddress);
                      //     eventController.eventLocationName =
                      //         result.formattedAddress;

                      //     Navigator.of(context).pop();
                      //   },
                      //   initialPosition: eventController.kInitialPosition,
                      //   //     useCurrentLocation: true,
                      // ),
                      ),
                );
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Address',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  Icon(
                    Icons.location_city,
                    color: Colors.white,
                  )
                ],
              ),
            ),
          ),

          DateField(
            controller: eventController.eventDate.value,
            dateValue: eventController.eventDate1.value,
            hintText: "Event Date",
            authController: authController,
          ),
          HourField(
            controller: eventController.eventHour.value,
            hintText: "Event Hour",
            authController: authController,
          ),
          SizedBox(height: 15),
          Container(
            width: 290.w,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                  textStyle:
                      TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
              onPressed: () {
                Get.to(AddPeople());
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Add People',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  Icon(
                    Icons.person_add_alt_1_sharp,
                    color: Colors.white,
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 15),

          //  Expanded(child: Container()),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 95, vertical: 20),
                  textStyle: const TextStyle(
                      fontSize: 30, fontWeight: FontWeight.bold)),
              child: const Text(
                "Create Event",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                if (eventController.eventKey.currentState!.validate() &&
                    eventController.verifyField()) {
                  eventController.registerEvent();
                } else {
                  showToast("Enter all data properly");
                }

//                      Get.to(KMapSample());
              },
            ),
          ),
        ],
      ),
    );
  }
}
