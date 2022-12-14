import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:places/helpers/location_helper.dart';
import 'package:places/screens/map_screen.dart';

class LocationInputWidget extends StatefulWidget {
  final Function(LatLng) onSelectLocation;
  const LocationInputWidget({Key? key, required this.onSelectLocation}) : super(key: key);

  @override
  State<LocationInputWidget> createState() => _LocationInputWidgetState();
}

class _LocationInputWidgetState extends State<LocationInputWidget> {

  String? _previewImageUrl;

  void _showPreview(LatLng location) {
    try {
      final staticMapUrl = LocationHelper.generateLocationPreviewImage(latitude: location.latitude, longitude: location.longitude);
      setState(() {
        _previewImageUrl = staticMapUrl;
      });
      widget.onSelectLocation(LatLng(location.latitude, location.longitude));
    } catch(error) {
      print(error);
    }
  }

  Future<void> _getCurrentLocation() async {
    final LocationData location = await Location().getLocation();
    _showPreview(LatLng(location.latitude!, location.longitude!));
  }

  Future<void> _selectFromMap() async {
    final LatLng? selectedLocation = await Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const MapScreen(isSelecting: true,))
    );
    if (selectedLocation != null) {
      _showPreview(selectedLocation);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          height: 170,
          width: double.infinity,
          decoration: BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
          child: _previewImageUrl == null
            ? const Text("No location chosen")
            : Image.network(_previewImageUrl!, fit: BoxFit.cover, width: double.infinity,),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton.icon(
              onPressed: _getCurrentLocation,
              icon: const Icon(Icons.location_on),
              label: const Text("Current Location")
            ),
            TextButton.icon(
              onPressed: _selectFromMap,
              icon: const Icon(Icons.map),
              label: const Text("Select from map")
            )
          ],
        )
      ],
    );
  }
}
