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

class DoctorResult extends StatefulWidget {
  @override
  DoctorResult(List list) {
    this.list = list;
  }
  List list;
  @override
  _State createState() => new _State(list);
}

class _State extends State<DoctorResult> {
  @override
  _State(List list) {
    patientList = list;
  }

  @override
  void initState() {

    getId();
    setState(() {

    });
  }

  getId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('puid')) {
      uid = prefs.getString('puid');
    }
  }
  String uid;
  List patientList;

  List<Widget> cardBuild() {
    List<Widget> temp = new List();
    for (Map map in patientList) {


      Widget w = InkWell(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>new DoctorDetailPage(map)));
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
        title: new Text('查询结果'),
        centerTitle: true,
      ),
      body: ListView(children: cardBuild(),),
    );
  }
}
