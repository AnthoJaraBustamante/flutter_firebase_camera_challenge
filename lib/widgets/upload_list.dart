import 'package:flutter/material.dart';
import 'package:flutter_firebase_camera_challenge/providers/upload_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UploadsList extends ConsumerWidget {
  const UploadsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uploadsAsyncValue = ref.watch(uploadsProvider);

    return uploadsAsyncValue.when(
      data: (uploads) {
        return Expanded(
          child: ListView.builder(
            itemCount: uploads.length,
            itemBuilder: (context, index) {
              var upload = uploads[index];
              return ListTile(
                title: Text(upload['url'] ?? 'No URL found'),
                subtitle: Text(upload['timestamp'] ?? 'No timestamp found'),
                // Add more details as needed
              );
            },
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) {
        // Handle error case
        return Center(child: Text('Error: $error'));
      },
    );
  }
}
