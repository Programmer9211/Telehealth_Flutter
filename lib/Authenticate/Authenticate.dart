import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tele_health_app/Authenticate/WelcomeScreen.dart';
import 'package:tele_health_app/Screens/SubScreens/Paitent/HomeScreen.dart';

class Authenticate extends StatelessWidget {
  final SharedPreferences prefs;
  Authenticate({this.prefs});
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return auth.currentUser != null
        ? HomePage(
            prefs: prefs,
          )
        : WelcomeScreen(prefs: prefs);
  }
}
