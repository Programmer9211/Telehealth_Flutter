import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toast/toast.dart';

class Profile extends StatefulWidget {
  final Function func;
  final Map<String, dynamic> userMap;
  Profile({this.func, this.userMap});
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  DateTime _date = DateTime.now();
  TextEditingController _controller = TextEditingController();
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;
  Map<String, dynamic> user;
  File image;

  @override
  void initState() {
    super.initState();
    user = widget.userMap;
  }

  Future selectImage() async {
    ImagePicker pick = ImagePicker();

    try {
      await pick.getImage(source: ImageSource.gallery).then((value) {
        setState(() {
          if (value != null) {
            image = File(value.path);
            uploadImage();
          }
        });
      });
    } catch (e) {
      Toast.show("Error", context);
    }
  }

  Future uploadImage() async {
    try {
      Reference _ref = FirebaseStorage.instance.ref().child('images/');

      UploadTask uploadTask = _ref.putFile(image);

      await uploadTask.snapshot.ref.getDownloadURL().then((value) async {
        if (value != null) {
          print(value);
          Toast.show("Image Uploaded Sucessfully", context);
          await _firestore
              .collection('paitent')
              .doc(_auth.currentUser.uid)
              .update({"image": value});

          showUpdatedData();
        } else {
          Toast.show("An Error Occured while uploading Image", context);
        }
      });
    } catch (e) {
      Toast.show("An Error Occured while uploading Image", context);
    }
  }

  void onImageTap() {
    final Size size = MediaQuery.of(context).size;

    showModalBottomSheet(
      context: context,
      builder: (_) => Container(
        height: size.height / 4.5,
        width: size.width,
        child: Column(
          children: [
            Container(
              height: size.height / 18,
              width: size.width / 1.1,
              alignment: Alignment.centerLeft,
              child: Text(
                "Profile Image",
                style: TextStyle(fontSize: size.width / 24),
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.pop(context);
                selectImage();
              },
              title: Text('Upload image'),
              leading: Icon(Icons.upload_file),
            ),
            ListTile(
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => ViewImage(
                      imageUrl: user['image'],
                    ),
                  ),
                );
              },
              title: Text("View Image"),
              leading: Icon(Icons.view_list),
            )
          ],
        ),
      ),
    );
  }

  void selectDOB() async {
    var _pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );

    if (_pickedDate != null && _pickedDate != _date) {
      setState(() {
        _date = _pickedDate;
      });
    }
  }

  void showUpdatedData() async {
    await _firestore
        .collection('paitent')
        .doc(_auth.currentUser.uid)
        .get()
        .then((value) {
      setState(() {
        user = value.data();
      });
    });
  }

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
          controller: _controller,
          decoration: InputDecoration(
            hintText: "Enter $text",
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          TextButton(
              onPressed: () async {
                try {
                  await _firestore
                      .collection('paitent')
                      .doc(_auth.currentUser.uid)
                      .update({text: _controller.text}).then((value) {
                    showUpdatedData();
                    widget.func();
                    Toast.show("$text Updated Sucessfully", context,
                        duration: 2);
                  });
                } catch (e) {
                  Toast.show(
                    "An unexpected Error Occures",
                    context,
                    duration: 2,
                  );
                }
                _controller.clear();
                Navigator.pop(context);
              },
              child: Text("Confirm")),
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
              SizedBox(
                height: size.height / 50,
              ),
              GestureDetector(
                onTap: onImageTap,
                child: Container(
                  height: size.height / 3.5,
                  width: size.width,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(user['image']),
                        fit: BoxFit.cover,
                      )),
                ),
              ),
              tile(size, user['name'], context, 'name'),
              dob(),
              tile(size, "Gender: ${user['gender']}", context, 'gender'),
              tile(size, "Blood Group: ${user['bg']}", context, 'bg'),
              tile(size, "Height: ${user['height']}", context, 'height'),
              tile(size, "Weight: ${user['weight']}", context, 'weight'),
              // tile(size, "Width"),
              // tile(size, "Width"),
            ],
          ),
        ),
      ),
    );
  }

  Widget dob() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        onTap: selectDOB,
        title: Text("DOB"),
        trailing: Icon(Icons.edit),
      ),
    );
  }

  Widget tile(Size size, String text, BuildContext context, String toEdit) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        onTap: () => onEdit(context, toEdit),
        title: Text(text),
        trailing: Icon(Icons.edit),
      ),
    );
  }
}

class ViewImage extends StatelessWidget {
  final String imageUrl;

  ViewImage({this.imageUrl});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Container(
          height: size.height / 1.5,
          width: size.width,
          decoration: BoxDecoration(
              image: DecorationImage(image: NetworkImage(imageUrl))),
        ),
      ),
    );
  }
}
