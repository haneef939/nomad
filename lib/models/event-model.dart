import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nomad/models/user-model.dart';

class EventCreateModel {
  final String? eventCreator;
  final String? eventCreatorName;
  final String? eventCreatorImg;
  final String? eventName;
  final String? eventPlace;
  final String? lat;
  final String? lng;
  final int? eventDate;
  final String? eventHour;
  final List<dynamic>? acceptedUsers;
  final List<dynamic>? pendingUsers;
  final String? createdBy;
  final String? updatedBy;

  EventCreateModel({
    this.eventCreator,
    this.eventCreatorName,
    this.eventCreatorImg,
    this.eventName,
    this.eventPlace,
    this.lat,
    this.lng,
    this.eventDate,
    this.eventHour,
    this.acceptedUsers,
    this.pendingUsers,
    this.createdBy,
    this.updatedBy,
  });

  Map<String, dynamic> setDataMap() {
    return {
      "eventCreator": eventCreator,
      "eventCreatorName": eventCreatorName,
      "eventCreatorImg": eventCreatorImg,
      "eventName": eventName,
      "eventPlace": eventPlace,
      "lat": lat,
      "lng": lng,
      "eventDate": eventDate,
      "eventHour": eventHour,
      "acceptedUsers": acceptedUsers,
      "pendingUsers": pendingUsers,
      "createdBy": createdBy,
      "updatedBy": updatedBy,
    };
  }

  Map<String, dynamic> getDataMap(DocumentSnapshot snapshot) {
    return {
      "eventCreator": eventCreator,
      "eventCreatorName": eventCreatorName,
      "eventCreatorImg": eventCreatorImg,
      "eventName": eventName,
      "eventPlace": eventPlace,
      "lat": lat,
      "lng": lng,
      "eventDate": eventDate,
      "eventHour": eventHour,
      "createdBy": createdBy,
      "updatedBy": updatedBy,
    };
  }
}
