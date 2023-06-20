import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quiz_genius/utils/colors.dart';
import 'package:velocity_x/velocity_x.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          Row(
            children: [
              Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: MyColors.malachite, width: 2),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: CircleAvatar(
                  backgroundColor: Colors.grey.withOpacity(0.2),
                  radius: 65,
                  child: SvgPicture.asset(
                    "assets/images/online_test.svg",
                    fit: BoxFit.contain,
                    height: 45,
                    width: 45,
                  ),
                ).p(10),
              ).pOnly(right: 5),
              Container(
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: MyColors.malachite, width: 2),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "User:Yagnik",
                      style: TextStyle(
                        fontSize: 20,
                        color: MyColors.darkCyan,
                      ),
                    ).pOnly(left: 10, top: 10),
                    Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          "Performace:87%",
                          style: TextStyle(
                            fontSize: 20,
                            color: MyColors.darkCyan,
                          ),
                        ).centered()),
                  ],
                ).p12(),
              ).pOnly(left: 5).expand(),
            ],
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: MyColors.malachite, width: 2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(MyColors.mint),
                    elevation: MaterialStateProperty.all(10),
                    side: MaterialStateProperty.all(
                        const BorderSide(color: Colors.white)),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    fixedSize: MaterialStateProperty.all(
                        Size(context.screenWidth * 0.9, 45)),
                  ),
                  child: Text(
                    "Edit Profile Picture",
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ).pOnly(top: 10, right: 12, left: 12, bottom: 5),
                ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(MyColors.mint),
                    elevation: MaterialStateProperty.all(10),
                    side: MaterialStateProperty.all(
                        const BorderSide(color: Colors.white)),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    fixedSize: MaterialStateProperty.all(
                        Size(context.screenWidth * 0.9, 45)),
                  ),
                  child: Text(
                    "Verify Email",
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ).pOnly(top: 5, right: 12, left: 12, bottom: 5),
              ],
            ),
          ).pOnly(top: 10).expand()
        ],
      ).pOnly(top: 20, right: 10, left: 10, bottom: 20),
    );
  }
}
