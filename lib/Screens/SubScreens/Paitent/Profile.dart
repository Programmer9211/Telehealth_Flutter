import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  void onEdit(BuildContext context, String text) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(
          "Edit $text",
          style: TextStyle(
            fontSize: 17,
          ),
        ),
        content: TextField(
          decoration: InputDecoration(
            hintText: "Enter $text",
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          TextButton(onPressed: () {}, child: Text("Confirm")),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Profile"),
          backgroundColor: Color.fromRGBO(55, 82, 178, 1),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: size.height / 3.5,
                width: size.width,
                child: Icon(
                  Icons.account_circle,
                  size: 200,
                ),
              ),
              tile(size, "Name", context),
              tile(size, "DOB", context),
              tile(size, "Gender", context),
              tile(size, "Blood Group", context),
              tile(size, "Height", context),
              tile(size, "Width", context),
              // tile(size, "Width"),
              // tile(size, "Width"),
            ],
          ),
        ),
      ),
    );
  }

  Widget tile(Size size, String text, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        onTap: () => onEdit(context, text),
        title: Text(text),
        trailing: Icon(Icons.edit),
      ),
    );
  }
}
