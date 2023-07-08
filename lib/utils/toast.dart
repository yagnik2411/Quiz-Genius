import 'package:fluttertoast/fluttertoast.dart';
import 'package:quiz_genius/utils/colors.dart';

toMassage({required String msg}) {
  Fluttertoast.showToast(
    msg: msg,
    fontSize: 10,
    gravity: ToastGravity.BOTTOM,
    textColor: MyColors.seaGreen,
    backgroundColor: MyColors.elfGreen,
  );
  
}
