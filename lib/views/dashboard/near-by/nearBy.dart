import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nomad/controllers/auth_controller.dart';
import 'package:nomad/controllers/home_controller.dart';
import 'package:nomad/views/dashboard/near-by/show-near-by-users/Home.dart';

class NearBy extends StatefulWidget {
  @override
  NearByState createState() => NearByState();
}

class NearByState extends State<NearBy> {
  Completer<GoogleMapController> _controller = Completer();
  HomeController homeController = Get.put(HomeController());
  AuthController authController = Get.put(AuthController());

  @override
  void initState() {
    super.initState();
  }

  double zoomVal = 5.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,

        // leading: IconButton(
        //     icon: Icon(FontAwesomeIcons.arrowLeft),
        //     onPressed: () {
        //       //
        //     }),
        title: Text("NearBy Users"),
        // actions: <Widget>[
        //   IconButton(
        //       icon: Icon(FontAwesomeIcons.search),
        //       onPressed: () {
        //         Get.to(ListNearByUsers());
        //         //
        //       }),
        // ],
      ),
      body: Obx(
        () => (homeController.mapData.value != null &&
                authController.currentPosition != null)
            ? Stack(
                children: <Widget>[
                  _buildGoogleMap(context),
                  _zoomminusfunction(),
                  _zoomplusfunction(),
                  _buildContainer(),
                ],
              )
            : Container(
                child: Center(child: Text("No Nomad Found")),
              ),
      ),
    );
  }

  Widget _zoomminusfunction() {
    return Align(
      alignment: Alignment.topLeft,
      child: IconButton(
          icon: Icon(FontAwesomeIcons.searchMinus, color: Color(0xff870A00)),
          onPressed: () {
            zoomVal--;
            _minus(zoomVal);
          }),
    );
  }

  Widget _zoomplusfunction() {
    return Align(
      alignment: Alignment.topRight,
      child: IconButton(
          icon: Icon(FontAwesomeIcons.searchPlus, color: Color(0xff870A00)),
          onPressed: () {
            zoomVal++;
            _plus(zoomVal);
          }),
    );
  }

  Future<void> _minus(double zoomVal) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(authController.currentPosition?.latitude ?? 0.0,
            authController.currentPosition?.longitude ?? 0.0),
        zoom: zoomVal)));
  }

  Future<void> _plus(double zoomVal) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(authController.currentPosition?.latitude ?? 0,
            authController.currentPosition?.longitude ?? 0),
        zoom: zoomVal)));
  }

  Widget _buildContainer() {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20.0),
        height: 150.0,
        child: Column(
          children: [
            Container(
                height: 130.h,
                child: ListView.builder(
                    shrinkWrap: true, //just set this property

                    scrollDirection: Axis.horizontal,
                    itemCount: homeController.nearByUsers.length,
                    itemBuilder: (_, int index) {
                      return GestureDetector(
                        onTap: () {
                          // Navigator.push(context,
                          //     MaterialPageRoute(builder: (BuildContext context) {
                          //   return allCategory[index].page;
                          // }));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: _boxes(
                              homeController.nearByUsers[index].userImg ?? "",
                              double.parse(
                                  (homeController.nearByUsers[index].lat ??
                                      "0.0")),
                              double.parse(
                                  homeController.nearByUsers[index].lng ??
                                      "0.0"),
                              homeController.nearByUsers[index].fullName ?? "",
                              homeController.nearByUsers[index].country ?? "",
                              homeController.nearByUsers[index].gender ?? ""),
                        ),
                      );
                    })),

            // ListView(
            //   scrollDirection: Axis.horizontal,
            //   children: <Widget>[
            //     SizedBox(width: 10.0),
            //     Padding(
            //       padding: const EdgeInsets.all(8.0),
            //       child: _boxes(
            //           "https://lh5.googleusercontent.com/p/AF1QipO3VPL9m-b355xWeg4MXmOQTauFAEkavSluTtJU=w225-h160-k-no",
            //           40.738380,
            //           -73.988426,
            //           "Gramercy Tavern"),
            //     ),
            //     SizedBox(width: 10.0),
            //     Padding(
            //       padding: const EdgeInsets.all(8.0),
            //       child: _boxes(
            //           "https://lh5.googleusercontent.com/p/AF1QipMKRN-1zTYMUVPrH-CcKzfTo6Nai7wdL7D8PMkt=w340-h160-k-no",
            //           40.761421,
            //           -73.981667,
            //           "Le Bernardin"),
            //     ),
            //     SizedBox(width: 10.0),
            //     Padding(
            //       padding: const EdgeInsets.all(8.0),
            //       child: _boxes(
            //           "https://images.unsplash.com/photo-1504940892017-d23b9053d5d4?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60",
            //           40.732128,
            //           -73.999619,
            //           "Blue Hill"),
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }

  Widget _boxes(
    String _image,
    double lat,
    double long,
    String fullName,
    String country,
    String gender,
  ) {
    return GestureDetector(
      onTap: () {
        _gotoLocation(lat, long);
      },
      child: FittedBox(
        child: Material(
            color: Colors.white,
            elevation: 14.0,
            borderRadius: BorderRadius.circular(24.0),
            shadowColor: Color(0x802196F3),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  width: 180,
                  height: 200,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(24.0),
                    child: Image.network(
                      _image,
                      fit: BoxFit.cover,
                      errorBuilder: (BuildContext context, Object error,
                          StackTrace? stackTrace) {
                        return Image.asset(
                          "assets/imgs/woman-5.png",
                          width: 180,
                          height: 200,
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                  ),
                ),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: myDetailsContainer1(
                        fullName: fullName, country: country),
                  ),
                ),
              ],
            )),
      ),
    );
  }

  Widget myDetailsContainer1({String? fullName, String? country}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Container(
              child: Text(
            fullName ?? "",
            style: const TextStyle(
                color: Color(0xff870A00),
                fontSize: 30.0,
                fontWeight: FontWeight.bold),
          )),
        ),
        SizedBox(height: 5.0),
        // Container(
        //     child: Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //   children: <Widget>[
        //     Container(
        //         child: Text(
        //       "4.1",
        //       style: TextStyle(
        //         color: Colors.black54,
        //         fontSize: 18.0,
        //       ),
        //     )),
        //     Container(
        //       child: Icon(
        //         FontAwesomeIcons.solidStar,
        //         color: Colors.amber,
        //         size: 15.0,
        //       ),
        //     ),
        //     Container(
        //       child: Icon(
        //         FontAwesomeIcons.solidStar,
        //         color: Colors.amber,
        //         size: 15.0,
        //       ),
        //     ),
        //     Container(
        //       child: Icon(
        //         FontAwesomeIcons.solidStar,
        //         color: Colors.amber,
        //         size: 15.0,
        //       ),
        //     ),
        //     Container(
        //       child: Icon(
        //         FontAwesomeIcons.solidStar,
        //         color: Colors.amber,
        //         size: 15.0,
        //       ),
        //     ),
        //     Container(
        //       child: Icon(
        //         FontAwesomeIcons.solidStarHalf,
        //         color: Colors.amber,
        //         size: 15.0,
        //       ),
        //     ),
        //     Container(
        //         child: Text(
        //       "(946)",
        //       style: TextStyle(
        //         color: Colors.black54,
        //         fontSize: 18.0,
        //       ),
        //     )),
        //   ],
        // )),
        // SizedBox(height: 5.0),
        // Container(
        //     child: Text(
        //   "American \u00B7 \u0024\u0024 \u00B7 1.6 mi",
        //   style: TextStyle(
        //     color: Colors.black54,
        //     fontSize: 18.0,
        //   ),
        // )),
        SizedBox(height: 5.0),
        Container(
            child: Text(
          "Country $country",
          style: TextStyle(
              color: Colors.black54,
              fontSize: 18.0,
              fontWeight: FontWeight.bold),
        )),
      ],
    );
  }

  Widget _buildGoogleMap(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
            target: LatLng(authController.currentPosition?.latitude ?? 0,
                authController.currentPosition?.longitude ?? 0),
            zoom: 12),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: Set<Marker>.of(
          homeController.mapData,
        ), // YOUR MARKS IN MAP
        //
      ),
    );
  }

  Future<void> _gotoLocation(double lat, double long) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(lat, long),
      zoom: 15,
      tilt: 50.0,
      bearing: 45.0,
    )));
  }
}

Marker gramercyMarker = Marker(
  markerId: MarkerId('gramercy'),
  position: LatLng(40.738380, -73.988426),
  infoWindow: InfoWindow(title: 'Gramercy Tavern'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);

Marker bernardinMarker = Marker(
  markerId: MarkerId('bernardin'),
  position: LatLng(40.761421, -73.981667),
  infoWindow: InfoWindow(title: 'Le Bernardin'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);

Marker blueMarker = Marker(
  markerId: MarkerId('bluehill'),
  position: LatLng(40.732128, -73.999619),
  infoWindow: InfoWindow(title: 'Blue Hill'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);

//New York Marker

Marker newyork1Marker = Marker(
  markerId: MarkerId('newyork1'),
  position: LatLng(40.742451, -74.005959),
  infoWindow: InfoWindow(title: 'Los Tacos'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker newyork2Marker = Marker(
  markerId: MarkerId('newyork2'),
  position: LatLng(40.729640, -73.983510),
  infoWindow: InfoWindow(title: 'Tree Bistro'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker newyork3Marker = Marker(
  markerId: MarkerId('newyork3'),
  position: LatLng(40.719109, -74.000183),
  infoWindow: InfoWindow(title: 'Le Coucou'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
