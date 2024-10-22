import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quiz_genius/utils/colors.dart';

//Upload Image
class ProfileImageService {
  final ImagePicker _imagePicker = ImagePicker();
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //Method
  Future<File?> pickAndUploadImage() async {
    //initialize

    try {
      final XFile? image = await _imagePicker.pickImage(
          source: ImageSource.gallery, imageQuality: 100);

      //Check if image is not null
      if (image != null) {
        return File(image.path);
      }
    } catch (e) {
      print('Error picking image:$e');
      Fluttertoast.showToast(
        msg: "No image selected.Please try Again",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: MyColors.lightCyan,
        textColor: Colors.black,
        fontSize: 16.0,
      );
    }
    return null;
  }

  //Function to upload the image to Firebase storage and get the download URl

  Future<String?> uploadImageToFirebase(File imageFile) async {
    try {
      String? userId = _auth.currentUser?.uid;
      if (userId == null) return null;
      // Reference to where the image will be stored in Firebase Storage
      Reference storageRef =
          _storage.ref().child("profile_images/$userId/profile.jpg");
      // Upload the image file
      UploadTask uploadTask = storageRef.putFile(imageFile);
      TaskSnapshot snapshot = await uploadTask;

      // Get the download URL of the uploaded image
      String downloadUrl = await snapshot.ref.getDownloadURL();
      print("Profile image uploaded Successfully");

      // Show success message using FlutterToast
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
      // Handle any errors that occur during the upload process
      print("Error uploading Image:$e");

      print("Error occurred:$e\n");
      Fluttertoast.showToast(
        msg: "Failed to upload image. Please try again.$e",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: MyColors.seaGreen,
        textColor: Colors.black,
        fontSize: 16.0,
      );
      return null;
    }
  }
}
