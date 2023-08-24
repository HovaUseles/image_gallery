import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_gallery/Utilities/Utilites.dart';
import 'package:image_gallery/components/image_details.dart';
import 'package:image_gallery/models/image_item.dart';
import 'package:image_gallery/providers/imageProvider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class Gallery extends StatefulWidget {
  const Gallery({super.key});

  @override
  State<Gallery> createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _nameFieldController = TextEditingController();

  /// Opens up a editor in a dialog window where the user can input the name of the image.
  void _editImageNameAndSaveDialog(ImageItem imageItem) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Image.memory(imageItem.bytes),
                  TextFormField(
                    controller: _nameFieldController,
                    decoration: const InputDecoration(
                      labelText: 'Name',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter image name';
                      }
                      return null;
                    },
                  ),
                  ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          ImageItem editedImageItem = ImageItem(
                              imageItem.imagePath,
                              _nameFieldController.text,
                              imageItem.bytes,
                              imageItem.size);
                          Provider.of<ImagesProvider>(context, listen: false)
                              .addImage(editedImageItem);
                          _nameFieldController.clear();
                          Navigator.pop(context);
                        }
                      },
                      child: const Text("Save Image"))
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  /// Opens the image picker and returns the picked image if any
  Future<ImageItem?> _pickImageGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      String filePath = pickedFile.path;
      String fileName = pickedFile.name;
      Uint8List bytes = await pickedFile.readAsBytes();
      String size = Utilites.getFileSizeString(bytes: bytes.length);
      ImageItem imageItem = ImageItem(filePath, fileName, bytes, size);
      return imageItem;
    } else {
      // Cancelled action
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Gallery"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: ListView.builder(
        itemCount: Provider.of<ImagesProvider>(context).getImages.length,
        itemBuilder: (context, index) {
          final imageItem =
              Provider.of<ImagesProvider>(context).getImages[index];
          return Dismissible(
            key: Key("imageItem $index"),
            direction: DismissDirection.endToStart,
            onDismissed: (direction) => {
              setState(() {
                Provider.of<ImagesProvider>(context, listen: false)
                    .deleteImage(index);
              })
            },
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(right: 20),
              child: const Icon(Icons.delete),
            ),
            child: GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return Dialog(
                      shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.elliptical(5, 5))),
                      child: ImageDetails(imageItem),
                    );
                  },
                );
              },
              child: ListTile(
                leading: CircleAvatar(
                  radius: 56, // Image radius
                  backgroundImage: MemoryImage(imageItem.bytes),
                ),
                title: Text(imageItem.name),
                subtitle: Text(imageItem.size),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          ImageItem? imgItem = await _pickImageGallery();
          if (imgItem != null) {
            _editImageNameAndSaveDialog(imgItem);
          }
        },
        tooltip: 'Add image',
        child: const Icon(Icons.add),
      ),
    );
  }
}
