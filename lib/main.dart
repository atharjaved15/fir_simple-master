import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Start.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    home: splash(),
    debugShowCheckedModeBanner: false,
  ));
}
class splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AnimatedSplashScreen(
        splash: Image.asset('images/logo.png'),
        nextScreen: Start(),
        splashTransition: SplashTransition.rotationTransition,
        duration: 3000,
        backgroundColor: Colors.grey[200],
      ),
    );
  }
}
