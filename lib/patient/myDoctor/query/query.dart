import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloudrecord/untils/http_service.dart';
import 'package:cloudrecord/untils/showToast.dart';
import 'package:cloudrecord/untils/showAlertDialogClass.dart';
import 'doctorResult.dart';

void main() {
  runApp(new MaterialApp(
    title: 'PatientQuery',
    theme: new ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: new Query(),
  ));
}

class Query extends StatefulWidget {
  @override
  _State createState() => new _State();
}

class _State extends State<Query> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setInfo();
    Future.delayed(new Duration(milliseconds: 300)).then((value) {
      setState(() {
      });
    });
  }

  void setInfo()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    uid = prefs.get('uid');
    setState(() {

    });
  }

  String uid;
  String name;
  String section;
  String hospital;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('查找医生'),
        centerTitle: true,
      ),
        body: Container(
          margin: EdgeInsets.only(right: 20, left: 20, top: 20),
          child: ListView(
            children: <Widget>[
              Container(
                  child: Column(
                    children: <Widget>[

                      new Row(
                        children: [
                          Text(
                            '科室：',
                            style: TextStyle(fontSize: 18),
                            textAlign: TextAlign.left,
                          ),
                          Container()
                        ],
                      ),
                      TextFormField(
                        decoration: new InputDecoration(
                          labelText: '请输入科室',
                          labelStyle: new TextStyle(
                              fontSize: 15.0,
                              color: Color.fromARGB(255, 93, 93, 93)),
                          border: InputBorder.none,
                        ),
                        onChanged: (value) {
                          section = value;
                        },
                        validator: (value) {
                          if(value.isEmpty){
                            return "请输入科室";
                          }
                          return null;
                        },
                      ),

                      new Row(
                        children: [
                          Text(
                            '姓名：',
                            style: TextStyle(fontSize: 18),
                            textAlign: TextAlign.left,
                          ),
                          Container()
                        ],
                      ),
                      TextFormField(
                        decoration: new InputDecoration(
                          labelText: '请输入姓名',
                          labelStyle: new TextStyle(
                              fontSize: 15.0,
                              color: Color.fromARGB(255, 93, 93, 93)),
                          border: InputBorder.none,
                        ),
                        onChanged: (value) {
                          name = value;
                        },
                        validator: (value) {
                          if(value.isEmpty){
                            return "请输入姓名";
                          }
                          return null;
                        },
                      ),


                      new Row(
                        children: [
                          Text(
                            '医院：',
                            style: TextStyle(fontSize: 18),
                            textAlign: TextAlign.left,
                          ),
                          Container()
                        ],
                      ),
                      TextFormField(
                        decoration: new InputDecoration(
                          labelText: '请输入医院',
                          labelStyle: new TextStyle(
                              fontSize: 15.0,
                              color: Color.fromARGB(255, 93, 93, 93)),
                          border: InputBorder.none,
                        ),
                        onChanged: (value) {
                          hospital = value;
                        },
                      ),
                    ],
                  )),
              new Container(
//      padding: EdgeInsets.only(left: 10,right: 10,bottom: 0),
                height: 50.0,
                margin:
                EdgeInsets.only(top: 0.0, bottom: 30, left: 30, right: 30),
                child: new SizedBox.expand(
                  child: new RaisedButton(
                    elevation: 0,
                    onPressed: () async {

                      Map map = new Map();
                      map['name'] = name;
                      map['section'] = section;
                      map['phoneNum'] = hospital;

                      print(map);

                      DioManager.getInstance().post('/PatientSeekDoctor', map,
                              (data) {

                            print(data['doctorRegisters']);
                            List list = data['doctorRegisters'];
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> new DoctorResult(list)));
                          }, (error) {
                            print(error);
                            ShowToast.getShowToast().showToast('网络异常，请稍后再试');
                          });

                    },
                    color: Colors.blue,
                    child: new Text(
                      '确定',
                      style: TextStyle(
                          fontSize: 14.0,
                          color: Color.fromARGB(255, 255, 255, 255)),
                    ),
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(40.0)),
                  ),
                ),
              )
            ],
          ),
        ));

  }
}