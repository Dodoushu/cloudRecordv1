import 'package:cloudrecord/patient/myDoctor/query/doctorDetailPage.dart';
import 'package:cloudrecord/untils/http_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloudrecord/untils/showToast.dart';
import 'dart:developer';
import 'recordInquery.dart';
import 'package:cloudrecord/untils/showAlertDialogClass.dart';
void main() {
  runApp(new MaterialApp(
    title: 'patientResult',
    theme: new ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: new Authorized(),
  ));
}

class liuyan extends Dialog {

  liuyan(String duid, String puid){
    this.puid = puid;
    this.duid = duid;
  }

  String puid;
  String duid;
  String message = '';
  GlobalKey<FormState> textFromKey = new GlobalKey<FormState>();


  DateTime date = DateTime.now();


  @override
  Widget build(BuildContext context) {
    var loginForm = textFromKey.currentState;
    String dateString = date.toIso8601String();
    void summit() {
      print(date.toIso8601String());
      if (loginForm.validate()) {
        Map<String, dynamic> map = Map();

        map['userId'] = int.parse(duid);
        map['patientId'] = int.parse(puid);
        map['leaveMessage'] = message;
        map['date'] = dateString.substring(0, 10);
        print(map.toString());
        DioManager.getInstance().post('/LeaveMessage', map, (data) {
          Widget okButton = FlatButton(
            child: Text("好的"),
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
          );

          List<FlatButton> bottonList = new List();
          bottonList.add(okButton);
          showAlertDialog(context,
              titleText: '操作成功', contentText: '留言上传成功', ButtonList: bottonList);
          print(data);
        }, (error) {
          print(error);
          ShowToast.getShowToast().showToast('网络异常，请稍后再试');
        });
      } else {
        ShowToast.getShowToast().showToast('请将信息填写完整');
      }
    }

    double width_ = MediaQuery.of(context).size.width;
    // TODO: implement build
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Material(
            type: MaterialType.transparency, //设置透明的效果
          ),
        ),
        Container(
            width: width_ * 0.7,
            height: width_ * 0.7 * 1.9,
            child: Card(
              //比较常用的一个控件，设置具体尺寸
                child: Form(
                    key: textFromKey,
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            color: Colors.white),
                        child: Container(
                          margin: EdgeInsets.only(
                              top: 10, bottom: 0, left: 10, right: 10),
                          child: new Column(
                            children: [
                              new Row(
                                children: [
                                  new Text(
                                    '当前时间:',
                                    style: new TextStyle(
                                      fontSize: 20,
                                    ),
                                  )
                                ],
                              ),
                              new Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    dateString.substring(0, 4),
                                    style: new TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                  Text(
                                    '年',
                                    style: new TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                  Text(
                                    dateString.substring(5, 7),
                                    style: new TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                  Text(
                                    '月',
                                    style: new TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                  Text(
                                    dateString.substring(8, 10),
                                    style: new TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                  Text(
                                    '日',
                                    style: new TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                  Text(
                                    dateString.substring(11, 13),
                                    style: new TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                  Text(
                                    '时',
                                    style: new TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                  Text(
                                    dateString.substring(14, 16),
                                    style: new TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                  Text(
                                    '分',
                                    style: new TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                height: 15,
                              ),
                              new Row(
                                children: [
                                  new Text(
                                    '留言内容:',
                                    style: new TextStyle(
                                      fontSize: 20,
                                    ),
                                  )
                                ],
                              ),
                              Divider(
                                thickness: 2,
                              ),
                              TextFormField(
                                keyboardType: TextInputType.numberWithOptions(
                                    decimal: false, signed: false),
                                decoration: new InputDecoration(
                                  labelText: '请输入留言内容',
                                  labelStyle: new TextStyle(
                                      fontSize: 15.0,
                                      color: Color.fromARGB(255, 93, 93, 93)),
                                  border: InputBorder.none,
                                ),
//                                inputFormatters: <TextInputFormatter>[
//                                  WhitelistingTextInputFormatter
//                                      .digitsOnly, //只输入数字
//                                ],
                                maxLines: 9,
                                onChanged: (value) {
                                  message = value;
                                },
                                validator: (value) {

                                  if (value.isEmpty) {
                                    return '请留言内容';
                                  }
                                },
                              ),
                              Divider(
                                thickness: 2,
                              ),
                              Container(
                                height: 20,
                              ),
                              new Container(
//      padding: EdgeInsets.only(left: 10,right: 10,bottom: 0),
                                height: 50.0,
                                margin: EdgeInsets.only(
                                    top: 0.0, bottom: 30, left: 30, right: 30),
                                child: new SizedBox.expand(
                                  child: new RaisedButton(
                                    elevation: 0,
                                    onPressed: summit,
                                    color: Colors.blue,
                                    child: new Text(
                                      '确定',
                                      style: TextStyle(
                                          fontSize: 14.0,
                                          color: Color.fromARGB(
                                              255, 255, 255, 255)),
                                    ),
                                    shape: new RoundedRectangleBorder(
                                        borderRadius:
                                        new BorderRadius.circular(40.0)),
                                  ),
                                ),
                              )
                            ],
                          ),
                        )))))
      ],
    );
  }
}

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
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      new Container(
//      padding: EdgeInsets.only(left: 10,right: 10,bottom: 0),
                      height: 30.0,
                      width: 60,
                      margin: EdgeInsets.only(top: 10.0, bottom: 10, left: 30, right: 30),
                      child: new SizedBox.expand(
                        child: new RaisedButton(
                          elevation: 0,
                          onPressed: () async {
                            showDialog(context: context, builder: (BuildContext context){
                              return new liuyan(uid, map["userId"].toString());
                            });
                          },
                          color: Colors.blue,
                          child: new Text(
                            '留言',
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
                      height: 30.0,
                      width: 120,
                      margin: EdgeInsets.only(top: 10.0, bottom: 10, left: 30, right: 30),
                      child: new SizedBox.expand(
                        child: new RaisedButton(
                          elevation: 0,
                          onPressed: () async {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => new RecordInquery(map["userId"].toString())));
                          },
                          color: Colors.blue,
                          child: new Text(
                            '查看病历信息',
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
