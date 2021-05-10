import 'package:flutter/material.dart';

class Appointments extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text("Appointments"),
        backgroundColor: Color.fromRGBO(55, 82, 178, 1),
      ),
      body: Container(
        height: size.height,
        width: size.width,
        alignment: Alignment.center,
        child: Text(
          "You Don't have any appointments",
          style: TextStyle(
            fontSize: size.width / 24,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
