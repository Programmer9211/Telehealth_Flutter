import 'package:flutter/material.dart';
import 'package:tele_health_app/Screens/SubScreen/Appointment.dart';
import 'package:tele_health_app/Screens/SubScreen/Chatbot.dart';
import 'package:tele_health_app/Screens/SubScreen/Drawer.dart';
import 'package:tele_health_app/Screens/SubScreen/Home.dart';
import 'package:tele_health_app/Screens/SubScreen/Notification.dart';
import 'package:tele_health_app/Screens/SubScreen/Profile.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    widgets = [
      Home(
        onAppointmentTap: onBookApointment,
        onChatBotTap: onChatBotTap,
        openDrawer: openDrawer,
      ),
      Appointment(
        openDrawer: openDrawer,
      ),
      Notifications(
        openDrawer: openDrawer,
      ),
      ChatBot(
        openDrawer: openDrawer,
      ),
      Profile(
        openDrawer: openDrawer,
      ),
    ];
  }

  List<Widget> widgets;

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
        body: widgets[currentIndex],
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
