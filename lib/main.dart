import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:vibe_verse/app.dart';
import 'package:vibe_verse/firebase_options.dart';



void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const VibeVerseApp());
}

///development branch