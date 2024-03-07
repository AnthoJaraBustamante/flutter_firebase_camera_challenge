import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<void> addUpload(String url) {
    return _db.collection('uploads').add(<String, dynamic>{
      'url': url,
      'created_at': FieldValue.serverTimestamp(),
    });
  }

  Future<void> deleteUpload(String id) {
    return _db.collection('uploads').doc(id).delete();
  }

  Future<void> editUpload(String id, String url) {
    return _db.collection('uploads').doc(id).update(<String, dynamic>{
      'url': url,
      'updated_at': FieldValue.serverTimestamp(),
    });
  }

  Stream<List<DocumentSnapshot>> getUploads() {
    final snapshot = _db.collection('uploads').orderBy('created_at', descending: true).snapshots();
    return snapshot.map((event) => event.docs);
  }

  Future<String> uploadToFStore(String pathBuild) async {
    final firebaseStorageRef = _storage.ref();
    final file = File(pathBuild);
    UploadTask task = firebaseStorageRef.child('uploads/${file.path.split('/').last}').putFile(file);
    TaskSnapshot snapshot = await task;

    if (snapshot.state == TaskState.success) {
      return snapshot.ref.getDownloadURL();
    } else {
      throw Exception('Failed to upload file');
    }
  }
}
