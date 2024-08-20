import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:summer_camp/logic/auth_methos.dart';
import 'package:summer_camp/screens/signUp_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  print("Firebase Initialized");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Summer Camp',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: StreamBuilder<User?>(
        stream: AuthMethods().authChanges,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            
                          
              return SignupScreen();
            
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
