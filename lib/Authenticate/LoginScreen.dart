import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tele_health_app/Authenticate/Account.dart';
import 'package:tele_health_app/Screens/SubScreens/Admin/HomeScreen.dart';
import 'package:tele_health_app/Screens/SubScreens/Paitent/HomeScreen.dart';
import 'package:toast/toast.dart';

class LoginScreen extends StatefulWidget {
  final SharedPreferences prefs;
  final int identity;

  const LoginScreen({Key key, this.identity, this.prefs}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _reset = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String profession = "Profession";
  bool isloading = false;

  void onLogin() async {
    if (_email.text.isNotEmpty && _password.text.isNotEmpty) {
      setState(() {
        isloading = true;
      });

      if (widget.identity == 2) {
        logIn(_email.text, _password.text, context).then((user) async {
          if (user != null) {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (_) => CheckIfVerified(
                        prefs: widget.prefs,
                      )),
              (Route<dynamic> route) => false,
            );
            await widget.prefs.setInt('identity', 2);
            setState(() {
              isloading = false;
            });
          }
        });
      } else if (widget.identity == 1) {
        logIn(_email.text, _password.text, context).then((user) async {
          if (user != null) {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (_) => HomePage(
                        prefs: widget.prefs,
                      )),
              (Route<dynamic> route) => false,
            );
            await widget.prefs.setInt('identity', 1);
            setState(() {
              isloading = false;
            });
          }
        });
      } else if (widget.identity == 3) {
        logIn(_email.text, _password.text, context).then((user) async {
          if (user != null) {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (_) => AdminHomeScreen(widget.prefs)),
              (Route<dynamic> route) => false,
            );
            await widget.prefs.setInt('identity', 3);
            setState(() {
              isloading = false;
            });
          }
        });
      }
    } else {
      Toast.show("Please fill form correctly", context, duration: 2);
    }
  }

  void onForgotPassword() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        title: Text(
          "Enter Gmail",
          style: TextStyle(),
        ),
        content: TextField(
          controller: _reset,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              if (_reset.text.isNotEmpty) {
                Navigator.pop(context);
                try {
                  _auth.sendPasswordResetEmail(email: _reset.text).then(
                        (value) => Toast.show("Link Send Sucessfully", context),
                      );
                } catch (e) {
                  print(e);
                }
                _reset.clear();
              } else {
                Toast.show("Please Enter a valid gmail", context);
              }
            },
            child: Text("Done"),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () {
        if (isloading == true) {
        } else {
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        key: _scaffoldKey,
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: size.height / 20,
              ),
              isloading == true
                  ? Container(
                      height: size.height / 20,
                      width: size.width,
                    )
                  : Container(
                      height: size.height / 20,
                      width: size.width,
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        icon: Icon(
                          Icons.arrow_back_ios_outlined,
                        ),
                        //onPressed: () => Navigator.pop(context),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
              SizedBox(
                height: size.height / 20,
              ),
              Container(
                width: size.width / 1.1,
                child: Text(
                  "Welcome,",
                  style: TextStyle(
                    fontSize: size.width / 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                width: size.width / 1.1,
                child: Text(
                  "Sign In to Continue!",
                  style: TextStyle(
                      fontSize: size.width / 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[700]),
                ),
              ),
              SizedBox(
                height: size.height / 15,
              ),
              Container(
                width: size.width,
                alignment: Alignment.center,
                child: textField(
                    size, 'email', Icons.account_box_rounded, _email, false),
              ),
              SizedBox(
                height: size.height / 40,
              ),
              Container(
                width: size.width,
                alignment: Alignment.center,
                child: textField(size, 'password', Icons.lock, _password, true),
              ),
              Container(
                height: size.height / 30,
                width: size.width / 1.2,
                alignment: Alignment.bottomRight,
                child: GestureDetector(
                  onTap: onForgotPassword,
                  child: Text(
                    "Forgot Password?",
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: size.height / 25,
              ),
              Material(
                elevation: 10,
                color: Colors.blue,
                borderRadius: BorderRadius.circular(8),
                child: GestureDetector(
                  onTap: onLogin,
                  child: Container(
                    height: size.height / 12.5,
                    width: size.width / 1.2,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: isloading == true
                        ? CircularProgressIndicator(
                            backgroundColor: Colors.white,
                          )
                        : Text(
                            'Login',
                            style: TextStyle(
                              fontSize: size.width / 22,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                  ),
                ),
              ),
              SizedBox(
                height: size.height / 4.5,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget textField(Size size, String title, IconData icon,
      TextEditingController controller, bool isobsecure) {
    return Container(
      width: size.width / 1.1,
      alignment: Alignment.center,
      child: TextField(
        controller: controller,
        obscureText: isobsecure,
        obscuringCharacter: "*",
        decoration: InputDecoration(
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          labelText: title,
        ),
      ),
    );
  }
}
