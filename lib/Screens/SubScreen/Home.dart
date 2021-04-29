import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  final Function onAppointmentTap, onChatBotTap, openDrawer;

  Home({this.onAppointmentTap, this.onChatBotTap, this.openDrawer});

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
            width: size.width,
            alignment: Alignment.center,
            child: Text(
              "Welcome",
              style: TextStyle(
                color: Colors.indigo,
                fontSize: size.width / 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Divider(
            color: Colors.black,
            thickness: 2.0,
          ),
          box(
            size,
            "Make a new appointment",
            Icons.calendar_today,
            "Book An Appointment",
            onAppointmentTap,
          ),
          Divider(
            color: Colors.black,
            thickness: 2.0,
          ),
          box(
            size,
            "Interact With ChatBot",
            Icons.chat,
            "Chat Bot",
            onChatBotTap,
          ),
        ],
      ),
    );
  }

  Widget box(Size size, String title, IconData icon, String buttontext,
      Function func) {
    return Container(
      height: size.height / 3.1,
      width: size.width,
      child: Column(
        children: [
          Container(
            height: size.height / 15,
            width: size.width / 1.1,
            alignment: Alignment.centerLeft,
            child: Text(
              title,
              style: TextStyle(
                fontSize: size.width / 20,
              ),
            ),
          ),
          Icon(
            icon,
            size: size.width / 5,
            color: Colors.indigo,
          ),
          SizedBox(
            height: size.height / 30,
          ),
          GestureDetector(
            onTap: func,
            child: Container(
              height: size.height / 15,
              width: size.width / 1.5,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  border: Border.all(
                    width: 1,
                    color: Colors.black,
                  )),
              child: Text(
                buttontext,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: size.width / 20,
                ),
              ),
            ),
          )
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
            color: Colors.white,
            child: TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                prefixIcon: Icon(Icons.location_on),
                hintText: "Your Current Location",
              ),
            ),
          ),
          SizedBox(
            width: size.width / 10,
          ),
          Icon(Icons.notifications)
        ],
      ),
    );
  }
}
