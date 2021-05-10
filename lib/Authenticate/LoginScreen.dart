import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tele_health_app/Authenticate/Account.dart';
import 'package:tele_health_app/Authenticate/DoctorForm.dart';
import 'package:tele_health_app/Authenticate/PaitentForm.dart';
import 'package:tele_health_app/Screens/SubScreens/Doctor/HomeScreen.dart';
import 'package:tele_health_app/Screens/SubScreens/Paitent/HomeScreen.dart';
import 'package:toast/toast.dart';

class LoginScreen extends StatefulWidget {
  final SharedPreferences prefs;
  final int identity;

  const LoginScreen({Key key, this.prefs, this.identity}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String profession = "Profession";
  bool isloading;

  void onLogin() async {
    if (_email.text.isNotEmpty && _password.text.isNotEmpty) {
      if (widget.identity == 1) {
        await widget.prefs.setBool("isPaitent", true);
        logIn(_email.text, _password.text).then((user) {
          if (user != null) {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (_) => CheckIfVerified(
                        prefs: widget.prefs,
                      )),
              (Route<dynamic> route) => false,
            );
          }
        });
      } else if (widget.identity == 2) {
        await widget.prefs.setBool("isPaitent", false);
        logIn(_email.text, _password.text).then((user) {
          if (user != null) {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (_) => HomePage(
                        prefs: widget.prefs,
                      )),
              (Route<dynamic> route) => false,
            );
          }
        });
      }
    } else {
      Toast.show("Please fill form correctly", context, duration: 2);
    }
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
                        onPressed: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (_) => DoctorHomescreen())),
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
                child:
                    textField(size, 'email', Icons.account_box_rounded, _email),
              ),
              SizedBox(
                height: size.height / 40,
              ),
              Container(
                width: size.width,
                alignment: Alignment.center,
                child: textField(size, 'password', Icons.lock, _password),
              ),
              SizedBox(
                height: size.height / 10,
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
              // isloading == true
              //     ? Container()
              //     : Row(
              //         mainAxisAlignment: MainAxisAlignment.center,
              //         children: [
              //           Text(
              //             "I'm a New User,",
              //             style: TextStyle(
              //               fontSize: size.width / 25,
              //               fontWeight: FontWeight.w500,
              //             ),
              //           ),
              //           GestureDetector(
              //             onTap: () => Navigator.of(context).push(
              //                 MaterialPageRoute(builder: (_) => Register())),
              //             child: Text(
              //               "SignUp",
              //               style: TextStyle(
              //                   fontSize: size.width / 25,
              //                   fontWeight: FontWeight.w500,
              //                   color: Colors.blue),
              //             ),
              //           ),
              //         ],
              //       ),
            ],
          ),
        ),
      ),
    );
  }

  Widget textField(Size size, String title, IconData icon,
      TextEditingController controller) {
    return Container(
      width: size.width / 1.1,
      alignment: Alignment.center,
      child: TextField(
        controller: controller,
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
