import 'package:better_open_file/better_open_file.dart';
import 'package:flutter/material.dart';
import 'package:camerawesome/camerawesome_plugin.dart';
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
        saveConfig: SaveConfig.photo(pathBuilder: () => path()),
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
          OpenFile.open(mediaCapture.filePath);
        },
      ),
    );
  }
}
