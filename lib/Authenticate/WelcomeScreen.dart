import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tele_health_app/Authenticate/DoctorForm.dart';
import 'package:tele_health_app/Authenticate/LoginScreen.dart';
import 'package:tele_health_app/Authenticate/PaitentForm.dart';

class WelcomeScreen extends StatefulWidget {
  final SharedPreferences prefs;
  WelcomeScreen({this.prefs});

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final String imageUrl =
      "https://media.istockphoto.com/vectors/doctors-team-vector-id846455730?k=6&m=846455730&s=612x612&w=0&h=wyYmI-1lijrjpBlkahqgl6Q0K1KrR2pX8FfHp6Jfwbk=";

  List<bool> isSelected = [true, false];
  int currentIndex = 0;
  PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(
            height: size.height / 20,
          ),
          Container(
            height: size.height / 3.5,
            width: size.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(imageUrl),
              ),
            ),
          ),
          SizedBox(
            height: size.height / 10,
          ),
          Text(
            "Welcome to telehealth app",
            style: TextStyle(
              fontSize: size.width / 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(
            height: size.height / 40,
          ),
          Text(
            "Create an account to save your data\n and access it from multiple devices",
            style: TextStyle(
              fontSize: size.width / 22,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
          SizedBox(
            height: size.height / 20,
          ),
          Container(
            height: size.height / 16,
            width: size.width / 1.6,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.pinkAccent,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                button(size, "Login", isSelected[0]),
                button(size, "Sign In", isSelected[1]),
              ],
            ),
          ),
          pageView(size),
        ],
      ),
    );
  }

  Widget button(Size size, String text, bool isSelect) {
    return InkWell(
      onTap: () {
        if (text == "Login") {
          isSelected[0] = true;
          isSelected[1] = false;
          _controller.animateToPage(0,
              duration: Duration(milliseconds: 200), curve: Curves.ease);
        } else {
          isSelected[0] = false;
          isSelected[1] = true;
          _controller.animateToPage(1,
              duration: Duration(milliseconds: 200), curve: Curves.ease);
        }
        setState(() {});
      },
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Container(
          height: size.height / 18,
          width: size.width / 3.5,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: isSelect ? Colors.white : Colors.pinkAccent,
          ),
          alignment: Alignment.center,
          child: Text(
            text,
            style: TextStyle(
                color: isSelect ? Colors.pink : Colors.white,
                fontSize: size.width / 25,
                fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }

  Widget customButton(
      Size size, String text, IconData icon, Function function) {
    return GestureDetector(
      onTap: function,
      child: Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
        child: Container(
            height: size.height / 14,
            width: size.width / 1.2,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: Row(
              children: [
                SizedBox(
                  width: size.width / 30,
                ),
                Icon(icon),
                SizedBox(
                  width: size.width / 10,
                ),
                Text(
                  text,
                  style: TextStyle(
                    fontSize: size.width / 20,
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            )),
      ),
    );
  }

  Widget pageViewContent(Size size) {
    return Container(
      height: size.height / 3.4,
      width: size.width / 1.1,
      child: currentIndex == 0
          ? Column(
              children: [
                gap(size),
                customButton(
                  size,
                  "Login as Paitent",
                  Icons.account_box,
                  () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => LoginScreen(
                        identity: 1,
                        prefs: widget.prefs,
                      ),
                    ),
                  ),
                ),
                gap(size),
                customButton(
                  size,
                  "Login as Doctor",
                  Icons.dock_outlined,
                  () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => LoginScreen(
                        identity: 2,
                        prefs: widget.prefs,
                      ),
                    ),
                  ),
                ),
                gap(size),
                customButton(
                  size,
                  "Login as Admin",
                  Icons.admin_panel_settings,
                  () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => LoginScreen(
                        prefs: widget.prefs,
                        identity: 3,
                      ),
                    ),
                  ),
                ),
              ],
            )
          : Column(
              children: [
                SizedBox(
                  height: size.height / 20,
                ),
                customButton(
                  size,
                  "SignIn as Paitent",
                  Icons.account_box,
                  () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => PaitentForm(),
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height / 20,
                ),
                customButton(
                  size,
                  "SignIn as Doctor",
                  Icons.dock,
                  () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => DoctorForm(
                        prefs: widget.prefs,
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Widget pageView(Size size) {
    return Container(
      height: size.height / 3.4,
      width: size.width / 1.1,
      child: PageView(
        controller: _controller,
        onPageChanged: (val) {
          setState(() {
            currentIndex = val;
          });
        },
        children: [
          pageViewContent(size),
          pageViewContent(size),
        ],
      ),
    );
  }

  Widget gap(Size size) {
    return SizedBox(
      height: size.height / 40,
    );
  }
}
