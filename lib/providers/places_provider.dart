import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:places/helpers/db_helper.dart';
import 'package:places/helpers/location_helper.dart';
import 'package:places/models/place_model.dart';

class PlacesProvider with ChangeNotifier {
  List<PlaceModel> _places = [];

  List<PlaceModel> get places => [..._places];

  PlaceModel findById(String id) => places.firstWhere((element) => element.id == id);

  Future<void> addPlace({required String title, required File image, required PlaceLocation location}) async {
    final String address = await LocationHelper.getPlaceAddress(LatLng(location.latitude, location.longitude));
    final PlaceLocation updatedLocation = PlaceLocation(latitude: location.latitude, longitude: location.longitude, address: address);
    final newPlace = PlaceModel(
      id: DateTime.now().toIso8601String(),
      title: title,
      image: image,
      location: updatedLocation
    );
    _places.add(newPlace);
    notifyListeners();
    DBHelper.insert(table: 'user_places', data: PlaceModel.toMap(newPlace));
  }

  Future<void> fetchPlaces() async {
    final List<Map<String, dynamic>> dataList = await DBHelper.getData('user_places');
    final List<PlaceModel> places = dataList.map((data) => PlaceModel.fromMap(data)).toList();
    _places = [...places];
    notifyListeners();
  }
}