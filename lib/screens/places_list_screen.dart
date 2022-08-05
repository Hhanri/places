import 'package:flutter/material.dart';
import 'package:places/providers/places_provider.dart';
import 'package:places/screens/add_place_screen.dart';
import 'package:places/widgets/places_list_view_widget.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your places"),
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context).pushNamed(AddPlaceScreen.routeName),
            icon: const Icon(Icons.add)
          )
        ],
      ),
      body: Consumer<PlacesProvider>(
        builder: (context, places, child) {
          if (places.places.isEmpty) return child!;
          return PlacesListViewWidget(places: places.places);
        },
        child: const Center(child: Text("Got no places yet"),),
      ),
    );
  }
}
