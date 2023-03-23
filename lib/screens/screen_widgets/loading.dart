import 'package:credstream/core/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return const SpinKitDancingSquare(
      color: Colors.blue,
    );
  }
  
}

class Toast {
  static show(BuildContext context, String msg) async{
    return await Fluttertoast.showToast(
        msg: msg, backgroundColor: Colors.greenAccent, textColor: kBlack);
  }
}
