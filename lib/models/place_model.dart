import 'dart:io';

class Location {
  final double latitude;
  final double longitude;
  final String? address;
  Location({required this.latitude, required this.longitude, this.address});
}

class PlaceModel {
  final String id;
  final String title;
  final File image;
  final Location location;
  PlaceModel({required this.id, required this.title, required this.image, required this.location});
}