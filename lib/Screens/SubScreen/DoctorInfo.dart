import 'package:flutter/material.dart';
import 'package:tele_health_app/Screens/SubScreen/Confirmation.dart';

class DoctorInfo extends StatefulWidget {
  final Map<String, dynamic> map;
  DoctorInfo({this.map});

  @override
  _DoctorInfoState createState() => _DoctorInfoState();
}

class _DoctorInfoState extends State<DoctorInfo> {
  DateTime selectedDate;
  TimeOfDay selectedTime;
  String chooseSlot = "Choose Slot";
  String selectedMode;
  Color pcolor = Colors.black;
  Color vcolor = Colors.black;

  @override
  void initState() {
    super.initState();
    selectedDate = DateTime.now();
    selectedTime = TimeOfDay.now();
  }

  Future selectDate() async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: selectedDate,
      lastDate: DateTime(2050),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future selectTime() async {
    final TimeOfDay pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );

    if (pickedTime != null && pickedTime != selectedTime) {
      setState(() {
        selectedTime = pickedTime;
      });
    }
  }

  void confirmAndPay() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => AppointmentConfirmation()));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            appBar(size),
            SizedBox(
              height: size.height / 25,
            ),
            doctorInfo(size),
            divider(),
            avalibleSlots(size),
            divider(),
            selectDateTimeInterface(size),
            divider(),
            modeOfConsultation(size),
            InkWell(
              onTap: confirmAndPay,
              child: Container(
                height: size.height / 18,
                width: size.width / 2.5,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    width: 1.5,
                    color: Colors.black,
                  ),
                ),
                child: Text(
                  "Confirm & Pay",
                  style: TextStyle(
                    fontSize: size.width / 23,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget modeOfConsultation(Size size) {
    return Container(
      height: size.height / 5,
      width: size.width,
      child: Column(
        children: [
          Container(
            height: size.height / 20,
            width: size.width / 1.1,
            child: Text(
              "Select Mode Of Consultation :-",
              style: TextStyle(
                fontSize: size.width / 23,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Container(
            height: size.height / 8,
            width: size.width / 1.1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                consultaionMode("Physical", Icons.account_circle, size, pcolor),
                Container(
                  height: size.height / 8,
                  width: size.width / 180,
                  color: Colors.black,
                ),
                consultaionMode(
                    "Virtual", Icons.video_call_rounded, size, vcolor),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget consultaionMode(String text, IconData icon, Size size, Color color) {
    return InkWell(
      onTap: () {
        if (text == "Physical") {
          pcolor == Colors.black ? pcolor = Colors.blue : null;
          vcolor == Colors.blue ? vcolor = Colors.black : null;
          selectedMode = "Physical";
        } else if (text == "Virtual") {
          vcolor == Colors.black ? vcolor = Colors.blue : null;
          pcolor == Colors.blue ? pcolor = Colors.black : null;
          selectedMode = "Virtual";
        }
        setState(() {});
      },
      child: Container(
        height: size.height / 8,
        width: size.width / 4,
        child: Column(
          children: [
            Icon(
              icon,
              size: size.width / 6,
              color: color,
            ),
            Text(
              text,
              style: TextStyle(
                fontSize: size.width / 20,
                color: color,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget selectDateTimeInterface(Size size) {
    return Container(
      height: size.height / 8,
      width: size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
            onTap: selectDate,
            child: RichText(
              text: TextSpan(
                text: "Select Date\n",
                style: TextStyle(
                  fontSize: size.width / 22,
                  color: Colors.black,
                ),
                children: [
                  TextSpan(
                    text: "${selectedDate.toLocal()}".split(' ')[0],
                    style: TextStyle(
                      fontSize: size.width / 22,
                    ),
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: selectTime,
            child: RichText(
              text: TextSpan(
                text: "Select Time\n",
                style: TextStyle(
                  fontSize: size.width / 22,
                  color: Colors.black,
                ),
                children: [
                  TextSpan(
                    text: "${selectedTime.hour}: ${selectedTime.minute}",
                    style: TextStyle(
                      fontSize: size.width / 22,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget avalibleSlots(Size size) {
    return Container(
      height: size.height / 6,
      width: size.width,
      child: Column(
        children: [
          Container(
            width: size.width / 1.2,
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                Text(
                  "Avalible Slots :\t\t $chooseSlot",
                  style: TextStyle(
                    fontSize: size.width / 22,
                  ),
                ),
                PopupMenuButton(
                  icon: Icon(Icons.arrow_drop_down),
                  onSelected: (val) {
                    if (val == 1) {
                      chooseSlot = "Morning Slot";
                    } else if (val == 2) {
                      chooseSlot = "Afternoon Slot";
                    } else if (val == 3) {
                      chooseSlot = "Evening Slot";
                    }
                    setState(() {});
                  },
                  itemBuilder: (_) => [
                    PopupMenuItem(
                      child: Text("Morning Slot"),
                      value: 1,
                    ),
                    PopupMenuItem(
                      child: Text("Afternoon Slot"),
                      value: 2,
                    ),
                    PopupMenuItem(
                      child: Text("Evening Slot"),
                      value: 3,
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: size.width / 40,
          ),
          Container(
            width: size.width / 1.5,
            alignment: Alignment.centerLeft,
            child: Text(
              "Morning: 09:00Am - 12:00Pm\nAfternoon: 02:00Pm - 05:00Pm\nEvening: 07:00Pm - 09:00Pm",
              style: TextStyle(
                fontSize: size.width / 25,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget doctorInfo(Size size) {
    return Container(
      height: size.height / 4.5,
      width: size.width,
      child: Row(
        children: [
          Container(
            height: size.height / 3,
            width: size.width / 3,
            child: Column(
              children: [
                Icon(
                  Icons.image,
                  size: size.width / 3.5,
                ),
              ],
            ),
          ),
          Container(
            height: size.height / 3,
            width: size.width / 1.66,
            child: Column(
              children: [
                SizedBox(
                  height: size.height / 50,
                ),
                Text(
                  widget.map['name'],
                  style: TextStyle(
                    fontSize: size.width / 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "${widget.map['ed']}\n   Specialist",
                  style: TextStyle(
                    fontSize: size.width / 25,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    "    ${widget.map['qualification']}\n   Experience- ${widget.map['experience']} years",
                    style: TextStyle(
                      fontSize: size.width / 25,
                      //fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height / 40,
                ),
                Text(
                  "₹ ${widget.map['fee']}",
                  style: TextStyle(
                    fontSize: size.width / 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget appBar(Size size) {
    return Container(
      height: size.height / 12,
      width: size.width,
      color: Colors.blue[100],
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              // onTap: openDrawer,
              child: Icon(Icons.menu),
            ),
          ),
          Container(
            height: size.height / 20,
            width: size.width / 1.5,
            color: Colors.white,
            child: TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                prefixIcon: Icon(Icons.location_on),
                hintText: "Your Current Location",
              ),
            ),
          ),
          SizedBox(
            width: size.width / 10,
          ),
          Icon(Icons.notifications)
        ],
      ),
    );
  }

  Widget divider() {
    return Divider(
      thickness: 1.5,
      color: Colors.black,
    );
  }
}
