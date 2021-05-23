import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tele_health_app/Authenticate/Account.dart';

class Verify extends StatelessWidget {
  final SharedPreferences prefs;
  Verify({this.prefs});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text("Not Verified"),
        actions: [
          IconButton(
              icon: Icon(Icons.logout), onPressed: () => logOut(context, prefs))
        ],
      ),
      body: Container(
        height: size.height,
        width: size.width,
        alignment: Alignment.center,
        child: Text(
          "You Are Not Verified Yet\nWait For your verification",
          style: TextStyle(
            fontSize: size.width / 20,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
