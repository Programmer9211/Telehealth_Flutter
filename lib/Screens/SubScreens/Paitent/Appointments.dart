import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tele_health_app/Screens/SubScreens/Paitent/ViewProfile.dart';

class Appointments extends StatefulWidget {
  @override
  _AppointmentsState createState() => _AppointmentsState();
}

class _AppointmentsState extends State<Appointments> {
  List<Map<String, dynamic>> appointmentList = [];
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    getAppointmentList();
  }

  Future getAppointmentList() async {
    List<DocumentSnapshot> docsSnap = [];

    await _firestore
        .collection("paitent")
        .doc(_auth.currentUser.uid)
        .collection('appointment')
        .get()
        .then((snap) {
      docsSnap = snap.docs;

      appointmentList = docsSnap.map((e) => e.data()).toList();
      setState(() {});
      print(appointmentList);
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    if (appointmentList != null) {
      if (appointmentList.length > 0) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Appointments"),
            backgroundColor: Color.fromRGBO(55, 82, 178, 1),
          ),
          body: ListView.builder(
            itemCount: appointmentList.length,
            itemBuilder: (context, index) {
              return appointmentItems(size, index);
            },
          ),
        );
      } else {
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
    } else {
      return Scaffold(
        body: Center(
          child: Container(
            height: size.height / 20,
            width: size.height / 20,
            child: CircularProgressIndicator(),
          ),
        ),
      );
    }
  }

  Widget appointmentItems(Size size, int index) {
    return Container(
      height: size.height / 4,
      width: size.height,
      alignment: Alignment.center,
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        elevation: 10,
        child: Container(
          height: size.height / 4.5,
          width: size.width / 1.1,
          child: Stack(
            children: [
              Positioned(
                top: size.width / 28,
                left: size.width / 25,
                child: Container(
                  height: size.height / 10,
                  width: size.height / 10,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue,
                  ),
                ),
              ),
              Positioned(
                top: size.width / 14,
                left: size.width / 3.5,
                child: Container(
                  width: size.width / 1.8,
                  child: Text(
                    appointmentList[index]['name'],
                    style: TextStyle(
                      fontSize: size.width / 22,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: size.width / 7,
                left: size.width / 3.5,
                child: Container(
                  width: size.width / 1.8,
                  child: Text(
                    "Time : ${appointmentList[index]['time']}",
                    style: TextStyle(
                      fontSize: size.width / 22,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: size.width / 40,
                left: size.width / 4.5,
                child: GestureDetector(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => ViewProfile(
                        uid: appointmentList[index]['uid'],
                      ),
                    ),
                  ),
                  child: Material(
                    elevation: 4,
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.blueAccent,
                    child: Container(
                      height: size.height / 16,
                      width: size.width / 2,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.blueAccent,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "Doctor Profile",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: size.width / 22,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
