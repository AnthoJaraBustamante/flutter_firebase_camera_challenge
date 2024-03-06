import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:camerawesome/camerawesome_plugin.dart';
import 'package:flutter_firebase_camera_challenge/services/firebase_service.dart';
import 'package:flutter_firebase_camera_challenge/utils/file_utils.dart';

class CameraScreen extends StatelessWidget {
  const CameraScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Camera Screen'),
      ),
      body: CameraAwesomeBuilder.awesome(
        saveConfig: SaveConfig.photo(pathBuilder: () async {
          final tempPath = await path();
          //add to Firebase store

          Future.delayed(const Duration(milliseconds: 500)).then((value) async {
            await _uploadToFStore(tempPath, context);
          });
          return tempPath;
        }),
        topActionsBuilder: (state) => AwesomeTopActions(
          padding: EdgeInsets.zero,
          state: state,
          children: [
            Expanded(
              child: AwesomeFilterWidget(
                state: state,
                filterListPosition: FilterListPosition.aboveButton,
                filterListPadding: const EdgeInsets.only(top: 8),
              ),
            ),
          ],
        ),
        middleContentBuilder: (state) {
          return Column(
            children: [
              const Spacer(),
              Builder(builder: (context) {
                return Container(
                  color: AwesomeThemeProvider.of(context).theme.bottomActionsBackgroundColor,
                  child: const Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 10, top: 10),
                      child: Text(
                        "Take your best shot!",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ],
          );
        },
        enablePhysicalButton: true,
        flashMode: FlashMode.auto,
        aspectRatio: CameraAspectRatios.ratio_16_9,
        previewFit: CameraPreviewFit.fitWidth,
        onMediaTap: (mediaCapture) {
          print(mediaCapture.filePath);
        },
        bottomActionsBuilder: (state) => AwesomeBottomActions(
          state: state,
          left: AwesomeFlashButton(
            state: state,
          ),
          right: AwesomeCameraSwitchButton(
            state: state,
            scale: 1.0,
            onSwitchTap: (state) {
              state.switchCameraSensor(
                aspectRatio: state.sensorConfig.aspectRatio,
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> _uploadToFStore(String pathBuild, BuildContext context) async {
    Navigator.pop(context);
    final firebaseStorageRef = firebase_storage.FirebaseStorage.instance.ref();
    final file = File(pathBuild);
    firebase_storage.UploadTask task = firebaseStorageRef.child('uploads/${file.path.split('/').last}').putFile(file);
    task.then((snapshot) async {
      var url = await snapshot.ref.getDownloadURL();
      addUpload(url).then((value) {});
    });
  }
}
