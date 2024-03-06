import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

Future<void> addUpload(String url) {
  return db.collection('uploads').add(<String, dynamic>{
    'url': url,
    'created_at': FieldValue.serverTimestamp(),
  });
}

Future<void> deleteUpload(String id) {
  return db.collection('uploads').doc(id).delete();
}

Stream<List<DocumentSnapshot>> getUploads() {
  final snapshot = db.collection('uploads').orderBy('created_at', descending: true).snapshots();
  return snapshot.map((event) => event.docs);
}
