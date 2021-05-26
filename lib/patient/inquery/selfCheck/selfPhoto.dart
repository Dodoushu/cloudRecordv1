import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:cloudrecord/untils/http_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'detail.dart';
import 'selfCheckDetail.dart';
import 'package:cloudrecord/untils/showAlertDialogClass.dart';

void main() {
  runApp(new MaterialApp(
    title: '门诊病历查询',
    theme: new ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: new selfPhoto(),
  ));
}

class selfPhoto extends StatefulWidget {
  @override
  _State createState() => new _State();
}

class _State extends State<selfPhoto> {
  @override
  void initState() {
    super.initState();

    getId();
//    getInfo();
  }

  DateTime sDate = new DateTime.now();
  DateTime eDate = new DateTime.now();
  Future<void> _selectsDate() async //异步
  {
    final DateTime selectdate = await showDatePicker(
      //等待异步处理的结果
      //等待返回
      context: context,
      initialDate: sDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (selectdate == null) return; //点击DatePicker的cancel

    setState(() {
      //点击DatePicker的OK
      sDate = selectdate;
    });
  }
  Future<void> _selecteDate() async //异步
  {
    final DateTime selectdate = await showDatePicker(
      //等待异步处理的结果
      //等待返回
      context: context,
      initialDate: eDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (selectdate == null) return; //点击DatePicker的cancel

    setState(() {
      //点击DatePicker的OK
      eDate = selectdate;
    });
  }

  getDateInfo() async{
    if(sDate.isAfter(eDate)){
      Widget okButton = FlatButton(
        child: Text("好的"),
        onPressed: () {
          Navigator.pop(context);
        },
      );

      List<FlatButton> bottonList = new List();
      bottonList.add(okButton);
      showAlertDialog(context,
          titleText: '日期错误', contentText: '开始日期晚于结束日期', ButtonList: bottonList);
      return;
    }
    Map<String, dynamic> formData = new Map();
    formData['userId'] = uid;
    formData['checkType'] = 5;
    formData['sDate'] = sDate.toIso8601String().substring(0,10);
    formData['eDate'] = eDate.add(Duration(days: 1)).toIso8601String().substring(0,10);
    print(formData);
    DioManager.getInstance().post(
      'SelectDiseaseSelfInfo',
      formData,
          (data) {
        print(data);
        list.clear();
        for (Map map in data['diseaseSelfInfos']) {
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

  getInfo() async{
    Map<String, dynamic> formData = new Map();
    formData['userId'] = uid;
    formData['checkType'] = timeInt;
    print(formData);
    DioManager.getInstance().post(
      'SelectDiseaseSelfInfo',
      formData,
          (data) {
        print(data);
        list.clear();
        for (Map map in data['diseaseSelfInfos']) {
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
//      getInfo();
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
//      height: width_ * 0.15,
      child: new Column(
        children: [
          new Row(
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
//                getInfo();
                    print(timeInt);
                    setState(() {
                      timeValue = value;
                    });
                  }),
              RaisedButton(
                onPressed: () {
                  getInfo();
                  print(timeInt);
                  setState(() {});
                },
                color: Colors.blue,
                child: Text(
                  '查询',
                  style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                ),
              )
            ],
          ),
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                '自定义:',
                style: TextStyle(fontSize: 18),
              ),
              InkWell(
                child: Text(sDate.toIso8601String().substring(0,10)),
                onTap: _selectsDate,
              ),

              InkWell(
                child: Text(eDate.toIso8601String().substring(0,10)),
                onTap: _selecteDate,
              ),
              RaisedButton(
                onPressed: () {
                  getDateInfo();
                  print(timeInt);
                  setState(() {});
                },
                color: Colors.blue,
                child: Text(
                  '查询',
                  style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                ),
              )
            ],
          ),
        ],
      ),
    );

    List<Widget> cardBuild() {
      List<Widget> temp = new List();
      temp.add(timeScope);
      for (Map map in list) {
        Widget w = InkWell(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>new detailPage(map)));
          },
          child: new Card(
              margin: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
              child: Container(
                margin: EdgeInsets.only(left: 10, right: 10),
                child: new Column(
                  children: [
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '日期：',
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
                          '时间：',
                          style: TextStyle(fontSize: 18),
                        ),
                        Text(
                          map['time'],
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '拍照部位：',
                          style: TextStyle(fontSize: 18),
                        ),
                        Flexible(
                          child: Text(
                            map['position'],
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

    return new Scaffold(
        appBar: new AppBar(
          title: new Text('病症自拍查询'),
          centerTitle: true,
        ),
        body: new ListView(
          children: cardBuild(),
        ));
  }
}
