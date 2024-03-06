import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../services/firebase_service.dart';

final uploadsProvider = FutureProvider<List<DocumentSnapshot>>((ref) async {
  final docs = await getUploads();
  return docs;
});