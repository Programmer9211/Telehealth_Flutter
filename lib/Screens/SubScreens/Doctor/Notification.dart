import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Reviews extends StatefulWidget {
  final String doctorUid;
  Reviews({this.doctorUid});
  @override
  _ReviewsState createState() => _ReviewsState();
}

class _ReviewsState extends State<Reviews> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  List<Map<String, dynamic>> reviews;
  String uid;

  @override
  void initState() {
    super.initState();
    uid = widget.doctorUid != null ? widget.doctorUid : _auth.currentUser.uid;
    getData();
  }

  void getData() async {
    List<DocumentSnapshot> snap = [];
    await _firestore
        .collection('doctor')
        .doc(uid)
        .collection('review')
        .get()
        .then((value) {
      setState(() {
        snap = value.docs;

        reviews = snap.map((e) => e.data()).toList();
      });
      print(reviews);
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    if (reviews != null) {
      if (reviews.length > 0) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Reviews"),
          ),
          body: ListView.builder(
            itemCount: reviews.length,
            itemBuilder: (context, index) {
              return listItems(size, index);
            },
          ),
        );
      } else {
        return Scaffold(
          appBar: AppBar(
            title: Text("Reviews"),
          ),
          body: Container(
            height: size.height,
            width: size.width,
            alignment: Alignment.center,
            child: Text(
              "No Reviews Yet!",
              style: TextStyle(
                fontSize: size.width / 22,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        );
      }
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text("Reviews"),
        ),
        body: Center(
          child: Container(
            height: size.height / 20,
            width: size.height / 20,
            child: CircularProgressIndicator(),
          ),
        ),
      );
    }
  }

  Widget listItems(Size size, int index) {
    return Container(
      width: size.width,
      padding: EdgeInsets.symmetric(vertical: 10),
      alignment: Alignment.center,
      child: Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(18),
        child: Container(
          width: size.width / 1.2,
          child: Column(
            children: [
              SizedBox(
                height: size.height / 60,
              ),
              Text(
                reviews[index]['name'] == null
                    ? "name"
                    : reviews[index]['name'],
                style: TextStyle(
                  fontSize: size.width / 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: size.height / 40,
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  reviews[index]['feedback'],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: size.width / 24,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(
                height: size.height / 80,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
