import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tele_health_app/Screens/SubScreens/Paitent/Profile.dart';

class Prescription extends StatefulWidget {
  const Prescription({Key key}) : super(key: key);

  @override
  _PrescriptionState createState() => _PrescriptionState();
}

class _PrescriptionState extends State<Prescription> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Map<String, dynamic>> _prescriptionList;

  void getPrescription() async {
    List<DocumentSnapshot> _snap = [];

    await _firestore
        .collection('paitent')
        .doc(_auth.currentUser.uid)
        .collection('prescription')
        .get()
        .then((value) {
      _snap = value.docs;

      _prescriptionList = _snap.map((e) => e.data()).toList();
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    getPrescription();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    if (_prescriptionList != null) {
      if (_prescriptionList.length > 0) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Prescription"),
            backgroundColor: Color.fromRGBO(55, 82, 178, 1),
          ),
          body: ListView.builder(
            itemCount: 1,
            itemBuilder: (context, index) {
              return Container(
                height: size.height / 3.5,
                width: size.width,
                alignment: Alignment.center,
                child: Material(
                  elevation: 4,
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  child: Container(
                    height: size.height / 5,
                    width: size.width / 1.1,
                    child: Column(
                      children: [
                        SizedBox(
                          height: size.height / 70,
                        ),
                        Container(
                          height: size.height / 30,
                          width: size.width / 1.2,
                          child: Text(
                            _prescriptionList[index]['name'],
                            style: TextStyle(
                              fontSize: size.width / 22,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Container(
                          height: size.height / 20,
                          width: size.width / 1.2,
                          alignment: Alignment.center,
                          child: Text(
                            "${_prescriptionList[index]['name']}, Has Prescribed you medicine check out",
                            style: TextStyle(
                              fontSize: size.width / 26,
                              color: Colors.grey,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: size.height / 30,
                        ),
                        InkWell(
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => ViewImage(
                                imageUrl: _prescriptionList[index]['url'],
                              ),
                            ),
                          ),
                          child: Material(
                            elevation: 5,
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.blue,
                            child: Container(
                              height: size.height / 18,
                              width: size.width / 1.2,
                              alignment: Alignment.center,
                              child: Text(
                                "View Prescription",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: size.width / 25,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      } else {
        return Scaffold(
          appBar: AppBar(
            title: Text("Prescription"),
            backgroundColor: Color.fromRGBO(55, 82, 178, 1),
          ),
          body: Center(
            child: Text(
              "No Prescriptons Yet!",
              style: TextStyle(
                fontSize: size.width / 22,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        );
      }
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text("Prescription"),
          backgroundColor: Color.fromRGBO(55, 82, 178, 1),
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
}
