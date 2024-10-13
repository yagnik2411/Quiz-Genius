import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quiz_genius/utils/colors.dart';

class CustomButton extends StatelessWidget {
  final String? text;
  final VoidCallback pressed;
  final Color bgColor;
  final TextStyle? style;
  final double? width;
  final double? height;

  const CustomButton(
      {super.key,
      this.text,
      required this.pressed,
      required this.bgColor,
      this.style,
        this.width=300,
        this.height=60,
      });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: pressed,
      style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(color: MyColors.darkCyan, width: 2)),
          minimumSize: Size((width??300).w, (height??60).h)),
      child: Text("$text", style: style),
    );
  }
}
