import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tele_health_app/Screens/SubScreens/Paitent/Profile.dart';
import 'package:tele_health_app/pages/call.dart';
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

  Future<void> _handleCameraAndMic(Permission permission) async {
    final status = await permission.request();
    print(status);
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
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: size.height / 10,
                    width: size.height / 10,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.blue,
                    ),
                  ),
                  SizedBox(
                    width: size.width / 16,
                  ),
                  Column(
                    children: [
                      Container(
                        width: size.width / 1.8,
                        child: Text(
                          appointmentMap[index]['name'],
                          style: TextStyle(
                            fontSize: size.width / 22,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Container(
                        width: size.width / 1.8,
                        child: Text(
                          "Time : ${appointmentMap[index]['time']}",
                          style: TextStyle(
                            fontSize: size.width / 22,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: size.height / 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  customButton(size, index, "Join Call", Colors.green,
                      () async {
                    await _handleCameraAndMic(Permission.camera);
                    await _handleCameraAndMic(Permission.microphone);

                    if (await Permission.camera.isGranted &&
                        await Permission.microphone.isGranted) {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (_) => CallPage(
                            channelName: "join",
                            role: ClientRole.Broadcaster,
                          ),
                        ),
                      );
                    } else {
                      Toast.show("Please Allow Permission", context);
                      await _handleCameraAndMic(Permission.camera);
                      await _handleCameraAndMic(Permission.microphone);
                    }
                  }),
                  SizedBox(
                    width: size.width / 20,
                  ),
                  customButton(size, index, "Medical History",
                      Colors.blueAccent, () => getMedicalHistory(index)),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget customButton(
      Size size, int index, String title, Color color, Function function) {
    return GestureDetector(
      onTap: function,
      child: Material(
        elevation: 4,
        borderRadius: BorderRadius.circular(10),
        color: Colors.blueAccent,
        child: Container(
          height: size.height / 18,
          width: size.width / 2.8,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: color,
          ),
          alignment: Alignment.center,
          child: Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: size.width / 22,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
