import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_gallery/models/image.dart';
import 'package:image_picker/image_picker.dart';

class Gallery extends StatefulWidget {
  const Gallery({super.key});

  @override
  State<Gallery> createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  final List<ImageItem> _images = [];

  void _addGalleryImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      String filePath = pickedFile.path;
      String fileName = pickedFile.name;
      Uint8List bytes = await pickedFile.readAsBytes();
      setState(() {
        _images.add(ImageItem(filePath, fileName, bytes));
      });
    } else {
      // Cancelled action
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Gallery"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 0, crossAxisSpacing: 0, crossAxisCount: 2),
          itemCount: _images.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                _showImageDialog(context, _images[index].bytes);
              },
              child: Image.memory(_images[index].bytes),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: _addGalleryImage,
        tooltip: 'Add image',
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showImageDialog(BuildContext context, Uint8List bytes) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Image.memory(bytes),
        );
      },
    );
  }
}
