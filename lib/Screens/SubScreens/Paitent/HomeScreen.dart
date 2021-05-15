import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tele_health_app/Screens/SubScreens/Doctor/HomeScreen.dart';
import 'package:tele_health_app/Screens/SubScreens/Paitent/AvalibleDoctors.dart';
import 'package:tele_health_app/Screens/SubScreens/Paitent/Drawer.dart';
import 'package:tele_health_app/Screens/SubScreens/Paitent/Profile.dart';
import 'package:tele_health_app/Screens/SubScreens/Paitent/Search.dart';
import 'package:toast/toast.dart';

import '../Doctor/Verified.dart';

class HomePage extends StatefulWidget {
  final SharedPreferences prefs;
  HomePage({this.prefs});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;
  List<Data> itemdata;

  @override
  void initState() {
    super.initState();
    itemdata = data();
    getUserInfo();
  }

  Map<String, dynamic> userMap = {};

  void getUserInfo() async {
    await _firestore
        .collection('paitent')
        .doc(_auth.currentUser.uid)
        .get()
        .then((value) {
      setState(() {
        userMap = value.data();
      });
      print(userMap);
    });
  }

  List<Data> data() {
    List<Data> itemdata = [
      Data(
        text: "Video Call",
        imageUrl: "assets/1.png",
        func: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => AvalibleDoctors(),
          ),
        ),
      ),
      // Data(
      //   text: "Clinic visit",
      //   imageUrl: "assets/2.png",
      //   func: () {
      //     Toast.show("Not Avalible Now", context);
      //   },
      // ),
      // Data(
      //   text: "Ambulance",
      //   imageUrl: "assets/3.png",
      //   func: () {
      //     Toast.show("Not Avalible Now", context);
      //   },
      // ),
    ];
    return itemdata;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        drawer: AppDrawer(
          profileFunction: getUserInfo,
          userMap: userMap,
          prefs: widget.prefs,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              header(size),
              Container(
                width: size.width / 1.1,
                child: Text(
                  "Appointment with\na doctor",
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: size.height / 30,
              ),
              searchField(size),
              SizedBox(
                height: size.height / 18,
              ),
              Container(
                width: size.width / 1.1,
                child: Text(
                  "How can we help you?",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(
                height: size.height / 30,
              ),
              helpWidgeBuilder(size),
              SizedBox(
                height: size.height / 30,
              ),
              Container(
                width: size.width / 1.1,
                child: Text(
                  "Popular Categories",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(
                height: size.height / 60,
              ),
              categoriesBuilder(size, "Fever", "Headache"),
              SizedBox(
                height: size.height / 30,
              ),
              categoriesBuilder(size, "Cough", "Cold"),
              SizedBox(
                height: size.height / 25,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget categoriesBuilder(Size size, String text1, String text2) {
    return Container(
      height: size.height / 5,
      width: size.width,
      child: Row(
        children: [
          categoriesItems(size, "assets/1.png", text1, Colors.white),
          categoriesItems(
            size,
            "assets/2.png",
            text2,
            Color.fromRGBO(55, 82, 178, 1),
          ),
        ],
      ),
    );
  }

  Widget helpWidgeBuilder(Size size) {
    return Container(
      height: size.height / 6,
      width: size.width,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: itemdata.length,
          itemBuilder: (context, index) {
            return items(
              size,
              index,
            );
          }),
    );
  }

  Widget items(Size size, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10.0,
        vertical: 5,
      ),
      child: InkWell(
        onTap: itemdata[index].func,
        child: Material(
          elevation: 5,
          borderRadius: BorderRadius.circular(20),
          child: Container(
            height: size.height / 8,
            width: size.width / 3.5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: size.height / 19,
                  width: size.height / 19,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(itemdata[index].imageUrl),
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height / 70,
                ),
                Text(
                  itemdata[index].text,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget categoriesItems(Size size, String imageUrl, String text, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: GestureDetector(
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => AvalibleDoctors(
              category: text,
            ),
          ),
        ),
        child: Material(
          elevation: 5,
          borderRadius: BorderRadius.circular(15),
          color: color,
          child: Container(
            height: size.height / 5,
            width: size.width / 2.4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: size.height / 12,
                  width: size.height / 12,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(imageUrl),
                    ),
                  ),
                ),
                Text(
                  text,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: color != Colors.white ? Colors.white : Colors.black,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget searchField(Size size) {
    return GestureDetector(
      onTap: () => showSearch(context: context, delegate: Search()),
      child: Container(
        height: size.height / 12,
        width: size.width / 1.1,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.grey[300],
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Icon(Icons.search),
            ),
            Expanded(child: Text("Search your symptoms...")),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                height: size.height / 12,
                width: size.height / 20,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(55, 82, 178, 1),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
              ),
            ),
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () => _scaffoldKey.currentState.openDrawer(),
              child: Icon(Icons.menu),
            ),
            GestureDetector(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => Profile(
                    func: getUserInfo,
                    userMap: userMap,
                  ),
                ),
              ),
              child: Icon(Icons.account_box),
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

  @override
  Widget build(BuildContext context) {
    if (profileSnap != null) {
      if (profileSnap['isverified'] == false) {
        return Verify();
      } else {
        return DoctorHomescreen(
          prefs: widget.prefs,
        );
      }
    } else {
      return Container();
    }
  }
}

class Data {
  final String imageUrl, text;
  final Function func;
  Data({this.imageUrl, this.text, this.func});
}
