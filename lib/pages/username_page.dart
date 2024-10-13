import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quiz_genius/models/current_user.dart';
import 'package:quiz_genius/utils/colors.dart';
import 'package:quiz_genius/utils/my_route.dart';
import 'package:quiz_genius/utils/widget/profile_image_uploader.dart';
import 'package:velocity_x/velocity_x.dart';

import '../utils/widget/custom_button.dart';
import '../utils/widget/custom_text_form.dart';

// ignore: must_be_immutable
class UserName extends StatefulWidget {
  UserName({super.key});

  @override
  State<UserName> createState() => _UserNameState();
}

class _UserNameState extends State<UserName> {
  final TextEditingController _usernameController = TextEditingController();

  final ProfileImageUploader _imageUploader = ProfileImageUploader();
  String _profileImageUrl = " ";

  moveToHome(BuildContext context) {
    CurrentUser.currentUser.setUserName(_usernameController.text);
    CurrentUser.currentUser.add(context: context);
    Navigator.pushReplacementNamed(context, MyRoutes.homeRoute);
  }

  //method upload profile Image & get Url
  void uploadProfileImage(BuildContext context) async {
    //call the image uploader
    String? downloadUrl = await _imageUploader.pickAndUploadImage(context);

    if (downloadUrl != null) {
      setState(() {
        _profileImageUrl = downloadUrl; // Set the image URL
        CurrentUser.currentUser.profileImage =
            _profileImageUrl; // Save in CurrentUser model
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.5),
      body: Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10.h),
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
                        uploadProfileImage(context);
                        print("Camera opened!");
                      },
                      icon:
                          Icon(Icons.camera_alt_outlined, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15.h,
            ),
            CustomTextForm(
              controller: _usernameController,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Username cannot be empty';
                } else if (value.trim().length < 3) {
                  return 'Username must be at least 3 characters long';
                }
                return null; // No error if valid
              },
              labelText: 'UserName',
              labelStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600),
              hintText: "eg:Name",
              keyboard: TextInputType.emailAddress,
              icon: Icon(
                Icons.person_outlined,
                color: Colors.black.withOpacity(0.7),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            CustomButton(
              pressed: () {
                moveToHome(context);
              },
              bgColor: MyColors.malachite,
              text: "Sign in",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold),
              width: 120.w,
              height: 50.h,
            ),
          ]),
        ),
      ),
    );
  }
}
