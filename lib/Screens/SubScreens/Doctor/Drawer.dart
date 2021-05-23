import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tele_health_app/Authenticate/Account.dart';
import 'package:tele_health_app/Screens/SubScreens/Doctor/Appointment.dart';
import 'package:tele_health_app/Screens/SubScreens/Doctor/Schedule.dart';

class DoctorDrawer extends StatelessWidget {
  final String name, email, image;
  final SharedPreferences prefs;
  DoctorDrawer(this.prefs, this.name, this.email, this.image);
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(name),
            accountEmail: Text(email),
            currentAccountPicture: Container(
              height: size.height / 9,
              width: size.width / 3,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: NetworkImage(image != "i"
                        ? image
                        : "https://image.freepik.com/free-vector/cartoon-male-doctor-holding-clipboard_29190-4660.jpg")),
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(
            height: size.height / 50,
          ),
          tile(
            size,
            Icons.schedule,
            "Today's Schedule",
            () {
              Navigator.pop(context);
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => Schedule(),
                ),
              );
            },
          ),
          SizedBox(
            height: size.height / 50,
          ),
          tile(
            size,
            Icons.calendar_today,
            "Today's Appointments",
            () {
              Navigator.pop(context);
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => DoctorAppointment(),
                ),
              );
            },
          ),
          SizedBox(
            height: size.height / 8,
          ),
          InkWell(
            onTap: () => logOut(context, prefs),
            child: Container(
              height: size.height / 20,
              width: size.width / 4.5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  width: 1,
                  color: Colors.black,
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                "Log Out",
                style: TextStyle(
                  fontSize: size.width / 26,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget tile(Size size, IconData icon, String heading, Function function) {
    return InkWell(
      onTap: function,
      child: Material(
        elevation: 4,
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        child: Container(
          height: size.height / 14,
          width: size.width / 1.35,
          child: Row(
            children: [
              SizedBox(width: size.width / 30),
              Icon(icon),
              SizedBox(width: size.width / 30),
              Container(
                width: size.height / 3.8,
                child: Text(
                  heading,
                  style: TextStyle(
                    fontSize: size.width / 25,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey,
                size: size.width / 25,
              )
            ],
          ),
        ),
      ),
    );
  }
}
