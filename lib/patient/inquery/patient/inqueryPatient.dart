import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:cloudrecord/untils/http_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(new MaterialApp(
    title: '门诊病历查询',
    theme: new ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: new InqueryPatient(),
  ));
}

class InqueryPatient extends StatefulWidget {
  @override
  _State createState() => new _State();
}

class _State extends State<InqueryPatient> {
  @override
  void initState() {
    super.initState();

    getId();

    Map<String, dynamic> formData = new Map();
    formData['userId'] = '30';
    formData['checkType'] = 4;
    DioManager.getInstance().post(
      'SelectOutPatientRecords',
      formData,
      (data) {
        for (Map map in data['outPatientTreatRecords']) {
          map['class'] = '治疗记录';
          list.add(map);
        }
        for (Map map in data['outPatientClinicRecords']) {
          map['class'] = '门诊病历';
          list.add(map);
        }
        for (Map map in data['outPatientPrescriptionRecords']) {
          map['class'] = '处方记录';
          list.add(map);
        }
        list.sort((Map a, b) {
          return a["date"].compareTo(b["date"]);
        });
//        log(list.toString());
      },
      (error) {
        print(error);
      },
    );
  }

  List<Map> list = new List();
  List<Widget> cardList = new List();
  String uid;
  getId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('uid')) {
      uid = prefs.getString('uid');
    }
  }

  @override
  Widget build(BuildContext context) {
    double width_ = MediaQuery.of(context).size.width;

    List<Widget> cardBuild() {
      List<Widget> temp = new List();
      for (Map map in list) {
        Widget w = new Card(
          margin: EdgeInsets.only(left: 15, right: 15,top: 10, bottom: 10),
          child: Container(
            margin: EdgeInsets.only(left: 10, right: 10),
            child: new Column(
              children: [
                new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '种类：',
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      map['class'],
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),

                new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '时间：',
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      map['date'],
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '医院：',
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      map['hospital'],
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ],
            ),
          )
        );
        temp.add(w);
      }
      return temp;
    }

    return new Scaffold(
      appBar: new AppBar(
        title: new Text(''),
      ),
      body: new ListView(
        children: cardBuild(),
      )
    );
  }
}
