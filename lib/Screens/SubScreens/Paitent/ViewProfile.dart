import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tele_health_app/Screens/SubScreens/Doctor/Notification.dart';
import 'package:toast/toast.dart';

class ViewProfile extends StatefulWidget {
  final String uid;
  ViewProfile({this.uid});

  @override
  _ViewProfileState createState() => _ViewProfileState();
}

class _ViewProfileState extends State<ViewProfile> {
  final TextEditingController _controller = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void onWriteReview() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: Text("Feedback"),
        content: TextField(
          controller: _controller,
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context), child: Text("Cancel")),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              await _firestore
                  .collection('doctor')
                  .doc(widget.uid)
                  .collection('review')
                  .add({
                "name": _auth.currentUser.displayName,
                "feedback": _controller.text,
              }).then((value) {
                Toast.show("Feedback Submitted Sucessfully", context);
              });

              _controller.clear();
            },
            child: Text("Submit"),
          ),
        ],
      ),
    );
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
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
      print(widget.uid);
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
            body: SingleChildScrollView(
              child: Column(
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
                  InkWell(
                    onTap: onWriteReview,
                    child: showInfo("Give FeedBack"),
                  ),
                  SizedBox(
                    height: size.height / 50,
                  ),
                  InkWell(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => Reviews(
                          doctorUid: widget.uid,
                        ),
                      ),
                    ),
                    child: showInfo("See FeedBack"),
                  ),
                ],
              ),
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
