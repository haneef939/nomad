import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionHandler {
  checkLocation() async {
    Map<Permission, PermissionStatus>? statuses;

    if (await Permission.location.request().isGranted) {
      // Either the permission was already granted before or the user just granted it.
    } else {
      // You can request multiple permissions at once.
      statuses = await [
        Permission.location,
      ].request();

      checkLocation();
    }

    print(statuses?[Permission.location]);
  }
}
