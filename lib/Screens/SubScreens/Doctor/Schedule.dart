import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class Schedule extends StatefulWidget {
  @override
  _ScheduleState createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
  List<bool> isAvalible;
  List<bool> isappointed;
  final String uid = FirebaseAuth.instance.currentUser.uid;
  List<String> docsId = [];
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future getSchedule() async {
    List<DocumentSnapshot> snap = [];
    try {
      await _firestore
          .collection('doctor')
          .doc(uid)
          .collection('schedule')
          .get()
          .then((value) {
        snap = value.docs;

        isAvalible = snap
            .map((DocumentSnapshot e) {
              return e.data()['isavalible'];
            })
            .cast<bool>()
            .toList();

        isappointed = snap
            .map((e) {
              return e.data()['isappointed'];
            })
            .cast<bool>()
            .toList();
        print(isAvalible);
        setState(() {});
        if (docsId.isEmpty) {
          value.docs.forEach((element) {
            docsId.add(element.id);
          });
          print(docsId);
        }
      });
    } catch (e) {
      Toast.show("Error Occured", context);
    }
  }

  @override
  void initState() {
    super.initState();
    getSchedule();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return isAvalible != null
        ? Scaffold(
            appBar: AppBar(
              title: Text("Today's Schedule"),
            ),
            body: Column(
              children: [
                scheduleTime("10:00am to 11:00am", 0),
                SizedBox(
                  height: size.height / 60,
                ),
                scheduleTime("11:00am to 12:00pm", 1),
                SizedBox(
                  height: size.height / 60,
                ),
                scheduleTime("1:00pm to 2:00pm", 2),
                SizedBox(
                  height: size.height / 60,
                ),
                scheduleTime("2:00pm to 3:00pm", 3),
                SizedBox(
                  height: size.height / 60,
                ),
                scheduleTime("3:00pm to 4:00pm", 4),
                SizedBox(
                  height: size.height / 60,
                ),
                scheduleTime("4:00pm to 5:00pm", 5),
                SizedBox(
                  height: size.height / 60,
                ),
                scheduleTime("5:00pm to 6:00pm", 6),
                SizedBox(
                  height: size.height / 60,
                ),
                scheduleTime("6:00pm to 7:00pm", 7),
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

  Widget scheduleTime(String text, int index) {
    return ListTile(
      title: Text(text),
      subtitle:
          Text(isAvalible[index] ? "Status: Avalible" : "Status: Not Avalible"),
      trailing: PopupMenuButton(
        icon: Icon(Icons.arrow_drop_down),
        onSelected: (val) async {
          if (isappointed[index] == false) {
            if (val) {
              try {
                await _firestore
                    .collection('doctor')
                    .doc(uid)
                    .collection('schedule')
                    .doc(docsId[index])
                    .update({"isavalible": true}).then((value) {
                  getSchedule();
                  Toast.show("Status updated", context, duration: 1);
                });
              } catch (e) {
                Toast.show("Error Occured", context);
              }
            } else {
              try {
                await _firestore
                    .collection('doctor')
                    .doc(uid)
                    .collection('schedule')
                    .doc(docsId[index])
                    .update({"isavalible": false}).then((value) {
                  getSchedule();
                  Toast.show("Status updated", context, duration: 1);
                });
              } catch (e) {
                Toast.show("Error Occured", context);
              }
            }
            setState(() {});
          } else {
            Toast.show("You have appointed can't change", context);
          }
        },
        itemBuilder: (_) => [
          PopupMenuItem(
            child: Text("Avalible"),
            value: true,
          ),
          PopupMenuItem(
            child: Text("Not Avalible"),
            value: false,
          )
        ],
      ),
    );
  }
}
