import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_camera_challenge/providers/upload_providers.dart';
import 'package:flutter_firebase_camera_challenge/screens/uploaded_photo_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../services/firebase_service.dart';

class UploadsList extends ConsumerWidget {
  const UploadsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uploadsAsyncValue = ref.watch(uploadsProvider);

    return uploadsAsyncValue.when(
      data: (uploads) {
        return uploads.isEmpty
            ? const Center(
                child: Text(
                'No photos yet.\nTake some photos!',
                textAlign: TextAlign.center,
              ))
            : PhotosList(uploads: uploads);
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) {
        return Center(child: Text('Error: $error'));
      },
    );
  }
}

class PhotosList extends StatelessWidget {
  const PhotosList({
    super.key,
    required this.uploads,
  });

  final List<DocumentSnapshot<Object?>> uploads;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: uploads.length,
      itemBuilder: (context, index) {
        final upload = uploads[index];
        final url = upload['url'] ?? 'No URL found';
        final createdAt = upload['created_at'] as Timestamp? ?? Timestamp.now();

        return InkWell(
          onDoubleTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => UploadedPhotoScreen(imageUrl: url),
              ),
            );
          },
          child: Card(
            elevation: 3,
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Hero(
                  tag: url,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
                    child: Stack(
                      children: [
                        Image.network(
                          url,
                          height: 150,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                        ClipRRect(
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                            child: Container(
                              height: 150,
                              color: Colors.black.withOpacity(0.3),
                              alignment: Alignment.center,
                            ),
                          ),
                        ),

                        Image.network(
                          url,
                          height: 150,
                          width: double.infinity,
                          fit: BoxFit.contain,
                        ),
                        Positioned(
                          right: 8,
                          top: 8,
                          child: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text('Delete Photo'),
                                    content: const Text('Are you sure you want to delete this photo?'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text('Cancel'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          deleteUpload(upload.id);
                                          Navigator.pop(context);
                                        },
                                        child: const Text('Delete'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                        ),
                        // fullscreen icon button,
                        Positioned(
                          right: 8,
                          bottom: 8,
                          child: IconButton(
                            icon: const Icon(Icons.fullscreen),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => UploadedPhotoScreen(imageUrl: url),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'ID: ${upload.id}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Uploaded on ${DateFormat('MMMM d, y H:mm').format(createdAt.toDate())}',
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
