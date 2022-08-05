import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:places/models/place_model.dart';

class MapScreen extends StatefulWidget {
  final PlaceLocation initialCameraPosition;
  final bool isSelecting;
  const MapScreen({Key? key, this.initialCameraPosition = const PlaceLocation(latitude: 37.422, longitude: -122.084), this.isSelecting = false}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {

  LatLng? _pickedLocation;

  void _selectLocation(LatLng position) {
    setState(() {
      _pickedLocation = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Map"),
        actions: [
          if (widget.isSelecting && _pickedLocation != null) IconButton(
            onPressed: () => Navigator.of(context).pop(_pickedLocation),
            icon: const Icon(Icons.done)
          )
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(target: LatLng(widget.initialCameraPosition.latitude, widget.initialCameraPosition.longitude), zoom: 12),
        onTap: widget.isSelecting ? _selectLocation : null,
        markers: {
          if (_pickedLocation != null) Marker(markerId: const MarkerId('selected'), position: _pickedLocation!)
        },
      ),
    );
  }
}
