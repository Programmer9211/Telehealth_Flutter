import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tele_health_app/Screens/SubScreen/Appointment.dart';
import 'package:tele_health_app/Screens/SubScreen/Chat%20Bot/Chatbot.dart';
import 'package:tele_health_app/Screens/SubScreen/Drawer.dart';
import 'package:tele_health_app/Screens/SubScreen/Home.dart';
import 'package:tele_health_app/Screens/SubScreen/Notification.dart';
import 'package:tele_health_app/Screens/SubScreen/Profile.dart';
import 'package:tele_health_app/Screens/Verified.dart';

class HomePage extends StatefulWidget {
  final SharedPreferences prefs;
  HomePage({this.prefs});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int currentIndex = 0;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  Map<String, dynamic> profileSnap;

  void getProfileData() async {
    await firestore
        .collection(widget.prefs.getBool('isPaitent') ? 'paitent' : 'doctor')
        .doc(auth.currentUser.uid)
        .get()
        .then((snap) {
      setState(() {
        if (snap != null) {
          profileSnap = snap.data();
          print(profileSnap);
        }
      });
    });
  }

  @override
  void initState() {
    getProfileData();
    super.initState();
  }

  void onNotificationTap() {
    setState(() {
      currentIndex = 2;
    });
  }

  void onBookApointment() {
    setState(() {
      currentIndex = 1;
    });
  }

  void onChatBotTap() {
    setState(() {
      currentIndex = 3;
    });
  }

  void openDrawer() {
    _scaffoldKey.currentState.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        drawer: AppDrawer(),
        body: Builder(builder: (_) {
          if (currentIndex == 0) {
            return Home(
              onAppointmentTap: onBookApointment,
              onChatBotTap: onChatBotTap,
              openDrawer: openDrawer,
              onNotificaationTap: onNotificationTap,
            );
          } else if (currentIndex == 1) {
            return Appointment(
              openDrawer: openDrawer,
              onNotifications: onNotificationTap,
            );
          } else if (currentIndex == 2) {
            return Notifications(
              openDrawer: openDrawer,
            );
          } else if (currentIndex == 3) {
            return ChatBot(
              openDrawer: openDrawer,
            );
          } else {
            return Profile(
              openDrawer: openDrawer,
              userMap: profileSnap,
            );
          }
        }),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.blue[100],
          showSelectedLabels: true,
          unselectedItemColor: Colors.black,
          selectedItemColor: Colors.black,
          showUnselectedLabels: true,
          selectedLabelStyle: TextStyle(
              fontSize: MediaQuery.of(context).size.width / 29,
              fontWeight: FontWeight.w500),
          unselectedLabelStyle: TextStyle(
            fontSize: MediaQuery.of(context).size.width / 29,
            fontWeight: FontWeight.w500,
          ),
          onTap: (val) {
            setState(() {
              currentIndex = val;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today),
              label: "Appointment",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications),
              label: "Notification",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat),
              label: "Chat Bot",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_box),
              label: "Profile",
            ),
          ],
        ),
      ),
    );
  }
}

class CheckIfVerified extends StatefulWidget {
  final SharedPreferences prefs;

  CheckIfVerified({this.prefs});

  @override
  _CheckIfVerifiedState createState() => _CheckIfVerifiedState();
}

class _CheckIfVerifiedState extends State<CheckIfVerified> {
  @override
  void initState() {
    super.initState();
    getProfileData();
  }

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  Map<String, dynamic> profileSnap;

  void getProfileData() async {
    if (widget.prefs.getBool('isPaitent') == false) {
      await firestore
          .collection('doctor')
          .doc(auth.currentUser.uid)
          .get()
          .then((snap) {
        setState(() {
          if (snap != null) {
            profileSnap = snap.data();
            print(profileSnap);
          }
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.prefs.getBool('isPaitent') == false) {
      if (profileSnap != null) {
        if (profileSnap['isverified'] == false) {
          return Verify();
        } else {
          return HomePage(
            prefs: widget.prefs,
          );
        }
      } else {
        return Container();
      }
    } else {
      return HomePage(
        prefs: widget.prefs,
      );
    }
  }
}
