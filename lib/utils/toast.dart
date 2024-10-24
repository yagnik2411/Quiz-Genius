import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:quiz_genius/utils/colors.dart';

/// Function to display a Toast message using FlutterToast.
toMassage({required String msg}) {
  Fluttertoast.showToast(
    msg: msg,
    fontSize: 10,
    gravity: ToastGravity.BOTTOM,
    textColor: MyColors.seaGreen,
    backgroundColor: Colors.black,
  );
}
