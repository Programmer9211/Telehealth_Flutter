import 'package:flutter/material.dart';
import 'package:tele_health_app/Authenticate/DoctorForm.dart';
import 'package:tele_health_app/Authenticate/PaitentForm.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  void onLogin() {}
  void onPaitentLogin() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => PaitentForm()));
  }

  void onDoctorLogin() {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => DoctorForm()));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Column(
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
