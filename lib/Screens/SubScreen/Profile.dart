import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  final Function openDrawer;

  Profile({this.openDrawer});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
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
    );
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
                  "Anjali Gupta",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: size.width / 20,
                  ),
                ),
                SizedBox(
                  width: size.width / 3.5,
                ),
                Text(
                  "Female",
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
              "+91 8805324689\nanjaligupta@gmail.com\n18 july 1996",
              style: TextStyle(
                fontSize: size.width / 20,
              ),
            ),
          ),
          Text(
            "Age: 25\nWeight: 52 Kg\nHeight: 157.48 cm\nBlood Group: B+",
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
              onTap: openDrawer,
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
