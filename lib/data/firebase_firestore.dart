import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';
import 'package:vibe_verse/data/model/usermodel.dart';

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

  Future<Usermodel>getUser()async{
    try{
      final user = await _fireStore.collection('users').doc(
          _auth.currentUser!.uid).get();
      final snapuser = user.data()!;
      return Usermodel(
          snapuser['bio'],
          snapuser['email'],
          snapuser['followers'],
          snapuser['following'],
          snapuser['profile'],
          snapuser['username']);
    } on FirebaseException catch (e) {
      throw Exception(e.message.toString());
    }
  }
  Future<bool> createPost({
    required List<String> postImages,
    required String caption,
    required String location,
  }) async {
    var uid = Uuid().v4();
    DateTime data = DateTime.now();
    Usermodel user = await getUser();
    await _fireStore.collection('posts').doc(uid).set({
      'postImages': postImages,
      'username': user.userName,
      'profileImage': user.profile,
      'caption': caption,
      'location': location,
      'uid': _auth.currentUser!.uid,
      'postId': uid,
      'like': [],
      'time': data
    });
    return true;
  }

  // Future<List<String>> fetchAllImages() async {
  //   List<String> imageUrls = [];
  //   final ListResult result = await FirebaseStorage.instance.ref('posts').listAll();
  //
  //   for (var ref in result.items) {
  //     final String url = await ref.getDownloadURL();
  //     imageUrls.add(url);
  //   }
  //   return imageUrls;
  // }

  // Stream<List<Map<String, dynamic>>> fetchImagesStream() async* {
  //   while (true) {
  //     List<Map<String, dynamic>> postDetails = [];
  //
  //     // Fetch posts data from Firestore
  //     QuerySnapshot snapshot = await _fireStore.collection('posts').get();
  //     for (var post in snapshot.docs) {
  //       var data = post.data() as Map<String, dynamic>;
  //       postDetails.add({
  //         'postImages': data['postImages'],
  //         'username': data['username'],
  //         'profileImage': data['profileImage'],
  //         'caption': data['caption'],
  //       });
  //     }
  //
  //     yield postDetails;
  //     await Future.delayed(const Duration(seconds: 5)); // Poll every 5 seconds
  //   }
  // }

  Stream<List<String>> fetchImagesStream() async* {
    while (true) {
      List<String> imageUrls = [];
      final ListResult result = await FirebaseStorage.instance.ref('posts').listAll();

      for (var ref in result.items) {
        final String url = await ref.getDownloadURL();
        imageUrls.add(url);
      }

      yield imageUrls;
      await Future.delayed(const Duration(seconds: 5)); // Poll every 5 seconds
    }
  }

}

