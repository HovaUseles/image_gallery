import 'dart:typed_data';

class ImageItem {
  final String imagePath;
  final String name;
  final Uint8List bytes;
  ImageItem(this.imagePath, this.name, this.bytes);
}