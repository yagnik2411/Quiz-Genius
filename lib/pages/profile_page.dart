import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:quiz_genius/models/current_user.dart';
import 'package:quiz_genius/utils/colors.dart';
import 'package:velocity_x/velocity_x.dart';

/// ProfilePage displays user profile information including their profile picture, 
/// name, and performance as a percentage. It retrieves this information from Firestore
/// and presents it in a formatted UI.

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // Variables to store user data fetched from Firestore
  String _user = ""; // User's name
  int _performance = 0; // User's performance percentage
  String? _profileImageUrl; // URL for the user's profile image
  
  /// Builds the main UI for the Profile Page.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Calls function to fetch user data from Firestore
      future: userDataFetch(),
      builder: (context, snapshot) {
        // Checks if the data fetching is complete
        if (snapshot.connectionState == ConnectionState.done) {
          return Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor, 
            appBar: AppBar(
              backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
              leading: IconButton(
                onPressed: () {
                  // Navigates back to the previous screen
                  Navigator.pop(context);
                },
                icon: const Icon(CupertinoIcons.back),
              ),
              title: const Text("Quiz Genius").centered(),
            ),
            body: Column(
              children: [
                Column(
                  children: [
                    /// Displays user's profile picture and name
                    Container(
                      height: 200.w,
                      width: 200.w,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.onBackground,
                        border: Border.all(color: Theme.of(context).colorScheme.secondary, width: 2),
                        borderRadius: BorderRadius.circular(40.sp),
                      ),
                      child: Column(
                        children: [
                          // Circle Avatar to display user's profile image
                          CircleAvatar(
                            radius: 50.w,
                            backgroundColor: MyColors.darkCyan,
                            backgroundImage: NetworkImage(
                              CurrentUser.currentUser.profileImage,
                            ), // Sets profile image if available
                            child: CurrentUser.currentUser.profileImage.isEmpty
                              ? SvgPicture.asset(
                                  "assets/images/online_test.svg",
                                  fit: BoxFit.contain,
                                  height: 45.h,
                                  width: 45.w,
                                ) // Placeholder if no image available
                              : null,
                          ).p(10.sp),
                          // Display user name
                          Text(
                            "$_user",
                            style: TextStyle(
                              fontSize: 25.sp,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                          )
                        ],
                      ),
                    ).pOnly(right: 5.sp),
                  ],
                ),
                /// Container to show user's performance in a circular percentage indicator
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.onBackground,
                    border: Border.all(color: Theme.of(context).colorScheme.secondary, width: 2),
                    borderRadius: BorderRadius.circular(20.sp),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Title for performance section
                      Text(
                        "Performance",
                        style: TextStyle(
                          fontSize: 40.sp,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                      SizedBox(height: 30.h),
                      // Circular percentage indicator showing user performance
                      CircularPercentIndicator(
                        radius: 150.w,
                        percent: _performance / 100,
                        lineWidth: 20.w,
                        animateFromLastPercent: true,
                        progressColor: MyColors.mint,
                        backgroundColor: MyColors.mint.withOpacity(0.4),
                        animation: true,
                        animationDuration: 2000,
                        rotateLinearGradient: true,
                        circularStrokeCap: CircularStrokeCap.round,
                        curve: Curves.easeInOutCirc,
                        center: Text(
                          "$_performance%",
                          style: TextStyle(
                            fontSize: 60.sp,
                            color: MyColors.darkCyan,
                          ),
                        ),
                      ),
                    ],
                  ),
                ).pOnly(top: 10.sp).expand()
              ],
            ).pOnly(top: 20.sp, right: 10.sp, left: 10.sp, bottom: 20.sp),
          );
        } else {
          // Shows loading spinner while fetching data
          return Container(
            decoration: const BoxDecoration(
              color: MyColors.lightCyan,
            ),
            child: const Center(
              child: CircularProgressIndicator(
                color: MyColors.malachite,
                backgroundColor: MyColors.lightCyan,
              ),
            ),
          );
        }
      },
    );
  }

  /// Fetches user data from Firestore and updates the current state.
  ///
  /// Retrieves user's name, performance percentage, and profile image URL
  /// and stores them in the state variables. Updates the CurrentUser's
  /// profile image as well.
  userDataFetch() async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(CurrentUser.currentUser.email) // Retrieves document by user's email
        .get()
        .then((data) {
      // Updates state variables with fetched data
      _user = data['userName'];
      _performance = data['performance'];
      _profileImageUrl = data['profileImage'];
    });
    // Updates current user's profile image
    CurrentUser.currentUser.profileImage = _profileImageUrl ?? "";
  }
}
