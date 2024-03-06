import 'package:flutter/material.dart';

class UploadedPhotoScreen extends StatelessWidget {
  final String imageUrl;

  const UploadedPhotoScreen({
    Key? key,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Uploaded Photo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Hero(tag: imageUrl, child: Image.network(imageUrl)),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
