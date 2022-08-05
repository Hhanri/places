import 'dart:io';

import 'package:flutter/material.dart';
import 'package:places/models/place_model.dart';

class PlacesProvider with ChangeNotifier {
  List<PlaceModel> _places = [];

  List<PlaceModel> get places => [..._places];

  void addPlace({required String title, required File image}) {
    final newPlace = PlaceModel(
      id: DateTime.now().toIso8601String(),
      title: title,
      image: image,
    );
    _places.add(newPlace);
    notifyListeners();
  }
}