import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:playlist/const/const.dart';
import 'package:playlist/repository/music_list_repository.dart';
import 'package:playlist/underbar.dart';
import 'firebase_options.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  Constants.musicList = await musicListRepository.musicList();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: UnderBar(),
    );
  }
}
