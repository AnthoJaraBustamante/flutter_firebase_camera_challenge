import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../services/firebase_service.dart';

final uploadsProvider = StreamProvider<List<DocumentSnapshot>>((ref) {
  return getUploads();
});
