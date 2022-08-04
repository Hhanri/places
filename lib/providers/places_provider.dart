import 'package:flutter/material.dart';
import 'package:places/models/place_model.dart';

class PlacesProvider with ChangeNotifier {
  List<PlaceModel> _places = [];

  List<PlaceModel> get places => [..._places];
}