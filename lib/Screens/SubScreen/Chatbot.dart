import 'package:flutter/material.dart';

class ChatBot extends StatelessWidget {
  final Function openDrawer;

  ChatBot({this.openDrawer});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      height: size.height,
      width: size.width,
      child: Column(
        children: [
          appBar(size),
        ],
      ),
    );
  }

  Widget appBar(Size size) {
    return Container(
      height: size.height / 12,
      width: size.width,
      color: Colors.blue[100],
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: openDrawer,
              child: Icon(Icons.menu),
            ),
          ),
          Container(
              height: size.height / 20,
              width: size.width / 1.5,
              alignment: Alignment.center,
              child: Text(
                "Chat Bot",
                style: TextStyle(
                  fontSize: size.width / 20,
                  fontWeight: FontWeight.w500,
                ),
              )),
          SizedBox(
            width: size.width / 10,
          ),
          Icon(Icons.settings)
        ],
      ),
    );
  }
}
