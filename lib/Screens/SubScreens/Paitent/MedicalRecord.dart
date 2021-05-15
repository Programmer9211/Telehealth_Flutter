import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toast/toast.dart';

class MedicalReport extends StatefulWidget {
  @override
  _MedicalReportState createState() => _MedicalReportState();
}

class _MedicalReportState extends State<MedicalReport> {
  String uid = FirebaseAuth.instance.currentUser.uid;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  File image;
  String imageUrl;

  @override
  void initState() {
    super.initState();
    getImage();
  }

  Future getImage() async {
    try {
      await _firestore
          .collection('paitent')
          .doc(uid)
          .collection('report')
          .doc(uid)
          .get()
          .then((value) {
        if (mounted) {
          imageUrl = value.data()['image'];
          setState(() {});
        }
        print(value.data()['image']);
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
              .doc(uid)
              .collection('report')
              .doc(uid)
              .set({"image": value});

          getImage();
        } else {
          Toast.show("An Error Occured while uploading Image", context);
        }
      });
    } catch (e) {
      Toast.show("An Error Occured while uploading Image", context);
    }
  }

  Future selectImage() async {
    ImagePicker pick = ImagePicker();
    Navigator.pop(context);

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

  void onTap(BuildContext context, Size size) {
    showModalBottomSheet(
      context: context,
      builder: (_) => Container(
        height: size.height / 5,
        width: size.width,
        child: Column(
          children: [
            Container(
              width: size.width / 1.1,
              height: size.height / 16,
              alignment: Alignment.centerLeft,
              child: Text(
                "Add Files",
                style: TextStyle(fontSize: size.width / 24),
              ),
            ),
            ListTile(
              onTap: selectImage,
              leading: Icon(Icons.upload_file),
              title: Text(
                "Upload Files",
                style: TextStyle(
                  fontSize: size.width / 25,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text("Medical Records"),
        backgroundColor: Color.fromRGBO(55, 82, 178, 1),
      ),

      //

      body: imageUrl != null
          ? Center(
              child: Container(
                height: size.height / 1.5,
                width: size.width / 1.1,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(imageUrl),
                  ),
                ),
              ),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: size.width,
                  alignment: Alignment.center,
                  child: Text(
                    "Add a Medical Record",
                    style: TextStyle(
                      fontSize: size.width / 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Container(
                  height: size.height / 14,
                  width: size.width,
                  alignment: Alignment.center,
                  child: Text(
                    "A Detail Health history helps Doctor\nDiagnose you better",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: size.width / 25,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),

      //

      bottomNavigationBar: Container(
        height: size.height / 10,
        width: size.width,
        color: Colors.white,
        alignment: Alignment.center,
        child: GestureDetector(
          onTap: () => onTap(context, size),
          child: Container(
            height: size.height / 14,
            width: size.width / 1.2,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.blue,
            ),
            child: Text(
              "Add Medical Record",
              style: TextStyle(
                color: Colors.white,
                fontSize: size.width / 22,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
