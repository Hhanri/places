import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class ImageInputWidget extends StatefulWidget {
  final Function(File) onSelectImage;
  const ImageInputWidget({Key? key, required this.onSelectImage}) : super(key: key);

  @override
  State<ImageInputWidget> createState() => _ImageInputWidgetState();
}

class _ImageInputWidgetState extends State<ImageInputWidget> {

  File? _storedImage;

  void _takePicture() async {
    final picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.camera, maxWidth: 600);
    if (image != null) {
      setState(() {
        _storedImage = File(image.path);
      });
      final appDir = await getApplicationDocumentsDirectory();
      final fileName = basename(_storedImage!.path);
      final savedImage = await _storedImage!.copy("${appDir.path}/$fileName");
      widget.onSelectImage(_storedImage!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 150,
          height: 100,
          alignment: Alignment.center,
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
            onPressed: _takePicture,
            icon: const Icon(Icons.camera),
            label: const Text("Take photo", textAlign: TextAlign.center,),
          ),
        )
      ],
    );
  }
}
