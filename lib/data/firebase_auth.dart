import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:vibe_verse/data/firebase_firestore.dart';
import 'package:vibe_verse/data/storage.dart';
import 'package:vibe_verse/utils/exception.dart';

class Authentication {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> login({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(
          email: email.trim(), password: password.trim());
    } on FirebaseException catch (e) {
      throw Exceptions(e.message.toString());
    }
  }

  Future<void> signUp({
    required String email,
    required String password,
    required String confirmPassword,
    required String userName,
    required String bio,
    required File profile,
  }) async {
    String URL;

    try {
      if (email.isNotEmpty &&
          password.isNotEmpty &&
          userName.isNotEmpty &&
          bio.isNotEmpty) {
        if (password == confirmPassword) {
          await _auth.createUserWithEmailAndPassword(
              email: email.trim(), password: password.trim());

          if (profile != File('')) {
            URL =
                await StorageMethod().uploadImageToStorage('Profile', profile);
          } else {
            URL = '';
          }

          await FirebaseFireStore().createUser(
              email: email,
              userName: userName,
              bio: bio,
              profile: URL == ' ' ? 'https://via.placeholder.com/150' : URL);
        } else {
          throw Exceptions('Password and Confirm Password Should be same');
        }
      } else {
        throw Exceptions('Enter All Fields');
      }
    } on FirebaseException catch (e) {
      throw Exceptions(e.message.toString());
    }
  }

  Future<void> signOutUser() async {
    await FirebaseAuth.instance.signOut();
  }

}
