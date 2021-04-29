import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:tele_health_app/Screens/SubScreen/ChooseDoctor.dart';

class Appointment extends StatefulWidget {
  final Function openDrawer;

  Appointment({this.openDrawer});

  @override
  _AppointmentState createState() => _AppointmentState();
}

class _AppointmentState extends State<Appointment> {
  final List<String> searchItemList = [
    "Cough",
    "Headache",
    "Backpain",
    "Fever",
    "Runny Nose",
    "Hairfall",
    "Vomating",
    "Abdominal Pain",
  ];

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
            height: size.height / 10,
            width: size.width / 1.1,
            alignment: Alignment.centerLeft,
            child: Text(
              "Search or choose your health issues",
              style: TextStyle(
                fontSize: size.width / 23,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Container(
            height: size.height / 15,
            width: size.width / 1.1,
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: "Search here e.g:fever",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
          ),
          Container(
            height: size.height / 15,
            width: size.width / 1.1,
            alignment: Alignment.bottomLeft,
            child: Text(
              "Popular Searches",
              style: TextStyle(
                fontSize: size.width / 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          searchitems(size, 0),
          searchitems(size, 2),
          searchitems(size, 4),
          searchitems(size, 6),
          SizedBox(
            height: size.height / 15,
          ),
          customButton(size),
        ],
      ),
    );
  }

  Widget customButton(Size size) {
    return GestureDetector(
      onTap: () => Navigator.of(context)
          .push(MaterialPageRoute(builder: (_) => ChooseDoctor())),
      child: Container(
        height: size.height / 14,
        width: size.width / 1.1,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            width: 1.5,
            color: Colors.black,
          ),
        ),
        child: Text(
          "Choose Doctor",
          style: TextStyle(
            fontSize: size.width / 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget searchitems(Size size, int index) {
    return Container(
      height: size.height / 11,
      width: size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          searchItemBuilder(size, index),
          searchItemBuilder(size, index + 1),
        ],
      ),
    );
  }

  Widget searchItemBuilder(Size size, int index) {
    return Container(
      height: size.height / 18,
      width: size.width / 2.9,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          width: 1.5,
          color: Colors.black,
        ),
      ),
      child: Text(
        searchItemList[index],
        style: TextStyle(
          fontSize: size.width / 23,
          fontWeight: FontWeight.w500,
        ),
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
              onTap: () {
                widget.openDrawer();
                print("Drawer");
              },
              child: Icon(Icons.menu),
            ),
          ),
          Container(
              height: size.height / 20,
              width: size.width / 1.5,
              alignment: Alignment.center,
              child: Text(
                "Book Appointment",
                style: TextStyle(
                  fontSize: size.width / 20,
                  fontWeight: FontWeight.w500,
                ),
              )),
          SizedBox(
            width: size.width / 10,
          ),
          Icon(Icons.notifications)
        ],
      ),
    );
  }
}
