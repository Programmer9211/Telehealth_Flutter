import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tele_health_app/Authenticate/Account.dart';
import 'package:toast/toast.dart';

class AdminHomeScreen extends StatefulWidget {
  final SharedPreferences prefs;
  AdminHomeScreen(this.prefs);
  @override
  _AdminHomeScreenState createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void onAccept(String uid, String docsId) async {
    await _firestore
        .collection('doctor')
        .doc(uid)
        .update({"isverified": true}).then((value) async {
      Toast.show("Permission Granted", context);

      await _firestore
          .collection('admin')
          .doc('LLOFlbON1rRcZ2rrzCBYwQL00As1')
          .collection('verification')
          .doc(docsId)
          .delete();
    });
  }

  void onReject(String docsId) async {
    await _firestore
        .collection('admin')
        .doc('LLOFlbON1rRcZ2rrzCBYwQL00As1')
        .collection('verification')
        .doc(docsId)
        .delete()
        .then((value) => Toast.show("Permission Denied", context));
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text("Admin"),
        actions: [
          IconButton(
              icon: Icon(Icons.logout),
              onPressed: () => logOut(context, widget.prefs))
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore
            .collection('admin')
            .doc('LLOFlbON1rRcZ2rrzCBYwQL00As1')
            .collection('verification')
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data != null) {
              if (snapshot.data.docs.length > 0) {
                return haveData(size, snapshot);
              } else {
                return noData(size);
              }
            } else {
              return noData(size);
            }
          } else {
            return noData(size);
          }
        },
      ),
    );
  }

  Widget noData(Size size) {
    return Container(
      height: size.height,
      width: size.width,
      alignment: Alignment.center,
      child: Text(
        "No Notifications Yet !",
        style: TextStyle(
          fontSize: size.width / 22,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget haveData(Size size, AsyncSnapshot<QuerySnapshot> snapshot) {
    return Container(
      height: size.height,
      width: size.width,
      alignment: Alignment.center,
      child: Container(
        height: size.height,
        width: size.width / 1.08,
        child: ListView.builder(
          itemCount: snapshot.data.docs.length,
          itemBuilder: (_, index) {
            Map<String, dynamic> map = snapshot.data.docs[index].data();
            String docsid = snapshot.data.docs[index].id;
            return Container(
              height: size.height / 3.7,
              alignment: Alignment.center,
              child: Material(
                elevation: 5,
                child: Container(
                  height: size.height / 4,
                  width: size.width / 1.1,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: size.height / 9,
                            width: size.height / 9,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                    'https://image.freepik.com/free-vector/cartoon-male-doctor-holding-clipboard_29190-4660.jpg'),
                                fit: BoxFit.contain,
                              ),
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(
                            width: size.width / 30,
                          ),
                          Container(
                            width: size.width / 1.6,
                            child: Text(
                              map['name'],
                              style: TextStyle(
                                fontSize: size.width / 22,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: size.height / 60,
                      ),
                      Container(
                        height: size.width / 200,
                        width: size.width / 1.2,
                        color: Colors.grey,
                      ),
                      SizedBox(
                        height: size.height / 60,
                      ),
                      Container(
                        height: size.height / 15,
                        width: size.width / 1.2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            approvalButton(size, Colors.red[400], "Reject",
                                () => onReject(docsid)),
                            approvalButton(size, Colors.blue, "Accept",
                                () => onAccept(map['uid'], docsid)),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget approvalButton(
      Size size, Color color, String text, Function function) {
    return InkWell(
      onTap: function,
      child: Material(
        elevation: 4,
        borderRadius: BorderRadius.circular(8),
        color: color,
        child: Container(
          height: size.height / 19,
          width: size.width / 3.8,
          alignment: Alignment.center,
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: size.width / 25,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
