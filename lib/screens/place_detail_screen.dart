import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:places/models/place_model.dart';
import 'package:places/providers/places_provider.dart';
import 'package:places/screens/map_screen.dart';
import 'package:provider/provider.dart';

class PlaceDetailScreen extends StatelessWidget {
  const PlaceDetailScreen({Key? key}) : super(key: key);

  static const String routeName = "/placeDetailRoute";

  @override
  Widget build(BuildContext context) {
    final String id = ModalRoute.of(context)!.settings.arguments as String;
    final PlaceModel selectedPlace = context.read<PlacesProvider>().findById(id);

    void openMap() {
      Navigator.of(context).push(
        MaterialPageRoute(
          fullscreenDialog: true,
          builder: (context) => MapScreen(initialCameraPosition: selectedPlace.location, isSelecting: false,)
        )
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(selectedPlace.title),),
      body: Column(
        children: [
          SizedBox(
            height: 250,
            width: double.infinity,
            child: Image.file(
              selectedPlace.image,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          const SizedBox(height: 10,),
          Text(
            selectedPlace.location.address!,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.grey
            ),
          ),
          const SizedBox(height: 10,),
          TextButton(
            style: TextButton.styleFrom(
              textStyle: TextStyle(
                color: Theme.of(context).primaryColor
              )
            ),
            onPressed: openMap,
            child: const Text("View on Map")
          )
        ],
      ),
    );
  }
}
