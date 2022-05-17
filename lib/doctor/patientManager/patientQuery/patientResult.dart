import 'package:cloudrecord/untils/http_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloudrecord/untils/showToast.dart';
import 'dart:developer';

void main() {
  List list1 = new List();
  Map map1 = new Map();
  map1['birthday'] = '1996-01-01';
  map1['name'] = '胡广生';
  map1['sex'] = 0;
  list1.add(map1);

  Map map2 = new Map();
  map2['birthday'] = '1999-01-01';
  map2['name'] = '刘东';
  map2['sex'] = 0;
  list1.add(map2);

  runApp(new MaterialApp(
    title: 'patientResult',
    theme: new ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: new PatientResult(list1),
  ));
}

class PatientResult extends StatefulWidget {
  @override
  PatientResult(List list) {
    this.list = list;
  }
  List list;
  @override
  _State createState() => new _State(list);
}

class _State extends State<PatientResult> {
  @override
  _State(List list) {
    if(list != null){
      patientList = list;
    }
  }

  @override
  void initState() {
    getId();
    setState(() {

    });
  }

  getId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('duid')) {
      uid = prefs.getString('duid');
    }
  }
  String uid;
  List patientList = new List();

  List<Widget> cardBuild() {
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
        onTap: (){
//          Navigator.push(context, MaterialPageRoute(builder: (context)=>new detailPage(map)));
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
                  //author
                  Center(
                    child: 1!=1?
                    RaisedButton(
                      elevation: 0,
//                      onPressed: () async {
//
//                      },
                      disabledColor: Colors.grey,
                      color: Colors.blue,
                      child: new Text(
                        '已授权',
                        style: TextStyle(
                            fontSize: 12.0,
                            color: Color.fromARGB(255, 255, 255, 255)),
                      ),
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(10.0)),
                    )
                        :
                    RaisedButton(
                      elevation: 0,
                      onPressed: () async {

                        Map formdata = new Map();
                        formdata['userId'] = uid;
                        formdata['patientId'] = map['userId'];

                        print(formdata);

                        DioManager.getInstance().post('DoctorApply', formdata,
                                (data) {
                          ShowToast.getShowToast().showToast('申请已发送，请耐心等待');
                            }, (error) {
                              print(error);
                              ShowToast.getShowToast().showToast('网络异常，请稍后再试');
                            });
                      },
                      disabledColor: Colors.grey,
                      color: Colors.blue,
                      child: new Text(
                        '申请授权',
                        style: TextStyle(
                            fontSize: 12.0,
                            color: Color.fromARGB(255, 255, 255, 255)),
                      ),
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(10.0)),
                    ),
                  )
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
        title: new Text('查询结果'),
        centerTitle: true,
      ),
      body: ListView(children: cardBuild(),),
    );
  }
}
