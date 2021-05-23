import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tele_health_app/Screens/SubScreens/Paitent/Profile.dart';
import 'package:toast/toast.dart';

class DoctorAppointment extends StatefulWidget {
  @override
  _DoctorAppointmentState createState() => _DoctorAppointmentState();
}

class _DoctorAppointmentState extends State<DoctorAppointment> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _uid = FirebaseAuth.instance.currentUser.uid;
  List<Map<String, dynamic>> appointmentMap;
  String imageUrl;

  @override
  void initState() {
    super.initState();
    getAppointments();
  }

  Future getMedicalHistory(int index) async {
    try {
      List<DocumentSnapshot> snap = [];

      await _firestore
          .collection('paitent')
          .doc(appointmentMap[index]['uid'])
          .collection('report')
          .get()
          .then((value) {
        snap = value.docs;
        imageUrl = snap[0].data()['image'];
        print(imageUrl);
        setState(() {});
        if (imageUrl != null) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => ViewImage(
                imageUrl: imageUrl,
              ),
            ),
          );
        }
      });
    } catch (e) {}
  }

  Future getAppointments() async {
    List<DocumentSnapshot> snap = [];

    try {
      await _firestore
          .collection('doctor')
          .doc(_uid)
          .collection('appointment')
          .get()
          .then((value) {
        snap = value.docs;
        appointmentMap = snap.map((e) => e.data()).toList();
        setState(() {});
      });
    } catch (e) {
      Toast.show("Error Occured", context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    if (appointmentMap != null) {
      if (appointmentMap.length > 0) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Today's Appointments"),
          ),
          body: builder(size),
        );
      } else {
        return Scaffold(
            appBar: AppBar(
              title: Text("Today's Appointments"),
            ),
            body: Container(
              height: size.height,
              width: size.width,
              alignment: Alignment.center,
              child: Text(
                "No Appointments Today",
                style: TextStyle(
                  fontSize: size.width / 22,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ));
      }
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text("Today's Appointments"),
        ),
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

  Widget builder(Size size) {
    return Container(
      height: size.height,
      width: size.width,
      child: ListView.builder(
          itemCount: appointmentMap.length,
          itemBuilder: (context, index) {
            return appointmentItems(size, index);
          }),
    );
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
                    appointmentMap[index]['name'],
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
                    "Time : ${appointmentMap[index]['time']}",
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
                  // onTap: () => Navigator.of(context).push(
                  //   MaterialPageRoute(
                  //     builder: (_) => ViewProfile(
                  //       uid: appointmentList[index]['uid'],
                  //     ),
                  //   ),
                  // ),
                  onTap: () => getMedicalHistory(index),
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
                        "View Medical History",
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
