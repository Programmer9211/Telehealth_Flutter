import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class ViewProfile extends StatefulWidget {
  final String uid;
  ViewProfile({this.uid});

  @override
  _ViewProfileState createState() => _ViewProfileState();
}

class _ViewProfileState extends State<ViewProfile> {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Map<String, dynamic> profileMap;

  @override
  void initState() {
    super.initState();
    getProfile();
  }

  Future getProfile() async {
    try {
      await _firestore.collection('doctor').doc(widget.uid).get().then((value) {
        setState(() {
          profileMap = value.data();
          print(profileMap);
        });
      });
    } catch (e) {
      Toast.show("An error occured", context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return profileMap != null
        ? Scaffold(
            appBar: AppBar(
              title: Text("Doctor Profile"),
              backgroundColor: Color.fromRGBO(55, 82, 178, 1),
            ),
            body: Column(
              children: [
                SizedBox(height: size.height / 30),
                Card(
                  shape: CircleBorder(),
                  elevation: 5,
                  child: Container(
                    height: size.height / 4,
                    width: size.width / 2,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(profileMap['image'] != "i"
                            ? profileMap['image']
                            : "https://image.freepik.com/free-vector/cartoon-male-doctor-holding-clipboard_29190-4660.jpg"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                showInfo(profileMap['name']),
                SizedBox(
                  height: size.height / 50,
                ),
                showInfo(profileMap['qualification']),
                SizedBox(
                  height: size.height / 50,
                ),
                showInfo(profileMap['ed']),
                SizedBox(
                  height: size.height / 50,
                ),
                showInfo("Experience: ${profileMap['experience']} years"),
                SizedBox(
                  height: size.height / 50,
                ),
                showInfo("Fee ${profileMap['fee']}/hr"),
                SizedBox(
                  height: size.height / 50,
                ),
              ],
            ),
          )
        : Scaffold(
            body: Center(
              child: Container(
                height: size.height / 20,
                width: size.height / 20,
                child: CircularProgressIndicator(),
              ),
            ),
          );
  }

  Widget showInfo(String text) {
    return ListTile(
      title: Text(text),
    );
  }
}
