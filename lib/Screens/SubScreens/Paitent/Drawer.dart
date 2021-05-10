import 'package:flutter/material.dart';
import 'package:tele_health_app/Screens/SubScreens/Paitent/Appointments.dart';
import 'package:tele_health_app/Screens/SubScreens/Paitent/AvalibleDoctors.dart';
import 'package:tele_health_app/Screens/SubScreens/Paitent/Chat%20Bot/Chatbot.dart';
import 'package:tele_health_app/Screens/SubScreens/Paitent/MedicalRecord.dart';
import 'package:tele_health_app/Screens/SubScreens/Paitent/Profile.dart';
import 'package:tele_health_app/Screens/SubScreens/Paitent/consult.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text("Aditya"),
            accountEmail: Text("adityachaudhary@gmail.com"),
            decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(10),
                )),
          ),
          tile(size, Icons.account_circle, "Profile", () {
            Navigator.pop(context);
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => Profile(),
              ),
            );
          }),
          SizedBox(
            height: size.height / 60,
          ),
          tile(size, Icons.edit, "Appointment", () {
            Navigator.pop(context);
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => Appointments(),
              ),
            );
          }),
          SizedBox(
            height: size.height / 60,
          ),
          tile(size, Icons.message, "Chat Bot", () {
            Navigator.pop(context);
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => ChatBot(),
              ),
            );
          }),
          SizedBox(
            height: size.height / 60,
          ),
          tile(size, Icons.data_usage_rounded, "Medical Records", () {
            Navigator.pop(context);
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => MedicalReport(),
              ),
            );
          }),
          SizedBox(
            height: size.height / 60,
          ),
          tile(size, Icons.event_available, "Avalible Doctors", () {
            Navigator.pop(context);
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => AvalibleDoctors(),
              ),
            );
          }),
          SizedBox(
            height: size.height / 60,
          ),
          // tile(size, Icons.dock, "Consult a Doctor", () {
          //   Navigator.pop(context);
          //   Navigator.of(context).push(
          //     MaterialPageRoute(
          //       builder: (_) => ConsulatDoctor(),
          //     ),
          //   );
          // }),
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