import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rental/app/models/device_model.dart';

String baseUrl =
    'https://geomate.telematics.com.np/api/api.php?api=user&ver=1.0&key=41E4BD6FF302428E467392E35F4D16FA&cmd=USER_GET_OBJECTS';

class RentalDevicesRemoteSource {
  Future<List<DeviceModel>?> getDevices() async {
    var url = Uri.parse(baseUrl);
    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        List<dynamic> list = jsonDecode(response.body);
        return list.map((e) => DeviceModel.fromJson(e)).toList();
      } else {
        return null;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
