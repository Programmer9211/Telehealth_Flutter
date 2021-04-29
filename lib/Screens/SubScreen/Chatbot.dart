import 'package:flutter/material.dart';

class ChatBot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      height: size.height,
      width: size.width,
      color: Colors.red,
    );
  }
}
