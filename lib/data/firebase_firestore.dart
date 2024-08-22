import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
    required String postImage,
    required String caption,
    required String location,
})async{
    var uid = Uuid().v4();
    DateTime data = new DateTime.now();
    Usermodel user = await getUser();
    await _fireStore.collection('posts').doc(uid).set({
      'postImage':postImage,
      'username':user.userName,
      'profileImage':user.profile,
      'caption':caption,
      'location': location,
      'uid':_auth.currentUser!.uid,
      'postId': uid,
      'like':[],
      'time':data
    });
    return true;
  }
}
