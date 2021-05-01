import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tele_health_app/Authenticate/LoginScreen.dart';

Future<User> createAccount(String email, String password) async {
  FirebaseAuth auth = FirebaseAuth.instance;

  try {
    var user = (await auth.createUserWithEmailAndPassword(
            email: email, password: password))
        .user;

    if (user != null) {
      print("Login Sucess");
      return user;
    } else {
      print("Login Falied");
      return user;
    }
  } catch (e) {
    print(e);
    return null;
  }
}

Future logOut(BuildContext context) async {
  FirebaseAuth auth = FirebaseAuth.instance;

  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await auth.signOut().then((value) async {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (_) => LoginScreen(
                    prefs: prefs,
                  )),
          (Route<dynamic> route) => false);

      await prefs.clear().then((value) {
        print(value);
      });
    });
  } catch (e) {
    print("error");
  }
}

Future<User> logIn(String email, String password) async {
  FirebaseAuth auth = FirebaseAuth.instance;

  try {
    User user = (await auth.signInWithEmailAndPassword(
            email: email, password: password))
        .user;

    if (user != null) {
      print("Login Sucess");
      return user;
    } else {
      print("Error");
      return user;
    }
  } catch (e) {
    print("error");
    return null;
  }
}
