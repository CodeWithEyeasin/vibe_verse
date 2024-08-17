import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class StorageMethod {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> uploadImageToStorage(String name, File file) async{
    Reference reference = _storage.ref().child(name).child(_auth.currentUser?.uid ?? '');

    UploadTask uploadTask = reference.putFile(file);
    TaskSnapshot snapshot = await uploadTask;
    String downLoadUrl = await snapshot.ref.getDownloadURL();
    return downLoadUrl;
  }
}
