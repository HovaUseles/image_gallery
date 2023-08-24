import 'package:flutter/material.dart';
import 'package:image_gallery/models/image_item.dart';

class ImageDetails extends StatelessWidget {
  final ImageItem _imageItem;

  const ImageDetails(this._imageItem, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(25),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return Dialog.fullscreen(
                    backgroundColor: Colors.black,
                    child: Image.memory(_imageItem.bytes),
                  );
                }),
              );
            },
            child: Image.memory(_imageItem.bytes),
          ),
          Text(
            "Name: ${_imageItem.name}",
            textScaleFactor: 2,
          ),
          Text(
            "Size: ${_imageItem.size}",
            textScaleFactor: 2,
          ),
        ],
      ),
    );
  }
}
