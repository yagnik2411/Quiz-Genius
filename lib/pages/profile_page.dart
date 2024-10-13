import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:quiz_genius/models/current_user.dart';
import 'package:quiz_genius/utils/colors.dart';
import 'package:velocity_x/velocity_x.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String _user = "";
  int _performance = 0;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: userDataFetch(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
              backgroundColor: MyColors.lightCyan,
              appBar: AppBar(
                backgroundColor: MyColors.mint,
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(CupertinoIcons.back),
                ),
                title: const Text("Quiz Genius").centered(),
              ),
              body: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border:
                          Border.all(color: MyColors.malachite, width: 2),
                      borderRadius: BorderRadius.circular(40.sp),
                    ),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 50.w,
                          backgroundColor: MyColors.darkCyan,
                          backgroundImage: NetworkImage(
                              CurrentUser.currentUser.profileImage),
                          // Use this line to set the image
                          child: CurrentUser.currentUser.profileImage.isEmpty
                              ? SvgPicture.asset(
                            "assets/images/online_test.svg",
                            fit: BoxFit.contain,
                            height: 45.h,
                            width: 45.w,
                          )
                              : null,
                        ).p(16.sp),
                        Text(
                          "$_user",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 25.sp,
                            color: MyColors.darkCyan,

                          ),
                        )
                      ],
                    ),
                  ).pOnly(right: 5.sp),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: MyColors.malachite, width: 2),
                      borderRadius: BorderRadius.circular(20.sp),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Performance",
                          style: TextStyle(
                            fontSize: 40.sp,
                            color: MyColors.darkCyan,
                          ),
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                        CircularPercentIndicator(
                          radius: 150.w,
                          percent: _performance/100,
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
                        )
                      ],
                    ),
                  ).pOnly(top: 10.sp).expand()
                ],
              ).pOnly(top: 20.sp, right: 10.sp, left: 10.sp, bottom: 20.sp),
            );
          } else {
            return Container(
              decoration: const BoxDecoration(
                color: MyColors.lightCyan,
              ),
              child: const Center(
                  child: CircularProgressIndicator(
                color: MyColors.malachite,
                backgroundColor: MyColors.lightCyan,
              )),
            );
          }
        });
  }

  userDataFetch() async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(CurrentUser.currentUser.email)
        .get()
        .then((data) {
      _user = data['userName'];
      _performance = data['performance'];
    });
  }
}
