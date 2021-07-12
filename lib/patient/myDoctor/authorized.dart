import 'package:cloudrecord/patient/myDoctor/query/doctorDetailPage.dart';
import 'package:cloudrecord/untils/http_service.dart';
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
    await DioManager.getInstance().post('/PatientSelectedDoctor', map, (data) {
      for (map in data['patientAndDoctorConnects']) {
        doctorid2type[map['doctorId']] = map['type'];
      }
      infoList.clear();
      for (map in data['doctorRegisters']) {
        map['type'] = doctorid2type[map['id']].toString();
        infoList.add(map);
        print(map);
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
    if (prefs.containsKey('puid')) {
      uid = await prefs.getString('puid');
    }
    setState(() {});
  }

  String uid;
  List patientList;

  List<Widget> cardBuild() {
    print(1);
    List<Widget> temp = new List();
    for (Map map in infoList) {
      Widget w = InkWell(
        onTap: () {
//          Navigator.push(
//              context,
//              MaterialPageRoute(
//                  builder: (context) => new DoctorDetailPage(map)));
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
                        map['name'] == null ? 'null' : map['name'],
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '科室：',
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        map['section'],
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '职称：',
                        style: TextStyle(fontSize: 18),
                      ),
                      Flexible(
                        child: Text(
                          map['jobTitle'],
                          style: TextStyle(fontSize: 18),
                        ),
                      )
                    ],
                  ),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '医院：',
                        style: TextStyle(fontSize: 18),
                      ),
                      Flexible(
                        child: Text(
                          map['hospital'],
                          style: TextStyle(fontSize: 18),
                        ),
                      )
                    ],
                  ),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '授权期限：',
                        style: TextStyle(fontSize: 18),
                      ),
                      Flexible(
                        child: Text(
                          typemap[map['type']]==null?"无":typemap[map['type']],
                          style: TextStyle(fontSize: 18),
                        ),
                      )
                    ],
                  ),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      new Container(
//      padding: EdgeInsets.only(left: 10,right: 10,bottom: 0),
                        height: 40.0,
                        margin: EdgeInsets.only(
                            top: 0.0, bottom: 30, left: 50, right: 50),
                        child: new RaisedButton(
                          elevation: 0,
                          onPressed: () {
                            try {
                              Map formdata = new Map();
                              formdata['userId'] = uid;
                              formdata['doctorId'] = map['id'];
                              print(formdata);
                              DioManager.getInstance()
                                  .post('/PatientUnauthoriseDoctor', formdata,
                                      (data) {
                                print('success');
                                getDoctorList();
                              }, (error) {
                                print(error);
                                ShowToast.getShowToast()
                                    .showToast('网络异常，请稍后再试');
                              }, ContentType: 'application/json');
                            } catch (e) {
                              ShowToast.getShowToast().showToast('稍后重试');
                            }
                          },
                          color: Colors.blue,
                          child: new Text(
                            '取消授权',
                            style: TextStyle(
                                fontSize: 14.0,
                                color: Color.fromARGB(255, 255, 255, 255)),
                          ),
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(40.0)),
                        ),
                      )
                    ],
                  ),
                  //author
//                  Center(
//                    child: 1!=1?
//                    RaisedButton(
//                      elevation: 0,
////                      onPressed: () async {
////
////                      },
//                      disabledColor: Colors.grey,
//                      color: Colors.blue,
//                      child: new Text(
//                        '已授权',
//                        style: TextStyle(
//                            fontSize: 12.0,
//                            color: Color.fromARGB(255, 255, 255, 255)),
//                      ),
//                      shape: new RoundedRectangleBorder(
//                          borderRadius: new BorderRadius.circular(10.0)),
//                    )
//                        :
//                    RaisedButton(
//                      elevation: 0,
//                      onPressed: () async {
//
//                        Map formdata = new Map();
//                        formdata['doctorId'] = uid;
//                        formdata['patientId'] = map['userId'];
//
//                        print(formdata);
//
//                        DioManager.getInstance().post('DoctorWatchPatient', formdata,
//                                (data) {
//                          ShowToast.getShowToast().showToast('申请已发送，请耐心等待');
//                            }, (error) {
//                              print(error);
//                              ShowToast.getShowToast().showToast('网络异常，请稍后再试');
//                            });
//                      },
//                      disabledColor: Colors.grey,
//                      color: Colors.blue,
//                      child: new Text(
//                        '申请授权',
//                        style: TextStyle(
//                            fontSize: 12.0,
//                            color: Color.fromARGB(255, 255, 255, 255)),
//                      ),
//                      shape: new RoundedRectangleBorder(
//                          borderRadius: new BorderRadius.circular(10.0)),
//                    ),
//                  )
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
        title: new Text('授权医生列表'),
        centerTitle: true,
      ),
      body: ListView(
        children: cardBuild(),
      ),
    );
  }
}
