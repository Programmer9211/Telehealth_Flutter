import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tele_health_app/Screens/SubScreens/Paitent/TimeCheck.dart';
import 'package:toast/toast.dart';

class AvalibleDoctors extends StatefulWidget {
  final String category;

  const AvalibleDoctors({Key key, this.category}) : super(key: key);

  @override
  _AvalibleDoctorsState createState() => _AvalibleDoctorsState();
}

class _AvalibleDoctorsState extends State<AvalibleDoctors> {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Map<String, dynamic>> docList;
  String collection;

  @override
  void initState() {
    super.initState();
    collection = getCollection();
    getDoctorList();
  }

  String getCollection() {
    if (widget.category != null) {
      return widget.category.toLowerCase();
    } else {
      return "doctor";
    }
  }

  void getDoctorList() async {
    List<DocumentSnapshot> docs = [];
    try {
      await _firestore.collection(collection).get().then((value) {
        setState(() {
          docs = value.docs;
          docList = docs.map((DocumentSnapshot documentSnapshot) {
            return documentSnapshot.data();
          }).toList();
        });
      });
    } catch (e) {
      Toast.show("An Unexpected Error Occured", context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.category == null ? "Avalible Doctors" : widget.category,
        ),
        backgroundColor: Color.fromRGBO(55, 82, 178, 1),
      ),
      body: docList != null
          ? doctorCardBuilder(size)
          : Center(
              child: Container(
                height: size.height / 20,
                width: size.height / 20,
                child: CircularProgressIndicator(),
              ),
            ),
    );
  }

  Widget doctorCardBuilder(Size size) {
    return Container(
      height: size.height,
      width: size.width,
      child: docList.length > 0
          ? ListView.builder(
              itemCount: docList.length,
              itemBuilder: (_, index) {
                return doctorCard(
                  size,
                  docList[index]['name'],
                  docList[index]['ed'],
                  docList[index]['fee'],
                  docList[index]['experience'],
                  docList[index]['qualification'],
                  docList[index]['uid'],
                );
              },
            )
          : Container(
              height: size.height,
              width: size.width,
              alignment: Alignment.center,
              child: Text(
                "No Doctor Avalible!",
                style: TextStyle(
                  fontSize: size.width / 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
    );
  }

  Widget doctorCard(Size size, String doctorName, String specialization,
      String fee, String experience, String qualification, String uid) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 9),
      child: Material(
        elevation: 4,
        color: Colors.white,
        child: Container(
          height: size.height / 2.6,
          width: size.width / 1.1,
          child: Stack(
            children: [
              Positioned(
                top: size.width / 25,
                left: size.width / 25,
                child: Container(
                  height: size.height / 8,
                  width: size.width / 5,
                  child: Icon(
                    Icons.account_circle,
                    size: 50,
                  ),
                ),
              ),
              Positioned(
                top: size.width / 24,
                left: size.width / 3.5,
                child: Container(
                  width: size.width / 1.7,
                  child: Text(
                    doctorName,
                    style: TextStyle(
                      fontSize: size.width / 22,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: size.width / 5,
                left: size.width / 3.5,
                child: Text(
                  specialization,
                  style: TextStyle(
                    fontSize: size.width / 26,
                  ),
                ),
              ),
              Positioned(
                  top: size.width / 30,
                  right: size.width / 20,
                  child: Icon(
                    Icons.verified,
                    color: Colors.green,
                  )),
              Positioned(
                top: size.width / 7,
                left: size.width / 3.5,
                child: Text(
                  "$experience Years Experience",
                  style: TextStyle(
                    fontSize: size.width / 26,
                  ),
                ),
              ),
              Positioned(
                top: size.width / 3,
                left: size.width / 50,
                child: Container(
                  height: size.height / 500,
                  width: size.width / 1.1,
                  color: Colors.grey,
                ),
              ),
              Positioned(
                left: size.width / 16,
                bottom: size.width / 3,
                child: Text(
                  "Rs. $fee Consultant Fee",
                  style: TextStyle(
                    fontSize: size.width / 26,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Positioned(
                top: size.width / 2.2,
                left: size.width / 16,
                child: Text(
                  "Next Avalible ",
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: size.width / 26,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Positioned(
                top: size.width / 2,
                left: size.width / 17,
                child: Row(
                  children: [
                    Icon(
                      Icons.video_call,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      width: size.width / 60,
                    ),
                    Text(
                      " Today",
                      style: TextStyle(
                        fontSize: size.width / 25,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
              ),
              Positioned(
                bottom: size.width / 40,
                left: size.width / 18,
                child: GestureDetector(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => TimeAvailible(
                        amount: fee,
                        doctorname: doctorName,
                        doctorId: uid,
                      ),
                    ),
                  ),
                  child: Material(
                    elevation: 4,
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.blueAccent,
                    child: Container(
                      height: size.height / 14,
                      width: size.width / 1.2,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.blueAccent,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "Book Video Consultation",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: size.width / 22,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
