import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tele_health_app/Authenticate/Authenticate.dart';
import 'package:toast/toast.dart';

Future<User> createAccount(
    String name, String email, String password, BuildContext context) async {
  FirebaseAuth auth = FirebaseAuth.instance;

  try {
    var user = (await auth.createUserWithEmailAndPassword(
            email: email, password: password))
        .user;

    if (user != null) {
      print("Login Sucess");
      user.updateProfile(displayName: name);
      return user;
    } else {
      print("Login Falied");
      return user;
    }
  } catch (e) {
    print(e);
    Toast.show("An Unexpected Error Occured", context);
    return null;
  }
}

Future logOut(BuildContext context, SharedPreferences prefs) async {
  FirebaseAuth auth = FirebaseAuth.instance;

  try {
    await auth.signOut().then((value) async {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => Authenticate(prefs)),
          (Route<dynamic> route) => false);
    });
  } catch (e) {
    Toast.show("An Unexpected Error Occured", context);
    print("error");
  }
}

Future<User> logIn(String email, String password, BuildContext context) async {
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
    Toast.show("An Unexpected Error Occured", context);
    print("error");
    return null;
  }
}
