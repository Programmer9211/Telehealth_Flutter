import 'package:flutter/material.dart';

class AppointmentConfirmation extends StatelessWidget {
  void onNotify() {}

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            appBar(size),
            SizedBox(
              height: size.height / 20,
            ),
            confirmationBox(size),
            SizedBox(
              height: size.height / 10,
            ),
            notifyButton(size, onNotify),
          ],
        ),
      ),
    );
  }

  Widget notifyButton(Size size, Function function) {
    return InkWell(
      onTap: function,
      child: Container(
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
          "Notify Me",
          style: TextStyle(
            fontSize: size.width / 23,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget confirmationBox(Size size) {
    return Container(
      height: size.height / 2.2,
      width: size.width / 1.1,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        border: Border.all(
          width: 1.5,
          color: Colors.indigo[100],
        ),
      ),
      child: Column(
        children: [
          Container(
            height: size.height / 20,
            width: size.width / 1.2,
            alignment: Alignment.bottomRight,
            child: Icon(
              Icons.close,
              size: size.width / 17,
              color: Colors.grey[700],
            ),
          ),
          Container(
            height: size.height / 8,
            width: size.width / 1.1,
            alignment: Alignment.center,
            child: Icon(
              Icons.calendar_today,
              size: size.width / 5,
            ),
          ),
          Text(
            "Your Appointment has been\n\t\t\t\t\t\t\t\t\t\t\t\t\t\t\tConfirmed",
            style: TextStyle(
              fontSize: size.width / 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            height: size.height / 9,
            width: size.width / 1.2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "9:05 Am",
                  style: TextStyle(
                    fontSize: size.width / 21,
                  ),
                ),
                Container(
                  height: size.height / 16,
                  width: size.width / 180,
                  color: Colors.black,
                ),
                Text(
                  "Dr. Pradeer Kumari",
                  style: TextStyle(
                    fontSize: size.width / 21,
                  ),
                ),
              ],
            ),
          ),
          Text(
            "Sunday, August 16, 2021",
            style: TextStyle(
              fontSize: size.width / 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(
            height: size.height / 50,
          ),
          Text(
            "Virtual Mode",
            style: TextStyle(
              fontSize: size.width / 20,
              fontWeight: FontWeight.w500,
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
            child: Icon(Icons.menu),
          ),
          Container(
              height: size.height / 20,
              width: size.width / 1.5,
              alignment: Alignment.center,
              child: Text(
                "Confirmation",
                style: TextStyle(
                  fontSize: size.width / 20,
                  fontWeight: FontWeight.w500,
                ),
              )),
          SizedBox(
            width: size.width / 10,
          ),
          Icon(Icons.arrow_back)
        ],
      ),
    );
  }
}
