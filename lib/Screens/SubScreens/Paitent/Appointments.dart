import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tele_health_app/Screens/SubScreens/Paitent/ViewProfile.dart';
import 'package:tele_health_app/pages/call.dart';
import 'package:toast/toast.dart';

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

  Future<void> _handleCameraAndMic(Permission permission) async {
    final status = await permission.request();
    print(status);
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
                        image: DecorationImage(
                          image: NetworkImage(
                              "https://image.freepik.com/free-vector/cartoon-male-doctor-holding-clipboard_29190-4660.jpg"),
                          fit: BoxFit.cover,
                        )),
                  ),
                  SizedBox(
                    width: size.width / 12,
                  ),
                  Column(
                    children: [
                      Container(
                        width: size.width / 1.8,
                        child: Text(
                          appointmentList[index]['name'],
                          style: TextStyle(
                            fontSize: size.width / 22,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Container(
                        width: size.width / 1.8,
                        child: Text(
                          "Time : ${appointmentList[index]['time']}",
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
                  customeButton(size, "Join Call", Colors.green, () async {
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
                    width: size.width / 10,
                  ),
                  customeButton(
                      size,
                      "Doctor Profile",
                      Colors.blueAccent,
                      () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => ViewProfile(
                                uid: appointmentList[index]['uid'],
                              ),
                            ),
                          )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget customeButton(Size size, String name, Color color, Function function) {
    return GestureDetector(
      onTap: function,
      child: Material(
        elevation: 4,
        borderRadius: BorderRadius.circular(10),
        color: Colors.blueAccent,
        child: Container(
          height: size.height / 18,
          width: size.width / 3,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: color,
          ),
          alignment: Alignment.center,
          child: Text(
            name,
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
