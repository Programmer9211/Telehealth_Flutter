import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  final Function openDrawer;
  final Map<String, dynamic> userMap;

  Profile({this.openDrawer, this.userMap});

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return widget.userMap != null
        ? Container(
            height: size.height,
            width: size.width,
            child: Column(
              children: [
                appBar(size),
                Container(
                  height: size.height / 4.4,
                  width: size.width,
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.account_circle,
                    size: size.width / 3,
                    color: Colors.blue[100],
                  ),
                ),
                paitentInfo(size),
              ],
            ),
          )
        : Container();
  }

  Widget paitentInfo(Size size) {
    return Container(
      height: size.height / 2.9,
      width: size.width / 1.1,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        border: Border.all(
          width: 1.5,
          color: Colors.blue[100],
        ),
      ),
      child: Column(
        children: [
          Container(
            height: size.height / 16,
            width: size.width / 1.2,
            child: Row(
              children: [
                Text(
                  "${widget.userMap['name']}",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: size.width / 20,
                  ),
                ),
                SizedBox(
                  width: size.width / 3.5,
                ),
                Text(
                  widget.userMap['gender'],
                  style: TextStyle(
                    fontSize: size.width / 20,
                  ),
                ),
                SizedBox(
                  width: size.width / 30,
                ),
                Icon(Icons.smart_button),
              ],
            ),
          ),
          Container(
            width: size.width / 1.15,
            child: Text(
              "${widget.userMap['mob']}\n${widget.userMap['email']}\nDob",
              style: TextStyle(
                fontSize: size.width / 20,
              ),
            ),
          ),
          Text(
            "Age: 25\nWeight: ${widget.userMap['weight']} Kg\nHeight: ${widget.userMap['height']} ft\nBlood Group: ${widget.userMap['bg']}",
            style: TextStyle(
              fontSize: size.width / 20,
            ),
          ),
          Container(
            width: size.width / 1.2,
            alignment: Alignment.bottomRight,
            child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.edit),
            ),
          ),
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
              onTap: widget.openDrawer,
              child: Icon(Icons.menu),
            ),
          ),
          Container(
              height: size.height / 20,
              width: size.width / 1.5,
              alignment: Alignment.center,
              child: Text(
                "Profile",
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
