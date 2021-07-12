import 'package:cloudrecord/patient/myDoctor/query/doctorDetailPage.dart';
import 'package:cloudrecord/untils/http_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloudrecord/untils/showToast.dart';
import 'dart:developer';

//void main() {
//  runApp(new MaterialApp(
//    title: 'patientResult',
//    theme: new ThemeData(
//      primarySwatch: Colors.blue,
//    ),
//    home: new PatientResult(),
//  ));
//}

class PatientRecord extends StatefulWidget {
  String uid;
  PatientRecord(String uid){
    this.uid = uid;
  }
  @override
  _PatientRecord createState() => new _PatientRecord(uid);
}

class _PatientRecord extends State<PatientRecord> {

  String uid;
  List MessageList = new List();

  _PatientRecord(String uid) {
    this.uid = uid;
  }

  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 100), () {
      getMessageList();
    });
    setState(() {
    });
  }

//  getid() async {
//    SharedPreferences prefs = await SharedPreferences.getInstance();
//    if (prefs.containsKey('uid')) {
//      uid = await prefs.getString('uid');
//    }
//    setState(() {});
//  }
  void getMessageList() async {
    Map map = new Map();
    map['userId'] = uid;
    await DioManager.getInstance().post('/DoctorSeeMessage', map, (data) {
      if (data['leaveMessage'] != null) {
        print("***");
        MessageList = data['leaveMessage'];
        print(MessageList);
      }
      print(data);
      setState(() {});
    }, (error) {
      print(error);
      ShowToast.getShowToast().showToast('网络异常，请稍后再试');
    }, ContentType: 'application/json');
  }


  List<Widget> cardBuild() {
    List<Widget> Carlist = new List();
    for (Map map in MessageList) {
      Widget card = Card(
        margin: EdgeInsets.only(left: 15, right: 15, top: 3, bottom: 3),
        child: Container(
          margin: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
          child: new Column(
            children: [
              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '留言时间：',
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    map['date'] == null ? 'null' : map['date'],
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '留言内容：',
                    style: TextStyle(fontSize: 20),
                  ),
                  Flexible(
                    child: Text(
                      (map['leaveMessage'] == null)
                          ? 'null'
                          : map['leaveMessage'],
                      style: TextStyle(fontSize: 20),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      );
      Carlist.add(card);
    }
    return Carlist;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('消息列表'),
        centerTitle: true,
      ),
      body: ListView(
          children: cardBuild()
      ),
    );
  }
}
