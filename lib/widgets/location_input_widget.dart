import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:places/helpers/location_helper.dart';

class LocationInputWidget extends StatefulWidget {
  const LocationInputWidget({Key? key}) : super(key: key);

  @override
  State<LocationInputWidget> createState() => _LocationInputWidgetState();
}

class _LocationInputWidgetState extends State<LocationInputWidget> {

  String? _previewImageUrl;

  Future<void> _getCurrentLocation() async {
    final location = await Location().getLocation();
    final staticMapUrl = LocationHelper.generateLocationPreviewImage(latitude: location.latitude!, longitude: location.longitude!);
    setState(() {
      _previewImageUrl = staticMapUrl;
    });
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
              onPressed: () {},
              icon: const Icon(Icons.map),
              label: const Text("Select from map")
            )
          ],
        )
      ],
    );
  }
}
