import 'dart:io';

import 'package:flutter/material.dart';

class ImageInputWidget extends StatefulWidget {
  const ImageInputWidget({Key? key}) : super(key: key);

  @override
  State<ImageInputWidget> createState() => _ImageInputWidgetState();
}

class _ImageInputWidgetState extends State<ImageInputWidget> {

  File? _storedImage;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 150,
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey)
          ),
          child: _storedImage != null
            ? Image.file(_storedImage!, fit: BoxFit.cover, width: double.infinity)
            : const Text("No Image Taken"),
        ),
        const SizedBox(width: 10,),
        Expanded(
          child: TextButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.camera),
            label: const Text("Take photo", textAlign: TextAlign.center,),
          ),
        )
      ],
    );
  }
}
