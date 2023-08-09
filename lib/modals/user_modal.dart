import 'dart:convert';

import 'package:untitled/modals/device_profile.dart';

class UserModal {
  double? latitude;
  double? longitude;
  DeviceProfile? deviceProfile;

  UserModal({this.latitude, this.longitude, this.deviceProfile});

  UserModal.fromMap(Map<String, dynamic> res)
      : latitude = double.parse(res["latitude"].toString()),
        longitude = double.parse(res["longitude"].toString()),
        deviceProfile = DeviceProfile.fromMap(jsonDecode(res["deviceProfile"]));

  Map<String, Object?> toMap() {
    return {
      'latitude': latitude,
      'longitude': longitude,
      'deviceProfile': jsonEncode(deviceProfile?.toMap()),
    };
  }
}
