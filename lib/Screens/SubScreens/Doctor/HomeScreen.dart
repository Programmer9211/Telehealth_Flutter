import 'package:flutter/material.dart';

class DoctorHomescreen extends StatefulWidget {
  @override
  _DoctorHomescreenState createState() => _DoctorHomescreenState();
}

class _DoctorHomescreenState extends State<DoctorHomescreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            header(size),
          ],
        ),
      ),
    );
  }

  Widget header(Size size) {
    return Container(
      width: size.width,
      alignment: Alignment.center,
      child: Container(
        height: size.height / 10,
        width: size.width / 1.1,
        alignment: Alignment.centerLeft,
        child: InkWell(
          onTap: () => _scaffoldKey.currentState.openDrawer(),
          child: Icon(Icons.menu),
        ),
      ),
    );
  }
}
