import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class DoctorAppointment extends StatefulWidget {
  @override
  _DoctorAppointmentState createState() => _DoctorAppointmentState();
}

class _DoctorAppointmentState extends State<DoctorAppointment> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _uid = FirebaseAuth.instance.currentUser.uid;
  List<Map<String, dynamic>> appointmentMap;

  @override
  void initState() {
    super.initState();
    getAppointments();
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
      });
    } catch (e) {
      Toast.show("Error Occured", context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text("Today's Appointments"),
      ),
      body: appointmentMap.isEmpty
          ? Container(
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
            )
          : builder(size),
    );
  }

  Widget builder(Size size) {
    return Container(
      height: size.height,
      width: size.width,
      child: ListView.builder(itemBuilder: (context, index) {
        return Container();
      }),
    );
  }
}
