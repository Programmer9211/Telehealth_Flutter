import 'package:flutter/material.dart';

class Verify extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text("Not Verified"),
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
