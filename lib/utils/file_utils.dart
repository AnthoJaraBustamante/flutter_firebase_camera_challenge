import 'dart:io';

import 'package:path_provider/path_provider.dart';

Future<String> path() async {
  String filename = DateTime.now().millisecondsSinceEpoch.toString();
  Directory tempDir = await getTemporaryDirectory();
  String tempPath = tempDir.path;
// /data/user/0/com.example.flutter_firebase_camera_challenge/cache
  return '$tempPath/$filename.jpg';
}
  