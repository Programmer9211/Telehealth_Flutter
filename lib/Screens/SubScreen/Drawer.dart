import 'package:flutter/material.dart';
import 'package:tele_health_app/Authenticate/Account.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Drawer(
      child: Column(
        children: [
          SizedBox(
            height: size.height / 10,
          ),
          drawerItems(size, "Home"),
          drawerItems(size, "Notifications"),
          drawerItems(size, "Appointment History"),
          drawerItems(size, "Manage Profile"),
          drawerItems(size, "Chat Bot"),
          drawerItems(size, "Help and Support"),
          drawerItems(size, "About Us"),
          SizedBox(
            height: size.height / 10,
          ),
          InkWell(
            onTap: () => logOut(context),
            child: Container(
              height: size.height / 18,
              width: size.width / 2.9,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  width: 1.5,
                  color: Colors.black,
                ),
              ),
              child: Text(
                "Sign Out",
                style: TextStyle(
                  fontSize: size.width / 23,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget drawerItems(Size size, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: InkWell(
        onTap: () {},
        child: Container(
          height: size.height / 14,
          width: size.width,
          alignment: Alignment.center,
          color: Colors.indigo[100],
          child: Text(
            text,
            style: TextStyle(fontSize: size.width / 20),
          ),
        ),
      ),
    );
  }
}
