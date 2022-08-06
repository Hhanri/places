import 'dart:io';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlaceLocation {
  final double latitude;
  final double longitude;
  final String? address;
  const PlaceLocation({required this.latitude, required this.longitude, this.address});
  static LatLng toLatLng(PlaceLocation position) => LatLng(position.latitude, position.longitude);
}

class PlaceModel {
  final String id;
  final String title;
  final File image;
  final PlaceLocation location;
  PlaceModel({required this.id, required this.title, required this.image, required this.location});

  static Map<String, dynamic> toMap(PlaceModel place) {
    return {
      'id': place.id,
      'title': place.title,
      'image': place.image.path,
      'loc_lat': place.location.latitude,
      'loc_lng': place.location.longitude,
      'address': place.location.address
    };
  }

  factory PlaceModel.fromMap(Map<String, dynamic> data) {
    return PlaceModel(
      id: data['id'],
      title: data['title'],
      image: File(data['image']),
      location: PlaceLocation(latitude: data['loc_lat'], longitude: data['loc_lng'], address: data['address'])
    );
  }

}