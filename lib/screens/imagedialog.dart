import 'package:flutter/material.dart';

class ImageDialog extends StatelessWidget {
  const ImageDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: 200,
        height: 200,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: ExactAssetImage('assets/tamas.jpg'),
            fit: BoxFit.cover
          )
        ),
      ),
    );
  }
}