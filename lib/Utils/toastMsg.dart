import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utils{
  void toastMessageCorrect(String message , MaterialColor materialColor){
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green.shade400,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }
  void toastMessageWrong(String message , MaterialColor materialColor){
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red.shade400,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }
}