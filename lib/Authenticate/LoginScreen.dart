import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tele_health_app/Authenticate/Account.dart';
import 'package:tele_health_app/Authenticate/DoctorForm.dart';
import 'package:tele_health_app/Authenticate/PaitentForm.dart';
import 'package:tele_health_app/Screens/HomeScreen.dart';

class LoginScreen extends StatefulWidget {
  final SharedPreferences prefs;

  const LoginScreen({Key key, this.prefs}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  String profession = "Profession";
  bool isPaitent;

  void onLogin() async {
    await widget.prefs.setBool("isPaitent", isPaitent);
    logIn(_email.text, _password.text).then((user) {
      if (user != null) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (_) => CheckIfVerified(
                      prefs: widget.prefs,
                    )),
            (Route<dynamic> route) => false);
      }
    });
  }

  void onPaitentLogin() {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => PaitentForm(prefs: widget.prefs)));
  }

  void onDoctorLogin() {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => DoctorForm(prefs: widget.prefs)));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: size.height / 8,
            ),
            Text(
              "Login",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: size.height / 15,
            ),
            Container(
              height: size.height / 15,
              width: size.width,
              alignment: Alignment.center,
              child: field(size, "Email", _email),
            ),
            SizedBox(
              height: size.height / 30,
            ),
            Container(
              height: size.height / 15,
              width: size.width,
              alignment: Alignment.center,
              child: field(size, "Password", _password),
            ),
            SizedBox(
              height: size.height / 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  profession,
                  style: TextStyle(
                    fontSize: size.width / 22,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                PopupMenuButton(
                  onSelected: (val) {
                    if (val == 1) {
                      profession = "Doctor";
                      isPaitent = false;
                    } else if (val == 2) {
                      profession = "Paitent";
                      isPaitent = true;
                    }

                    setState(() {});
                  },
                  icon: Icon(
                    Icons.arrow_drop_down,
                  ),
                  itemBuilder: (_) => [
                    PopupMenuItem(
                      child: Text("Doctor"),
                      value: 1,
                    ),
                    PopupMenuItem(
                      child: Text("Paitent"),
                      value: 2,
                    ),
                  ],
                )
              ],
            ),
            SizedBox(
              height: size.height / 10,
            ),
            ElevatedButton(
              onPressed: onLogin,
              child: Text(
                "Login",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
              ),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 14, horizontal: 35),
                primary: Colors.indigo,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            SizedBox(
              height: size.height / 20,
            ),
            Text(
              "sign up",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: size.height / 32,
            ),
            Text(
              "as",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: size.height / 30,
            ),
            Container(
              height: size.height / 10,
              width: size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  customButton("Paitent", onPaitentLogin),
                  customButton("Doctor", onDoctorLogin),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget customButton(String text, Function func) {
    return ElevatedButton(
      onPressed: func,
      child: Text(
        text,
        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
      ),
      style: ElevatedButton.styleFrom(
          primary: Colors.black,
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 25)),
    );
  }

  Widget field(Size size, String text, TextEditingController controller) {
    return Container(
      height: size.height / 15,
      width: size.width / 1.2,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: text,
        ),
      ),
    );
  }
}
