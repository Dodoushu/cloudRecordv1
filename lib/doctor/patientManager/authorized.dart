import 'package:cloudrecord/patient/myDoctor/query/doctorDetailPage.dart';
import 'package:cloudrecord/untils/http_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloudrecord/untils/showToast.dart';
import 'dart:developer';
import 'recordInquery.dart';

//void main() {
//  runApp(new MaterialApp(
//    title: 'patientResult',
//    theme: new ThemeData(
//      primarySwatch: Colors.blue,
//    ),
//    home: new PatientResult(),
//  ));
//}

class Authorized extends StatefulWidget {
  @override
  _State createState() => new _State();
}

class _State extends State<Authorized> {
  @override
  void initState() {
    getId();



    Future.delayed(Duration(milliseconds: 100), () {
      getDoctorList();
    });

    setState(() {});
  }

  void getDoctorList() async {
    typemap['1'] = '3天';
    typemap['2'] = '1周';
    typemap['3'] = '2周';
    typemap['4'] = '1月';
    typemap['5'] = '3月';
    typemap['6'] = '半年';
    typemap['7'] = '永久';
    Map map = new Map();
    map['userId'] = uid;
    print(map);
    await DioManager.getInstance().post('/AuthorisedPatientList', map, (data) {
      print(data);
      if(data["patients"] != null){
        patientList = data["patients"];
      }
      setState(() {});
    }, (error) {
      print(error);
      ShowToast.getShowToast().showToast('网络异常，请稍后再试');
    }, ContentType: 'application/json');

  }

  Map typemap = new Map();
  Map<int, int> doctorid2type = new Map();
  List<Map> infoList = new List();
  getId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('duid')) {
      uid = await prefs.getString('duid');
    }
    setState(() {});
  }

  String uid;
  List patientList = new List();

  List<Widget> cardBuild() {
    print(1);
    List<Widget> temp = new List();
    for (Map map in patientList) {

      DateTime now = DateTime.now();
      print(map);
      String birthday2;
      if(map['birthday'].toString().length>=10){
        birthday2 = map['birthday'].substring(0,10);
      }else{
        birthday2 = '1970-01-01';
      }

      DateTime birth = DateTime.parse(birthday2);
      var diff = now.difference(birth);
      int age = (diff.inDays/365).toInt();

      Widget w = InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => new RecordInquery(map["userId"].toString())));
        },
        child: new Card(
            margin: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
            child: Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              child: new Column(
                children: [
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '姓名：',
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        map['name']==null?'null':map['name'],
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '年龄：',
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        age.toString(),
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '性别：',
                        style: TextStyle(fontSize: 18),
                      ),
                      Flexible(
                        child: Text(
                          (map['sex'] == 0)?'男':'女',
                          style: TextStyle(fontSize: 18),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            )),
      );
      temp.add(w);
    }
    return temp;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('授权列表'),
        centerTitle: true,
      ),
      body: ListView(
        children: cardBuild(),
      ),
    );
  }
}
