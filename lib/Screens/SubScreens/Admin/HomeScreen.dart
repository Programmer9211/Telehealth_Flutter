import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AdminHomeScreen extends StatefulWidget {
  @override
  _AdminHomeScreenState createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void onAccept() {}

  void onReject() {}

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text("Admin"),
      ),
      body: StreamBuilder(
        stream: _firestore.collection('admin').get().asStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data != null) {
              return haveData(size);
            } else {
              return noData(size);
            }
          } else {
            return noData(size);
          }
        },
      ),
    );
  }

  Widget noData(Size size) {
    return Container(
      height: size.height,
      width: size.width,
      alignment: Alignment.center,
      child: Text(
        "No Notifications Yet !",
        style: TextStyle(
          fontSize: size.width / 22,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget haveData(Size size) {
    return Container(
      height: size.height,
      width: size.width,
      alignment: Alignment.center,
      child: Container(
        height: size.height,
        width: size.width / 1.08,
        child: ListView.builder(
          itemCount: 4,
          itemBuilder: (_, index) {
            return Container(
              height: size.height / 3.7,
              alignment: Alignment.center,
              child: Material(
                elevation: 5,
                child: Container(
                  height: size.height / 4,
                  width: size.width / 1.1,
                  child: Stack(
                    children: [
                      Positioned(
                        top: size.width / 28,
                        left: size.width / 25,
                        child: Container(
                          height: size.height / 9,
                          width: size.height / 9,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                      Positioned(
                        top: size.width / 18,
                        left: size.width / 3.5,
                        child: Container(
                          width: size.width / 1.8,
                          child: Text(
                            "Dr Abdul Kalam Bro",
                            style: TextStyle(
                              fontSize: size.width / 22,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: size.width / 7.2,
                        left: size.width / 3.5,
                        child: Container(
                          width: size.width / 1.8,
                          child: Text(
                            "Specialization",
                            style: TextStyle(
                              fontSize: size.width / 22,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: size.width / 5.2,
                        left: size.width / 3.5,
                        child: Container(
                          width: size.width / 1.8,
                          child: Text(
                            "Qualification",
                            style: TextStyle(
                              fontSize: size.width / 22,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: size.width / 5,
                        left: size.width / 30,
                        child: Container(
                          height: size.width / 200,
                          width: size.width / 1.2,
                          color: Colors.grey,
                        ),
                      ),
                      Positioned(
                        bottom: size.width / 28,
                        right: size.width / 25,
                        child: approvalButton(size, Colors.blue, "Accept"),
                      ),
                      Positioned(
                        bottom: size.width / 28,
                        left: size.width / 25,
                        child: approvalButton(size, Colors.red[400], "Reject"),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget approvalButton(Size size, Color color, String text) {
    return Material(
      elevation: 4,
      borderRadius: BorderRadius.circular(8),
      color: color,
      child: Container(
        height: size.height / 19,
        width: size.width / 3.8,
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontSize: size.width / 25,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
