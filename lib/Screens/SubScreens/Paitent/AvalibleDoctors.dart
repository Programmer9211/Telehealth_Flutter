import 'package:flutter/material.dart';

class AvalibleDoctors extends StatefulWidget {
  final String category;

  const AvalibleDoctors({Key key, this.category}) : super(key: key);

  @override
  _AvalibleDoctorsState createState() => _AvalibleDoctorsState();
}

class _AvalibleDoctorsState extends State<AvalibleDoctors> {
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
      body: doctorCardBuilder(size),
    );
  }

  Widget doctorCardBuilder(Size size) {
    return Container(
      height: size.height,
      width: size.width,
      child: ListView.builder(
          itemCount: 10,
          itemBuilder: (_, index) {
            return doctorCard(size);
          }),
    );
  }

  Widget doctorCard(Size size) {
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
                    "Doctor Name ",
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
                  "Specializations",
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
                  "10 Years Experience",
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
                  "Rs. 500 Consultant Fee",
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
                  "Next Avalible At",
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
                      "5:20pm, today",
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
                  onTap: () {},
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
