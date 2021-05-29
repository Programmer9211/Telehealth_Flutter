import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tele_health_app/Screens/SubScreens/Paitent/ChatBot/chatbotcommand.dart';
import 'package:tele_health_app/Screens/SubScreens/Paitent/HomeScreen.dart';
import 'package:toast/toast.dart';

class ChatBot extends StatefulWidget {
  final String doctoruid, docsId, selectedtime, doctorname;
  ChatBot({this.doctoruid, this.docsId, this.selectedtime, this.doctorname});
  @override
  _ChatBotState createState() => _ChatBotState();
}

class _ChatBotState extends State<ChatBot> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  List<String> filterList;
  int listIndx = -1, indx = 0;
  String disease = "d", output;
  SharedPreferences pref;

  void initPrefs() async {
    pref = await SharedPreferences.getInstance();
  }

  Future<void> confirmAppointment() async {
    try {
      await _firestore
          .collection('doctor')
          .doc(widget.doctoruid)
          .collection('schedule')
          .doc(widget.docsId)
          .update({"isappointed": true, "isavalible": false}).then(
              (value) => print("Appointment sucessful"));

      await _firestore
          .collection('doctor')
          .doc(widget.doctoruid)
          .collection('appointment')
          .add({
        "uid": _auth.currentUser.uid,
        "name": _auth.currentUser.displayName,
        "time": widget.selectedtime,
        "chats": chats,
      });

      await _firestore
          .collection('paitent')
          .doc(_auth.currentUser.uid)
          .collection('appointment')
          .add({
        "name": widget.doctorname,
        "time": widget.selectedtime,
      });
    } catch (e) {
      Toast.show("Error Occured", context);
    }
  }

  @override
  void initState() {
    super.initState();
    initPrefs();
    filterList = _chatBot.filterList(indx, disease, listIndx);
    Timer(Duration(milliseconds: 600), () {
      setState(() {
        chats.add({
          "isMe": false,
          "sendBy": "Bot",
          "message":
              "Hello, My name is bot.\ni am here to help you\nPlease select an option"
        });
      });
    });

    Timer(Duration(seconds: 1), () => showBottomSheet());
  }

  List<Map<String, dynamic>> chats = [];

  final ChatBotCommands _chatBot = ChatBotCommands();

  void showBottomSheet() {
    final Size size = MediaQuery.of(context).size;
    showModalBottomSheet(
        isDismissible: false,
        context: context,
        builder: (_) => Container(
              height: size.height / 3,
              width: size.width,
              child: ListView.builder(
                itemCount: filterList.length,
                itemBuilder: (context, index) => ListTile(
                  onTap: () async {
                    if (output !=
                        "Ok, This report is submitted to doctor for further medication.Thank you.") {
                      Navigator.pop(context);
                      chats.add({
                        "isMe": true,
                        "sendBy": "Paitent",
                        "message": filterList[index]
                      });

                      output = _chatBot.responses(filterList[index]);

                      //

                      Timer(Duration(milliseconds: 600), () {
                        chats.add({
                          "isMe": false,
                          "sendBy": "Bot",
                          "message": output
                        });
                        setState(() {});
                      });

                      //

                      indx = 1;
                      if (disease == "d") {
                        disease = filterList[index];
                      }
                      listIndx += 1;
                      if (output !=
                          "Ok, This report is submitted to doctor for further medication.Thank you.") {
                        filterList =
                            _chatBot.filterList(indx, disease, listIndx);
                        Timer(Duration(seconds: 1), () => showBottomSheet());
                      } else {
                        confirmAppointment();
                      }

                      setState(() {});
                    } else {
                      print("Done\n\n\n\n\n\nDone");
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (_) => AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          title: Text("Appointment"),
                          content: Text(
                              "Your Appointment with Doctor is confirmed."),
                          actions: [
                            TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text("OK"))
                          ],
                        ),
                      );
                    }
                  },
                  title: Text(filterList[index]),
                ),
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (_) => HomePage(
                    prefs: pref,
                  )),
          (Route<dynamic> route) => false,
        );
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("ChatBot"),
          backgroundColor: Color.fromRGBO(55, 82, 178, 1),
        ),
        body: ListView.builder(
          itemCount: chats.length,
          itemBuilder: (context, index) {
            return messages(
                size, chats[index]['isMe'], chats[index]['message']);
          },
        ),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {
        //     List<String> message = [];
        //     message = chats.map((e) => e['message']).cast<String>().toList();
        //     print(message);
        //   },
        // ),
      ),
    );
  }

  Widget messages(Size size, bool isMe, String message) {
    return Container(
      width: size.width,
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 14),
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.blue,
        ),
        child: Text(
          message,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
