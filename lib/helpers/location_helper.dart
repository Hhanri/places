import 'package:places/helpers/keys.dart';

class LocationHelper {
  static String generateLocationPreviewImage({required double latitude, required double longitude}) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longitude&zoom=13&size=600x300&maptype=roadmap&markers=color:green%7Clabel:G%7C$latitude,$longitude&key=$GOOGLE_API_KEY';
  }
}