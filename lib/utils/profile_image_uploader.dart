import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart ';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quiz_genius/models/current_user.dart';
import 'package:quiz_genius/utils/colors.dart';
class ProfileImageUploader {
  final FirebaseStorage _storage = FirebaseStorage.instance;


  //Method
  Future<String?> pickAndUploadImage(BuildContext context) async {
    //initialize
    final ImagePicker imagePicker = ImagePicker();
    final XFile? image =
        await imagePicker.pickImage(source: ImageSource.gallery);

    //Check if image is not null
    if (image != null) {
      //use the currentUser's email from the currentUserModel
      String email = CurrentUser.currentUser.email;
      String imageFile = "profile_$email.png";
      Reference storageRef = _storage.ref().child("progileImages/$imageFile");

      try {
        // Upload the file to Firebase Storage
        await storageRef.putFile(File(image.path));

        //Get Download URL after successfully upload
        String downloadUrl=await storageRef.getDownloadURL();

        print("Profile image uploaded Successfully");
        Fluttertoast.showToast(
          msg: "Profile image uploaded successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: MyColors.mint,
          textColor: Colors.black,
          fontSize: 16.0,
        );
        return downloadUrl;

      } catch (e) {
        print("Error occurred:$e\n");
        Fluttertoast.showToast(
          msg: "Failed to upload image. Please try again.$e",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: MyColors.seaGreen,
          textColor: Colors.black,
          fontSize: 16.0,
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("No image selected. image.Please try Again")));
      Fluttertoast.showToast(
        msg: "No image selected. image.Please try Again",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor:MyColors.lightCyan,
        textColor: Colors.black,
        fontSize: 16.0,
      );
    }
    return null;
  }
}
