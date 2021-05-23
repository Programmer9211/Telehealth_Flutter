import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tele_health_app/Screens/SubScreens/Doctor/Drawer.dart';
import 'package:toast/toast.dart';
import 'package:tele_health_app/Screens/SubScreens/Paitent/Profile.dart';

class DoctorHomescreen extends StatefulWidget {
  final SharedPreferences prefs;
  DoctorHomescreen({this.prefs});
  @override
  _DoctorHomescreenState createState() => _DoctorHomescreenState();
}

class _DoctorHomescreenState extends State<DoctorHomescreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Map<String, dynamic> profileMap;
  File image;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _updateDataController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getProfile();
  }

  Future getProfile() async {
    try {
      await _firestore
          .collection('doctor')
          .doc(_auth.currentUser.uid)
          .get()
          .then((value) {
        setState(() {
          profileMap = value.data();
          print(profileMap);
        });
      });
    } catch (e) {
      Toast.show("An error occured", context);
    }
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
              .collection('doctor')
              .doc(_auth.currentUser.uid)
              .update({"image": value});

          getProfile();
        } else {
          Toast.show("An Error Occured while uploading Image", context);
        }
      });
    } catch (e) {
      Toast.show("An Error Occured while uploading Image", context);
    }
  }

  void showOptions() {
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
                if (profileMap["image"] != "i") {
                  Navigator.pop(context);
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => ViewImage(
                        imageUrl: profileMap['image'],
                      ),
                    ),
                  );
                } else {
                  Toast.show("Please upload a image first", context,
                      duration: 2);
                }
              },
              title: Text("View Image"),
              leading: Icon(Icons.view_list),
            )
          ],
        ),
      ),
    );
  }

  void updateData(String title) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              title: Text(title),
              content: TextField(
                controller: _updateDataController,
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("Cancel"),
                ),
                TextButton(
                  onPressed: () async {
                    await _firestore
                        .collection('doctor')
                        .doc(_auth.currentUser.uid)
                        .update({title: _updateDataController.text}).then(
                            (value) {
                      getProfile();
                      Toast.show("Updated", context);
                    });

                    _updateDataController.clear();

                    Navigator.pop(context);
                  },
                  child: Text("Update"),
                )
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return profileMap != null
        ? SafeArea(
            child: Scaffold(
              key: _scaffoldKey,
              drawer: DoctorDrawer(widget.prefs, profileMap['name'],
                  profileMap['email'], profileMap['image']),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    header(size),
                    InkWell(
                      onTap: showOptions,
                      child: Card(
                        shape: CircleBorder(),
                        elevation: 5,
                        child: Container(
                          height: size.height / 4,
                          width: size.width / 2,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: NetworkImage(profileMap['image'] != "i"
                                  ? profileMap['image']
                                  : "https://image.freepik.com/free-vector/cartoon-male-doctor-holding-clipboard_29190-4660.jpg"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                    editTile(profileMap['name'], 'name'),
                    SizedBox(
                      height: size.height / 50,
                    ),
                    editTile(profileMap['qualification'], 'qualification'),
                    SizedBox(
                      height: size.height / 50,
                    ),
                    editTile(profileMap['ed'], 'ed'),
                    SizedBox(
                      height: size.height / 50,
                    ),
                    editTile("Experience: ${profileMap['experience']} years",
                        'experience'),
                    SizedBox(
                      height: size.height / 50,
                    ),
                    editTile("Fee ${profileMap['fee']}/hr", 'fee'),
                    SizedBox(
                      height: size.height / 50,
                    ),
                  ],
                ),
              ),
            ),
          )
        : Scaffold(
            body: Center(
              child: Container(
                height: size.height / 20,
                width: size.height / 20,
                child: CircularProgressIndicator(),
              ),
            ),
          );
  }

  Widget editTile(String text, String key) {
    return ListTile(
      onTap: () => updateData(key),
      title: Text(text),
      trailing: Icon(
        Icons.edit,
        color: Colors.grey,
      ),
    );
  }

  Widget header(Size size) {
    return Container(
      width: size.width,
      alignment: Alignment.center,
      child: Container(
        height: size.height / 10,
        width: size.width / 1.1,
        alignment: Alignment.centerLeft,
        child: InkWell(
          onTap: () => _scaffoldKey.currentState.openDrawer(),
          child: Icon(Icons.menu),
        ),
      ),
    );
  }
}
