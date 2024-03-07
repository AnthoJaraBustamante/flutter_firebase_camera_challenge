import 'dart:io';

import 'package:path_provider/path_provider.dart';

Future<String> path() async {
  String filename = DateTime.now().millisecondsSinceEpoch.toString();
  Directory tempDir = await getTemporaryDirectory();
  String tempPath = tempDir.path;

  return '$tempPath/$filename.jpg';
}
  