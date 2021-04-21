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
    getInfo();
  }

  getInfo() async{
    Map<String, dynamic> formData = new Map();
    formData['userId'] = uid;
    formData['checkType'] = timeInt;
    print(formData);
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
          return b["date"].compareTo(a["date"]);
        });
        setState(() {

        });
      },
      (error) {
        print(error);
      },
    );
  }

  List<Map> list = new List();
  List<Widget> cardList = new List();
  getId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('uid')) {
      uid = prefs.getString('uid');
      setState(() {

      });
    }
  }
  String uid;
  int timeInt = 1;
  var timeValue;

  @override
  Widget build(BuildContext context) {
    double width_ = MediaQuery.of(context).size.width;

    Container timeScope = new Container(
      color: Colors.lightBlueAccent,
      width: width_,
      height: width_ * 0.15,
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            '时间范围:',
            style: TextStyle(fontSize: 18),
          ),
          DropdownButton(
              value: timeInt,
              icon: Icon(Icons.arrow_right),
              iconSize: 40,
              iconEnabledColor: Colors.green.withOpacity(0.7),
              hint: Text('请选择时间范围'),
              items: [
                DropdownMenuItem(child: Text('三个月'), value: 1),
                DropdownMenuItem(child: Text('半年'), value: 2),
                DropdownMenuItem(child: Text('一年'), value: 3),
                DropdownMenuItem(child: Text('三年'), value: 4)
              ],
              onChanged: (value) {
                timeInt = value;
                getInfo();
                print(timeInt);
                setState(() {
                  timeValue = value;
                });
              })
        ],
      ),
    );

    List<Widget> cardBuild() {
      List<Widget> temp = new List();
      temp.add(timeScope);
      for (Map map in list) {
        Widget w = new Card(
            margin: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
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
            ));
        temp.add(w);
      }
      return temp;
    }

    return new Scaffold(
        appBar: new AppBar(
          title: new Text('门诊病历查询'),
          centerTitle: true,
        ),
        body: new ListView(
          children: cardBuild(),
        ));
  }
}
