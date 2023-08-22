import 'package:flutter/material.dart';
import 'package:image_gallery/models/image.dart';

class ImagesProvider with ChangeNotifier {
  final List<ImageItem> _images = <ImageItem>[];
  List<ImageItem> get getImages => _images;

  void addImage(ImageItem imageItem) {
    _images.add(imageItem);
    notifyListeners();
  }

  void deleteImage(int index) {
    _images.removeAt(index);
  }
}