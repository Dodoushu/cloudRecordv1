import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

class ShowToast {

  //单例
  static ShowToast _showToast;

  static ShowToast getShowToast(){
    if(_showToast == null){
      _showToast = ShowToast();
    }
    return _showToast;
  }

  void showToast(String string){
    Fluttertoast.showToast(
        msg: string,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black54,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }

}