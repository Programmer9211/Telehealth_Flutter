import 'package:flutter/material.dart';

class ChooseDoctor extends StatelessWidget {
  void onConfirm() {}

  void onKnowMore() {}

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            appBar(size),
            Container(
              height: size.height / 15,
              width: size.width / 1.15,
              child: Text(
                "Doctors Available Now",
                style: TextStyle(fontSize: size.width / 24),
              ),
            ),
            doctorList(size),
          ],
        ),
      ),
    );
  }

  Widget doctorList(Size size) {
    return Container(
      height: size.height / 1.25,
      width: size.width,
      child: ListView.builder(
          itemCount: 6,
          itemBuilder: (context, index) {
            return itemBuilder(size);
          }),
    );
  }

  Widget itemBuilder(Size size) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
      child: Container(
        height: size.height / 3,
        width: size.width / 1.1,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            width: 2,
            color: Colors.black,
          ),
        ),
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
                    "Dr. Pradeep Kumar",
                    style: TextStyle(
                      fontSize: size.width / 19,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Hair and Skin\n   Specialist",
                    style: TextStyle(
                      fontSize: size.width / 25,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      "    MBBS,DDVL\n   Experience- 07",
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
                    "₹ 550",
                    style: TextStyle(
                      fontSize: size.width / 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  buttonAlignment(size)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buttonAlignment(Size size) {
    return Container(
      height: size.height / 10,
      width: size.width / 1.7,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          button("Know More", size, onKnowMore),
          button("Confirm", size, onConfirm),
        ],
      ),
    );
  }

  Widget button(String text, Size size, Function function) {
    return ElevatedButton(
        onPressed: function,
        style: ElevatedButton.styleFrom(
            primary: Colors.red,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            )),
        child: Text(
          text,
          style: TextStyle(
            fontSize: size.width / 24,
            fontWeight: FontWeight.w500,
          ),
        ));
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
            child: Icon(Icons.arrow_back),
          ),
          Container(
              height: size.height / 20,
              width: size.width / 1.5,
              alignment: Alignment.center,
              child: Text(
                "Choose Your Doctor",
                style: TextStyle(
                  fontSize: size.width / 20,
                  fontWeight: FontWeight.w500,
                ),
              )),
          SizedBox(
            width: size.width / 10,
          ),
          Icon(Icons.close)
        ],
      ),
    );
  }
}
