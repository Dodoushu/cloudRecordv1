import 'package:cloudrecord/patient/myDoctor/query/doctorDetailPage.dart';
import 'package:cloudrecord/untils/http_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloudrecord/untils/showToast.dart';
import 'dart:developer';

void main() {
  runApp(new MaterialApp(
    title: 'patientResult',
    theme: new ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: new Applying(),
  ));
}

class Applying extends StatefulWidget {
  @override
  _State createState() => new _State();
}

class _State extends State<Applying> {
  List patientList;
  @override
  void initState() {
    patientList = new List();
    getId();

    Future.delayed(Duration(milliseconds: 50), () {
      getInfo();
    });

    setState(() {});
  }

  getInfo() {
    Map map = new Map();
    map['userId'] = uid;
    print(map);
    DioManager.getInstance().post('/AuthoriseList', map, (data) {
      print(data['patients']);
      patientList = new List();
      if (data['patients'] != null) {
        patientList = data['patients'];
      }

      setState(() {});
    }, (error) {
      print(error);
      ShowToast.getShowToast().showToast('网络异常，请稍后再试');
    });
  }

  getId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('uid')) {
      uid = prefs.getString('uid');
    }
    setState(() {});
  }

  List valuelist = new List(65536);
  String uid;

  List<Widget> cardBuild() {
    List<Widget> temp = new List();
    for (int i = 0; i < patientList.length; i++) {
      Map map = patientList[i];

      DateTime now = DateTime.now();
      print(map);
      String birthday2;
      if (map['birthday'].toString().length >= 10) {
        birthday2 = map['birthday'].substring(0, 10);
      } else {
        birthday2 = '1970-01-01';
      }

      DateTime birth = DateTime.parse(birthday2);
      var diff = now.difference(birth);
      int age = (diff.inDays / 365).toInt();

      Widget w = InkWell(
        onTap: () {},
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
                        map['name'] == null ? 'null' : map['name'],
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
                          (map['sex'] == '0') ? '男' : '女',
                          style: TextStyle(fontSize: 18),
                        ),
                      )
                    ],
                  ),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      new Container(
//      padding: EdgeInsets.only(left: 10,right: 10,bottom: 0),
                        height: 40.0,
                        margin: EdgeInsets.only(
                            top: 10.0, bottom: 30, left: 50, right: 50),
                        child: new SizedBox(
                          child: new RaisedButton(
                            elevation: 0,
                            onPressed: () {
                              try {
                                Map formdate = new Map();
                                formdate['agree'] = 1;
                                formdate['userId'] = uid;
                                formdate['patientId'] = map['userId'];
                                print(formdate);
                                DioManager.getInstance()
                                    .post('/DoctorAgree', formdate, (data) {
                                  getInfo();
                                  setState(() {});
                                }, (error) {
                                  print(error);
                                  ShowToast.getShowToast()
                                      .showToast('网络异常，请稍后再试');
                                });
                              } catch (e) {
                                ShowToast.getShowToast().showToast('稍后重试');
                              }
                            },
                            color: Colors.blue,
                            child: new Text(
                              '同意授权',
                              style: TextStyle(
                                  fontSize: 14.0,
                                  color: Color.fromARGB(255, 255, 255, 255)),
                            ),
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(40.0)),
                          ),
                        ),
                      ),
                      new Container(
//      padding: EdgeInsets.only(left: 10,right: 10,bottom: 0),
                        height: 40.0,
                        margin: EdgeInsets.only(
                            top: 10.0, bottom: 30, left: 10, right: 10),
                        child: new SizedBox(
                          child: new RaisedButton(
                            elevation: 0,
                            onPressed: () {
                              try {
                                Map formdate = new Map();
                                formdate['agree'] = 0;
                                formdate['userId'] = uid;
                                formdate['patientId'] = map['userId'];
                                print(formdate);
                                DioManager.getInstance()
                                    .post('/DoctorAgree', formdate, (data) {
                                  getInfo();
                                  setState(() {});
                                }, (error) {
                                  print(error);
                                  ShowToast.getShowToast()
                                      .showToast('网络异常，请稍后再试');
                                });
                              } catch (e) {
                                ShowToast.getShowToast().showToast('稍后重试');
                              }
                            },
                            color: Colors.blue,
                            child: new Text(
                              '拒绝授权',
                              style: TextStyle(
                                  fontSize: 14.0,
                                  color: Color.fromARGB(255, 255, 255, 255)),
                            ),
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(40.0)),
                          ),
                        ),
                      ),
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
        title: new Text('申请列表'),
        centerTitle: true,
      ),
      body: ListView(
        children: cardBuild(),
      ),
    );
  }
}
