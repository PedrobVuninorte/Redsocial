import 'package:red_social_get/domain/controller/authentication_controller.dart';
import 'package:red_social_get/domain/controller/chat_controller.dart';
import 'package:red_social_get/domain/controller/firestore_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'firebase_central.dart';

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Firebase demo - MisionTIC',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
          body: FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Wrong(text: snapshot.error.toString());
          }
          if (snapshot.connectionState == ConnectionState.done) {
            Get.put(FirebaseController());
            Get.put(AuthenticationController());
            Get.put(ChatController());
            return const FirebaseCentral();
          }

          return const Loading();
        },
      )),
    );
  }
}

// ignore: must_be_immutable
class Wrong extends StatelessWidget {
  late String text;

  Wrong({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Something went wrong $text"));
  }
}

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Loading"));
  }
}
