import 'package:flutter/material.dart';
import 'package:tele_health_app/Screens/HomeScreen.dart';

class PaitentForm extends StatelessWidget {
  void onCreateAccount(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => HomePage()));
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
              fieldContainer(size, "Name"),
              fieldContainer(size, "Mobile No."),
              fieldContainer(size, "Email Id"),
              fieldContainer(size, "Date Of Birth"),
              fieldContainer(size, "Gender"),
              fieldContainer(size, "Blood Group"),
              fieldContainer(size, "Height"),
              fieldContainer(size, "Password"),
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

  Widget fieldContainer(Size size, String text) {
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
