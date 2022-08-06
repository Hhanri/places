import 'package:flutter/material.dart';
import 'package:places/providers/places_provider.dart';
import 'package:places/screens/add_place_screen.dart';
import 'package:places/screens/place_detail_screen.dart';
import 'package:places/screens/places_list_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PlacesProvider>(
      create: (context) => PlacesProvider(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const PlacesListScreen(),
        routes: {
          AddPlaceScreen.routeName: (context) => const AddPlaceScreen(),
          PlaceDetailScreen.routeName: (conetxt) => const PlaceDetailScreen()
        },

      ),
    );
  }
}