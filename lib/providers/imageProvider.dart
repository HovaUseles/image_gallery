import 'package:flutter/material.dart';
import 'package:image_gallery/models/image_item.dart';

/// Handles data state for Images
class ImagesProvider with ChangeNotifier {
  final List<ImageItem> _images = <ImageItem>[];
  List<ImageItem> get getImages => _images;

  /// Adds image to the data source
  void addImage(ImageItem imageItem) {
    _images.add(imageItem);
    notifyListeners();
  }

  /// Removes image from the data source
  void deleteImage(int index) {
    _images.removeAt(index);
  }
}