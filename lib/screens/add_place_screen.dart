import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:places/models/place_model.dart';
import 'package:places/providers/places_provider.dart';
import 'package:places/widgets/image_input_widget.dart';
import 'package:places/widgets/location_input_widget.dart';
import 'package:provider/provider.dart';

class AddPlaceScreen extends StatefulWidget {
  const AddPlaceScreen({Key? key}) : super(key: key);

  static const String routeName = "/addPlace";

  @override
  State<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {

  final TextEditingController _titleController = TextEditingController();
  File? _pickedImage;
  PlaceLocation? _pickedLocation;

  void _selectImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  void _selectLocation(LatLng position) {
    _pickedLocation = PlaceLocation(latitude: position.latitude, longitude: position.longitude);
  }

  void _savePlace() {
    if (_titleController.text.isEmpty || _pickedImage == null || _pickedLocation == null) return;
    context.read<PlacesProvider>().addPlace(title: _titleController.text, image: _pickedImage!, location: _pickedLocation!);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add your place"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextField(
                      controller: _titleController,
                      decoration: const InputDecoration(labelText: 'Title'),
                    ),
                    const SizedBox(height: 10),
                    Container(),
                    ImageInputWidget(onSelectImage: _selectImage),
                    const SizedBox(height: 10,),
                    LocationInputWidget(onSelectLocation: _selectLocation,)
                  ],
                ),
              ),
            )
          ),
          ElevatedButton.icon(
            onPressed: _savePlace,
            style: ElevatedButton.styleFrom(
              elevation: 0,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap
            ),
            icon: const Icon(Icons.add),
            label: const Text("Submit")),
        ],
      ),
    );
  }
}
