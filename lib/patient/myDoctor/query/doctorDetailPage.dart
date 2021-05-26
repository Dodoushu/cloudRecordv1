import 'package:cloudrecord/untils/MessageMethod.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:dio/dio.dart';
import 'package:cloudrecord/untils/pickFileMethod.dart';
import 'package:cloudrecord/untils/picWidget.dart';
import 'package:cloudrecord/untils/http_service.dart';
import 'package:cloudrecord/untils/showToast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloudrecord/untils/showAlertDialogClass.dart';

class DoctorDetailPage extends StatefulWidget {
  DoctorDetailPage(Map map) {
    this.list = map;
  }

  Map list;

  @override
  State createState() => new _DoctorDetailPage(list);
}

class _DoctorDetailPage extends State<DoctorDetailPage> {
  _DoctorDetailPage(Map list) {
    this.map = list;
  }
  Map map;

  void initState() {
    super.initState();
    getId();
  }

  var _value;

  GlobalKey<FormState> textFromKey = new GlobalKey<FormState>();

  String uid;

  getId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('uid')) {
      uid = prefs.getString('uid');
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    Widget basicInfo = Container(
        padding: EdgeInsets.only(left: 20, right: 20, bottom: 30),
        child: new Form(
          key: textFromKey,
          child: Container(
            child: Column(
              children: <Widget>[
                InkWell(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        '医生姓名:',
                        style: TextStyle(fontSize: 19),
                      ),
                      Text(
                        map['name'],
                        style: TextStyle(fontSize: 19),
                      ),
                    ],
                  ),
                ),
                Divider(
                  thickness: 2,
                ),
                Column(
                  children: <Widget>[
                    InkWell(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            '医院:',
                            style: TextStyle(fontSize: 19),
                          ),
                          Text(
                            map['hospital'],
                            style: TextStyle(fontSize: 19),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      thickness: 2,
                    ),
                    InkWell(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            '科室:',
                            style: TextStyle(fontSize: 19),
                          ),
                          Text(
                            map['section'],
                            style: TextStyle(fontSize: 19),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      thickness: 2,
                    ),
                    InkWell(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            '职称:',
                            style: TextStyle(fontSize: 19),
                          ),
                          Text(
                            map['jobTitle'],
                            style: TextStyle(fontSize: 19),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      thickness: 2,
                    ),
                    new Column(
                      children: [
                        new Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '医生简介:',
                              style: TextStyle(fontSize: 19),
                            ),
                            Container()
                          ],
                        ),
                        Container(
                          child: Text(map['introduction'] == null
                              ? '无'
                              : map['introduction']),
                        )
                      ],
                    ),
                    Divider(
                      thickness: 2,
                    ),
                    new Column(
                      children: [
                        new Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '医生特长:',
                              style: TextStyle(fontSize: 19),
                            ),
                            Container()
                          ],
                        ),
                        Container(
                          child: Text(map['speciality'] == null
                              ? '无'
                              : map['speciality']),
                        )
                      ],
                    ),
                    Divider(
                      thickness: 2,
                    ),
                    new Column(
                      children: [
                        new Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '社会兼职:',
                              style: TextStyle(fontSize: 19),
                            ),
                            Container()
                          ],
                        ),
                        Container(
                          child: Text(map['socialWork'] == null
                              ? '无'
                              : map['socialWork']),
                        )
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ));

    Widget dividerline = Container(
      height: 60,
    );


    Widget dropdownbotton = new Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text('请选择授权期限：'),
        new DropdownButton(
          hint: Text('请选择授权期限'),
          value: _value,
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
              _value = value;
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
    );
    Widget ok1 = new Container(
//      padding: EdgeInsets.only(left: 10,right: 10,bottom: 0),
      height: 40.0,
      margin: EdgeInsets.only(top: 0.0, bottom: 30, left: 50, right: 50),
      child: new SizedBox.expand(
        child: new RaisedButton(
          elevation: 0,
          onPressed: () {
            try {
              Map formData = new Map();

              formData['userId'] = uid;
              formData['doctorId'] = map['id'];
              formData['type'] = _value;
              formData['date'] = new DateTime.now().toString().substring(0,10);

              print(formData);
              DioManager.getInstance().post('PatientAuthoriseDoctor', formData, (data) {
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
                    titleText: '操作成功', contentText: '既往病史上传成功', ButtonList: bottonList);
                print(data);
              }, (error) {
                print(error);
                ShowToast.getShowToast().showToast('网络异常，请稍后再试');
              }, ContentType: 'multipart/form-data');

            } catch (e) {
              ShowToast.getShowToast().showToast('稍后重试');
            }
          },
          color: Colors.blue,
          child: new Text(
            '授权查看个人病历信息',
            style: TextStyle(
                fontSize: 14.0, color: Color.fromARGB(255, 255, 255, 255)),
          ),
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(40.0)),
        ),
      ),
    );

    Widget ok2 = new Container(
//      padding: EdgeInsets.only(left: 10,right: 10,bottom: 0),
      height: 50.0,
      margin: EdgeInsets.only(top: 0.0, bottom: 30, left: 30, right: 30),
      child: new SizedBox.expand(
        child: new RaisedButton(
          elevation: 0,
          onPressed: () {
            try {} catch (e) {
              ShowToast.getShowToast().showToast('稍后重试');
            }
          },
          color: Colors.blue,
          child: new Text(
            '确定',
            style: TextStyle(
                fontSize: 14.0, color: Color.fromARGB(255, 255, 255, 255)),
          ),
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(40.0)),
        ),
      ),
    );

    return Scaffold(
        appBar: AppBar(
          title: Text(
            '医生信息',
//            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
//          backgroundColor: Colors.white,
        ),
        body: ListView(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 20),
//              padding: EdgeInsets.only(top: 30),
              child: Column(
                children: <Widget>[basicInfo, dividerline, dropdownbotton, ok1],
              ),
            )
          ],
        ));
  }
}
