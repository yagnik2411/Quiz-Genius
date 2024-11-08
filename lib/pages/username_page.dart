import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quiz_genius/models/current_user.dart';
import 'package:quiz_genius/utils/colors.dart';
import 'package:quiz_genius/utils/my_route.dart';
import 'package:velocity_x/velocity_x.dart';
import '../utils/profile_image_service.dart';

// UserName class for setting the username and uploading a profile image.
class UserName extends StatefulWidget {
  UserName({super.key});

  @override
  State<UserName> createState() => _UserNameState();
}

class _UserNameState extends State<UserName> {
  late String _username; // Variable to hold the username
  final ProfileImageService _imageUploader = ProfileImageService(); // Service for uploading images
  String _profileImageUrl = ""; // Variable to store the URL of the uploaded profile image

  // Method to navigate to the home page after setting the username
  void moveToHome(BuildContext context) {
    CurrentUser.currentUser.setUserName(_username); // Set the username in CurrentUser model
    CurrentUser.currentUser.add(context: context); // Add the user to the current context
    Navigator.pushReplacementNamed(context, MyRoutes.homeRoute); // Navigate to the home route
  }

  // Method to upload profile image and retrieve the URL
  void uploadProfileImage(BuildContext context) async {
    // Pick an image
    File? imageFile = await _imageUploader.pickAndUploadImage();
    // Call the image uploader
    if (imageFile != null) {
      String? downloadUrl =
          await _imageUploader.uploadImageToFirebase(imageFile); // Upload image and get URL

      if (downloadUrl != null) {
        setState(() {
          _profileImageUrl = downloadUrl; // Set the image URL
          CurrentUser.currentUser.profileImage =
              _profileImageUrl; // Save URL in CurrentUser model
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.5),
      body: Center(
        child: Container(
          height: (1500 / 5).h,
          width: (393 / 1.3).w,
          decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                color: MyColors.elfGreen,
                blurRadius: 25,
                offset: Offset(0, 0),
                blurStyle: BlurStyle.outer,
              ),
            ],
            border: Border.all(
              color: MyColors.darkCyan,
              width: 2,
            ),
            color: MyColors.seaGreen,
            borderRadius: BorderRadius.circular(20.sp),
          ),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                CircleAvatar(
                  radius: 52,
                  backgroundColor: MyColors.darkCyan,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: _profileImageUrl
                            .trim()
                            .isNotEmpty // Check for trimmed empty string
                        ? NetworkImage(
                            _profileImageUrl.trim()) // Use trimmed URL
                        : null,
                    backgroundColor: Colors.white,
                  ),
                ),
                // Only show the icon if no image is uploaded
                if (_profileImageUrl
                    .trim()
                    .isEmpty) // Check for trimmed empty string
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Center(
                      child: Icon(
                        Icons.person,
                        size: 80,
                        color: MyColors.grey,
                      ),
                    ),
                  ),
                Positioned(
                  right: 0.0,
                  bottom: 0.0,
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: MyColors.darkCyan,
                    child: IconButton(
                      onPressed: () {
                        uploadProfileImage(context); // Upload profile image on button press
                        print("Camera opened!");
                      },
                      icon:
                          Icon(Icons.camera_alt_outlined, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
            // Text field for entering username
            TextFormField(
              onChanged: (value) {
                _username = value; // Update username on change
              },
              decoration: InputDecoration(
                hintText: "eg: abc123",
                hintStyle: TextStyle(
                  color: Colors.deepPurple.withOpacity(0.4),
                ),
                labelText: "Username",
              ),
            ).px(16.sp),
            // Button to proceed to home
            ElevatedButton(
              onPressed: () {
                moveToHome(context); // Navigate to home on button press
              },
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(MyColors.mint),
                elevation: WidgetStateProperty.all(10),
                side: WidgetStateProperty.all(
                    const BorderSide(color: Colors.white)),
                shape: WidgetStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.sp),
                  ),
                ),
              ),
              child: const Text("Sign in"),
            ).px(12.sp),
          ]),
        ),
      ),
    );
  }
}
