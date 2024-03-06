import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

Future<void> addUpload(String url) {
  return db.collection('uploads').add(<String, dynamic>{
    'url': url,
    'created_at': FieldValue.serverTimestamp(),
  });
}

Future<List<DocumentSnapshot>> getUploads() async {
  final snapshot = await db.collection('uploads').get();
  return snapshot.docs;
}