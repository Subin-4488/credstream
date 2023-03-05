import 'package:credstream/core/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});
  static Future<void> startLoading(BuildContext context)async {
    Navigator.of(context).pushNamed("loading");
  }

  static void stopLoading(BuildContext context) {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return const SpinKitDancingSquare(
      color: Colors.blue,
    );
  }
}

class Toast {
  static show(BuildContext context, String msg) {
    return Fluttertoast.showToast(
        msg: msg, backgroundColor: Colors.greenAccent, textColor: kBlack);
  }
}
