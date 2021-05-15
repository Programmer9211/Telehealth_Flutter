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

  void onCreateAccount() async {
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
    };

    FirebaseFirestore firestore = FirebaseFirestore.instance;

    createAccount(_email.text, _password.text, context).then((user) async {
      await firestore
          .collection('doctor')
          .doc(user.uid)
          .set(userMap)
          .then((value) {
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
