import 'package:flutter/material.dart';

class DoctorNotification extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text("Notifications"),
      ),
      body: Container(
        height: size.height,
        width: size.width,
        alignment: Alignment.center,
        child: Text(
          "No Notifications Yet!",
          style: TextStyle(
            fontSize: size.width / 22,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
