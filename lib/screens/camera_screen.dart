import 'package:flutter/material.dart';
import 'package:camerawesome/camerawesome_plugin.dart';
import 'package:flutter_firebase_camera_challenge/services/firebase_service.dart';
import 'package:flutter_firebase_camera_challenge/utils/file_utils.dart';

class CameraScreen extends StatelessWidget {
  const CameraScreen({super.key, this.id});

  final String? id;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Camera Screen'),
      ),
      body: CameraAwesomeBuilder.awesome(
        saveConfig: SaveConfig.photo(pathBuilder: () async {
          final tempPath = await path();

          Future.delayed(const Duration(milliseconds: 500)).then((value) async {
            await _uploadToFStore(tempPath, context, id);
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

  Future<void> _uploadToFStore(String pathBuild, BuildContext context, String? id) async {
    Navigator.pop(context);
    try {
      final uploadedUrl = await FirebaseService().uploadToFStore(pathBuild);
      if (id != null) {
        await FirebaseService().editUpload(id, uploadedUrl);
        return;
      }
      FirebaseService().addUpload(uploadedUrl);
    } on Exception catch (e) {
      throw Exception(e);
    }
  }
}
