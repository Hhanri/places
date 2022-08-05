import 'package:flutter/material.dart';
import 'package:places/models/place_model.dart';

class PlacesListViewWidget extends StatelessWidget {
  final List<PlaceModel> places;
  const PlacesListViewWidget({Key? key, required this.places}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: places.length,
      itemBuilder: (context, index) {
        return PlaceListTileWidget(place: places[index]);
      },
    );
  }
}

class PlaceListTileWidget extends StatelessWidget {
  final PlaceModel place;
  const PlaceListTileWidget({Key? key, required this.place}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(backgroundImage: FileImage(place.image),),
      title: Text(place.title),
      onTap: () {},
    );
  }
}
