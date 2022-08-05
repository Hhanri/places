import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:places/helpers/keys.dart';
import 'package:http/http.dart' as http;

class LocationHelper {
  static String generateLocationPreviewImage({required double latitude, required double longitude}) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longitude&zoom=13&size=600x300&maptype=roadmap&markers=color:green%7Clabel:G%7C$latitude,$longitude&key=$GOOGLE_API_KEY';
  }

  static Future<String> getPlaceAddress(LatLng position) async {
    final url = Uri.parse("https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$GOOGLE_API_KEY");
    final http.Response response = await http.get(url);
    final body = jsonDecode(response.body);
    if (body['results'].isEmpty) {
      return "I dont have api authorization...";
    }
    return body['results'][0]['formatted_address'];
  }
}