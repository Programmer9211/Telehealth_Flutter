//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tele_health_app/Authenticate/Account.dart';
import 'package:tele_health_app/Screens/SubScreens/Paitent/HomeScreen.dart';

class PaitentForm extends StatefulWidget {
  final SharedPreferences prefs;
  PaitentForm({this.prefs});

  @override
  _PaitentFormState createState() => _PaitentFormState();
}

class _PaitentFormState extends State<PaitentForm> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _mob = TextEditingController();
  final TextEditingController _bg = TextEditingController();
  final TextEditingController _height = TextEditingController();
  final TextEditingController _weight = TextEditingController();

  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void onCreateAccount(BuildContext context) async {
    Map<String, dynamic> map = {
      "name": _name.text,
      "mob": _mob.text,
      "email": _email.text,
      "dob": todayDate,
      "gender": gender,
      "bg": _bg.text,
      "height": _height.text,
      "weight": _weight.text,
      "password": _password.text,
      "image": ""
    };

    createAccount(_name.text, _email.text, _password.text, context)
        .then((user) async {
      await _firestore.collection('paitent').doc(user.uid).set(map);
      await widget.prefs.setInt('identity', 1);
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => HomePage(
            prefs: widget.prefs,
          ),
        ),
      );
    });
  }

  DateTime todayDate = DateTime(2000);
  String gender = "Gender";

  Future selectDate() async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime(2021),
    );

    if (picked != null && picked != todayDate) {
      setState(() {
        todayDate = picked;
      });
    }
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
                  "Paitent Signup",
                  style: TextStyle(
                    color: Colors.indigo,
                    fontSize: 26,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              fieldContainer(size, "Name", "", _name),
              fieldContainer(size, "Mobile No.", "", _mob),
              fieldContainer(size, "Email Id", "", _email),
              InkWell(
                onTap: selectDate,
                child: Container(
                  height: size.height / 9.2,
                  width: size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Date Of Birth",
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
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              width: 1.0,
                              color: Colors.grey[400],
                            )),
                        child: Text(
                          "$todayDate".split(' ')[0],
                          style: TextStyle(
                            fontSize: size.width / 25,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              dropDownButton(size),
              fieldContainer(size, "Blood Group", "", _bg),
              heightWeight(size),
              fieldContainer(size, "Password", "Enter Password", _password),
              ElevatedButton(
                onPressed: () => onCreateAccount(context),
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

  Widget heightWeight(Size size) {
    return Container(
      height: size.height / 9.2,
      width: size.width,
      child: Row(
        children: [
          Container(
            height: size.height / 9.2,
            width: size.width / 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Height",
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
                  width: size.width / 2.5,
                  child: TextField(
                    controller: _height,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: size.height / 9.2,
            width: size.width / 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Weight",
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
                  width: size.width / 2.5,
                  child: TextField(
                    controller: _weight,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget dropDownButton(Size size) {
    return Container(
      height: size.height / 9.2,
      width: size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Gender",
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
              alignment: Alignment.centerRight,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    width: 1.0,
                    color: Colors.grey[400],
                  )),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    gender,
                    style: TextStyle(
                      fontSize: size.width / 22,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  PopupMenuButton(
                    onSelected: (val) {
                      if (val == 1) {
                        gender = "Male";
                      } else if (val == 2) {
                        gender = "Female";
                      } else if (val == 3) {
                        gender = "Others";
                      }

                      setState(() {});
                    },
                    icon: Icon(
                      Icons.arrow_drop_down,
                    ),
                    itemBuilder: (_) => [
                      PopupMenuItem(
                        child: Text("Male"),
                        value: 1,
                      ),
                      PopupMenuItem(
                        child: Text("Female"),
                        value: 2,
                      ),
                      PopupMenuItem(
                        child: Text("Others"),
                        value: 3,
                      ),
                    ],
                  )
                ],
              )),
        ],
      ),
    );
  }

  Widget fieldContainer(Size size, String text, String hintText,
      TextEditingController controller) {
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
                hintText: hintText,
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

  @override
  void dispose() {
    _name.dispose();
    _mob.dispose();
    _email.dispose();
    _height.dispose();
    _weight.dispose();
    _bg.dispose();
    _password.dispose();
    super.dispose();
  }
}
