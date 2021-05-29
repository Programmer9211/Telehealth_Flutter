import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:tele_health_app/Screens/SubScreens/Paitent/ChatBot/chatBot.dart';
import 'package:toast/toast.dart';

class TimeAvailible extends StatefulWidget {
  final String doctorId, doctorname, amount;

  TimeAvailible({this.doctorId, this.doctorname, this.amount});

  @override
  _TimeAvailibleState createState() => _TimeAvailibleState();
}

class _TimeAvailibleState extends State<TimeAvailible> {
  List<Map<String, dynamic>> scheduleMap;
  List<Color> primaryColor = <Color>[];
  List<Color> secondaryColor = <Color>[];
  List<String> documentId = [];
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String selectedTime;
  int listIndex;
  Razorpay _razorpay;
  Map<String, dynamic> userMap;

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWallet);
    initializeColor();
    getUserDetails();
    getSchedule();
  }

  void getUserDetails() async {
    await _firestore
        .collection('paitent')
        .doc(_auth.currentUser.uid)
        .get()
        .then((value) {
      setState(() {
        userMap = value.data();
        print(userMap);
      });
    });
  }

  void onPayment() {
    if (selectedTime != null && listIndex != null) {
      Map<String, dynamic> options = {
        "key": "rzp_test_PR05SUaukQBiX2",
        "amount": num.parse(widget.amount) * 100,
        "name": "TeleHealth Application",
        "description": "",
        "prefill": {"contact": userMap['mob'], "email": userMap['email']},
        "external": {
          "wallets": ["paytm"]
        }
      };

      try {
        _razorpay.open(options);
      } catch (e) {
        print("error: $e");
      }
    } else {
      Toast.show("Please select appointment time", context, duration: 2);
    }
  }

  void handlePaymentSuccess(PaymentSuccessResponse response) async {
    Toast.show(
        "Payment Sucessfull\nPayment Id: ${response.paymentId}\n OrderId : ${response.orderId}",
        context);
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ChatBot(
          doctoruid: widget.doctorId,
          doctorname: widget.doctorname,
          docsId: documentId[listIndex],
          selectedtime: selectedTime,
        ),
      ),
    );
  }

  void handlePaymentError(PaymentFailureResponse response) async {
    Toast.show("Payment Failed", context);
  }

  void handleExternalWallet(ExternalWalletResponse response) async {
    Toast.show("", context);
  }

  void initializeColor() {
    for (int i = 0; i <= 7; i++) {
      primaryColor.add(Colors.blue);
      secondaryColor.add(Colors.white);
    }
  }

  void getSchedule() async {
    List<DocumentSnapshot> snap = [];
    print(widget.doctorId);
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
              onTap: onPayment,
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

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }
}
