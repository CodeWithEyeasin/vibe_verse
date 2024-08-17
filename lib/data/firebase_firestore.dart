import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseFireStore {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> createUser({
    required String email,
    required String userName,
    required String bio,
    required String profile,
  }) async {
    await _fireStore.collection('úsers').doc(_auth.currentUser?.uid ?? '').set({
      'email': email,
      'userName': userName,
      'bio': bio,
      'profile': profile,
      'followers': [],
      'following': [],
    });

    return true;
  }
}
