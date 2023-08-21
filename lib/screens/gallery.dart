import 'package:flutter/material.dart';


class Gallery extends StatefulWidget {
  const Gallery({super.key});

  @override
  State<Gallery> createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(  
      appBar: AppBar(
        title: const Text("Gallery"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
    );
  }
}