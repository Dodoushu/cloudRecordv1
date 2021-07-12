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
    valuelist.fillRange(0, 65535, 7);
    setState(() {});
  }

  getInfo() {
    Map map = new Map();
    map['userId'] = uid;
    print(map);
    DioManager.getInstance().post('/DoctorState', map, (data) {
      print(data['doctorRegisters']);
      patientList = new List();
      if (data['doctorRegisters'] != null) {
        patientList = data['doctorRegisters'];
      }

      setState(() {});
    }, (error) {
      print(error);
      ShowToast.getShowToast().showToast('网络异常，请稍后再试');
    });
  }

  getId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('puid')) {
      uid = prefs.getString('puid');
    }
    setState(() {});
  }

  List valuelist = new List(65536);
  String uid;

  List<Widget> cardBuild() {
    List<Widget> temp = new List();
    for (int i = 0; i < patientList.length; i++) {
      Map map = patientList[i];
      Widget w = InkWell(
        onTap: () {},
        child: new Card(
            margin: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
            child: Container(
              margin: EdgeInsets.only(left: 10, right: 10),
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
                      Container(
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
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text('请选择授权期限：'),
                      new DropdownButton(
                        hint: Text('请选择授权期限'),
                        value: valuelist[i],
                        items: [
                          DropdownMenuItem(
                            child: new Text('3天'),
                            value: 1,
                          ),
                          new DropdownMenuItem(
                            child: new Text('1周'),
                            value: 2,
                          ),
                          DropdownMenuItem(
                            child: new Text('2周'),
                            value: 3,
                          ),
                          DropdownMenuItem(
                            child: new Text('1月'),
                            value: 4,
                          ),
                          DropdownMenuItem(
                            child: new Text('3月'),
                            value: 5,
                          ),
                          DropdownMenuItem(
                            child: new Text('半年'),
                            value: 6,
                          ),
                          DropdownMenuItem(
                            child: new Text('永久'),
                            value: 7,
                          )
                        ],
                        onChanged: (value) {
                          //下拉菜单item点击之后的回调
                          print(value);

                          setState(() {
                            valuelist[i] = value;
                          });
                        },
                        elevation: 24, //设置阴影的高度
                        style: new TextStyle(
                            //设置文本框里面文字的样式
                            color: Colors.black,
                            fontSize: 15),
//              isDense: false,//减少按钮的高度。默认情况下，此按钮的高度与其菜单项的高度相同。如果isDense为true，则按钮的高度减少约一半。 这个当按钮嵌入添加的容器中时，非常有用
                        iconSize: 50.0, //设置三角标icon的大小
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
                                formdate['date'] = new DateTime.now()
                                    .toString()
                                    .substring(0, 10);
                                formdate['type'] = valuelist[i];
                                formdate['doctorId'] = map['id'];
                                print(formdate);
                                DioManager.getInstance()
                                    .post('/Agree', formdate, (data) {
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
                                formdate['date'] = new DateTime.now()
                                    .toString()
                                    .substring(0, 10);
                                formdate['type'] = valuelist[i];
                                formdate['doctorId'] = map['id'];
                                print(formdate);
                                DioManager.getInstance()
                                    .post('/Agree', formdate, (data) {
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
