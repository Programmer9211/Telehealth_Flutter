import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tele_health_app/Authenticate/Account.dart';
import 'package:tele_health_app/Screens/SubScreens/Paitent/HomeScreen.dart';

class DoctorForm extends StatefulWidget {
  final SharedPreferences prefs;
  DoctorForm({this.prefs});

  @override
  _DoctorFormState createState() => _DoctorFormState();
}

class _DoctorFormState extends State<DoctorForm> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _mob = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _qualification = TextEditingController();
  final TextEditingController _ed = TextEditingController();
  final TextEditingController _fee = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _experience = TextEditingController();
  String category = "Category";

  void onCreateAccount() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    createAccount(_name.text, _email.text, _password.text, context)
        .then((user) async {
      Map<String, dynamic> userMap = {
        "name": _name.text,
        "mob": _mob.text,
        "email": _email.text,
        "qualification": _qualification.text,
        "ed": _ed.text,
        "experience": _experience.text,
        "fee": _fee.text,
        "password": _password.text,
        "isverified": false,
        "image": "i",
        "uid": user.uid,
      };

      await firestore
          .collection('doctor')
          .doc(user.uid)
          .set(userMap)
          .then((value) async {
        await firestore.collection(category).add(userMap);

        await firestore
            .collection("admin")
            .doc('LLOFlbON1rRcZ2rrzCBYwQL00As1')
            .collection('verification')
            .add({
          "name": _name.text,
          "uid": user.uid,
        });

        for (int i = 10; i < 12; i++) {
          Map<String, dynamic> scheduleMap = {
            "isappointed": false,
            "isavalible": true,
            "time": "$i am",
          };

          await firestore
              .collection('doctor')
              .doc(user.uid)
              .collection('schedule')
              .add(scheduleMap);
        }

        for (int i = 1; i <= 6; i++) {
          Map<String, dynamic> scheduleMap = {
            "isappointed": false,
            "isavalible": true,
            "time": "$i pm",
          };

          await firestore
              .collection('doctor')
              .doc(user.uid)
              .collection('schedule')
              .add(scheduleMap);
        }

        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (_) => CheckIfVerified()),
            (Route<dynamic> route) => false);
      });
      await widget.prefs.setInt('identity', 2);
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: size.height / 16,
                width: size.width,
                alignment: Alignment.bottomCenter,
                child: Text(
                  "Doctor Signup",
                  style: TextStyle(
                    color: Colors.indigo,
                    fontSize: 26,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              fieldContainer(size, "Name", _name),
              fieldContainer(size, "Mobile No.", _mob),
              fieldContainer(size, "Email Id", _email),
              fieldContainer(size, "Qualification", _qualification),
              fieldContainer(size, "Expertised Domain", _ed),
              fieldContainer(size, "Experience", _experience),
              fieldContainer(size, "Fee/hr", _fee),
              fieldContainer(size, "Password", _password),
              Container(
                height: size.height / 9.2,
                width: size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Select Category",
                      style: TextStyle(
                        fontSize: size.width / 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: size.height / 70,
                    ),
                    Container(
                      height: size.height / 18,
                      width: size.width / 1.15,
                      decoration: BoxDecoration(
                        border: Border.all(width: 0.5, color: Colors.black),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: size.width / 1.4,
                            alignment: Alignment.center,
                            child: Text(category),
                          ),
                          PopupMenuButton(
                            onSelected: (val) {
                              if (val == 1) {
                                category = "ent";
                              } else if (val == 2) {
                                category = "allergist";
                              } else if (val == 3) {
                                category = "dermatologist";
                              } else {
                                category = "infectious disease";
                              }
                              setState(() {});
                            },
                            icon: Icon(Icons.arrow_drop_down),
                            itemBuilder: (_) => [
                              PopupMenuItem(child: Text("ENT"), value: 1),
                              PopupMenuItem(child: Text("Allergist"), value: 2),
                              PopupMenuItem(
                                  child: Text("Dermatologist"), value: 3),
                              PopupMenuItem(
                                  child: Text("Infectious Disease"), value: 4),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: onCreateAccount,
                child: Text(
                  "Create Account",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                ),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                  primary: Colors.indigo,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget fieldContainer(
      Size size, String text, TextEditingController controller) {
    return Container(
      height: size.height / 9.2,
      width: size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: TextStyle(
              fontSize: size.width / 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(
            height: size.height / 70,
          ),
          Container(
            height: size.height / 18,
            width: size.width / 1.15,
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
