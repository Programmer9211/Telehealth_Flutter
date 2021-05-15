import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class TimeAvailible extends StatefulWidget {
  final String doctorId;

  TimeAvailible({this.doctorId});

  @override
  _TimeAvailibleState createState() => _TimeAvailibleState();
}

class _TimeAvailibleState extends State<TimeAvailible> {
  List<Map<String, dynamic>> scheduleMap;
  List<Color> primaryColor = <Color>[];
  List<Color> secondaryColor = <Color>[];
  List<String> documentId = [];
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String selectedTime;
  int listIndex;

  @override
  void initState() {
    super.initState();
    initializeColor();
    getSchedule();
  }

  void initializeColor() {
    for (int i = 0; i <= 7; i++) {
      primaryColor.add(Colors.blue);
      secondaryColor.add(Colors.white);
    }
  }

  void getSchedule() async {
    List<DocumentSnapshot> snap = [];

    try {
      await _firestore
          .collection('doctor')
          .doc(widget.doctorId)
          .collection('schedule')
          .get()
          .then((value) {
        snap = value.docs;
        scheduleMap = snap.map((DocumentSnapshot e) {
          return e.data();
        }).toList();

        if (documentId.isEmpty) {
          value.docs.forEach((element) {
            documentId.add(element.id);
          });
        }

        setState(() {});
        print(scheduleMap);
        print(documentId);
      });
    } catch (e) {
      Toast.show("Error Occured", context);
    }
  }

  Future confirmAppointment() async {
    if (selectedTime != null && listIndex != null) {
      try {
        await _firestore
            .collection('doctor')
            .doc(widget.doctorId)
            .collection('schedule')
            .doc(documentId[listIndex])
            .update({"isappointed": true, "isavalible": false}).then(
                (value) => print("Appointment sucessful"));
      } catch (e) {
        Toast.show("Error Occured", context);
      }
    } else {
      Toast.show("Please select appointment time", context, duration: 2);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return scheduleMap != null
        ? Scaffold(
            appBar: AppBar(
              title: Text("Confirm Appointment"),
              backgroundColor: Color.fromRGBO(55, 82, 178, 1),
            ),
            body: GridView.builder(
                itemCount: scheduleMap.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: ((size.width / 4) / (size.height / 10)),
                  crossAxisCount: 3,
                ),
                itemBuilder: (context, index) {
                  return gridItems(size, index);
                }),
            bottomNavigationBar: InkWell(
              onTap: confirmAppointment,
              child: Container(
                height: size.height / 9,
                width: size.width,
                alignment: Alignment.center,
                child: Container(
                  height: size.height / 14,
                  width: size.width / 1.2,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.blue,
                  ),
                  child: Text(
                    "Book Appointment",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: size.width / 22,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              title: Text("Confirm Appointment"),
              backgroundColor: Color.fromRGBO(55, 82, 178, 1),
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

  Widget gridItems(Size size, int index) {
    return Container(
      height: size.height / 100,
      width: size.width / 2,
      alignment: Alignment.center,
      child: InkWell(
        onTap: () {
          if (scheduleMap[index]['isavalible']) {
            Toast.show("Availible", context, duration: 2);

            setState(() {
              for (int i = 0; i <= 7; i++) {
                primaryColor[i] = Colors.blue;
                secondaryColor[i] = Colors.white;
              }

              primaryColor[index] = Colors.white;
              secondaryColor[index] = Colors.blue;
              selectedTime = scheduleMap[index]['time'];
              listIndex = index;
            });
          } else {
            Toast.show("Not Availible", context, duration: 2);
          }
        },
        child: Container(
          height: size.height / 14,
          width: size.width / 3.8,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: scheduleMap[index]['isavalible']
                  ? primaryColor[index]
                  : Colors.grey,
            ),
            color: secondaryColor[index],
          ),
          child: Text(
            scheduleMap[index]['time'],
            style: TextStyle(
              fontSize: size.width / 24,
              fontWeight: FontWeight.w500,
              color: scheduleMap[index]['isavalible']
                  ? primaryColor[index]
                  : Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}
