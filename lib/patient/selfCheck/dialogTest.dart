import 'package:flutter/material.dart';
import 'package:cloudrecord/untils/showToast.dart';
import 'package:cloudrecord/untils/showAlertDialogClass.dart';
import 'package:cloudrecord/untils/http_service.dart';

class bloodPressureDialog extends Dialog {
  GlobalKey<FormState> textFromKey = new GlobalKey<FormState>();

  bloodPressureDialog(String uid) {
    this.uid = uid;
  }
  String uid;
  String high;
  String low;
  DateTime date = DateTime.now();
  String test = '111';

  @override
  Widget build(BuildContext context) {
    var loginForm = textFromKey.currentState;
    String dateString = date.toIso8601String();
    void summit() {
      print(date.toIso8601String());
      if (loginForm.validate()) {
        Map<String, dynamic> map = Map();

        map['userId'] = uid;
        Map<String, dynamic> dseaseSelfBaseInfo = new Map();
        dseaseSelfBaseInfo['highPressure'] = high;
        dseaseSelfBaseInfo['lowPressure'] = low;
        dseaseSelfBaseInfo['date'] = dateString.substring(0, 10);
        dseaseSelfBaseInfo['time'] = dateString.substring(11, 16);
        map['diseaseSelfBaseInfo'] = dseaseSelfBaseInfo;
        print(map.toString());
        DioManager.getInstance().post('DiseaseSelfCheck/SelfInfo', map, (data) {
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
              titleText: '操作成功', contentText: '血压上传成功', ButtonList: bottonList);
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
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Material(
        type: MaterialType.transparency, //设置透明的效果
        child: Center(
          // 让子控件显示到中间
          child: Container(
              //比较常用的一个控件，设置具体尺寸
              width: width_ * 0.7,
              height: width_ * 0.7 * 1.6,
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
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                  '高压:',
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
                              decoration: new InputDecoration(
                                labelText: '请输入高压/mmHg',
                                labelStyle: new TextStyle(
                                    fontSize: 15.0,
                                    color: Color.fromARGB(255, 93, 93, 93)),
                                border: InputBorder.none,
                              ),
                              maxLines: 1,
                              onChanged: (value) {
                                high = value;
                              },
                              validator: (value) {
                                if (value != null) {
                                  return null;
                                } else {
                                  return '请正确填写信息';
                                }
                              },
                            ),
                            Divider(
                              thickness: 2,
                            ),
                            Container(
                              height: 20,
                            ),
                            new Row(
                              children: [
                                new Text(
                                  '低压:',
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
                              decoration: new InputDecoration(
                                labelText: '请输入低压/mmHg',
                                labelStyle: new TextStyle(
                                    fontSize: 15.0,
                                    color: Color.fromARGB(255, 93, 93, 93)),
                                border: InputBorder.none,
                              ),
                              maxLines: 1,
                              onChanged: (value) {
                                low = value;
                              },
                              validator: (value) {
                                if (value != null) {
                                  return null;
                                } else {
                                  return '请正确填写信息';
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
                                        color:
                                            Color.fromARGB(255, 255, 255, 255)),
                                  ),
                                  shape: new RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(40.0)),
                                ),
                              ),
                            )
                          ],
                        ),
                      )))),
        ),
      ),
    );
  }
}

class pulse extends Dialog {
  GlobalKey<FormState> textFromKey = new GlobalKey<FormState>();

  pulse(String uid) {
    this.uid = uid;
  }
  String uid;
  String upload;
  DateTime date = DateTime.now();


  @override
  Widget build(BuildContext context) {
    var loginForm = textFromKey.currentState;
    String dateString = date.toIso8601String();
    void summit() {
      print(date.toIso8601String());
      if (loginForm.validate()) {
        Map<String, dynamic> map = Map();

        map['userId'] = uid;
        Map<String, dynamic> dseaseSelfBaseInfo = new Map();
        dseaseSelfBaseInfo['pulse'] = upload;
        dseaseSelfBaseInfo['date'] = dateString.substring(0, 10);
        dseaseSelfBaseInfo['time'] = dateString.substring(11, 16);
        map['diseaseSelfBaseInfo'] = dseaseSelfBaseInfo;
        print(map.toString());
        DioManager.getInstance().post('DiseaseSelfCheck/SelfInfo', map, (data) {
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
              titleText: '操作成功', contentText: '脉搏上传成功', ButtonList: bottonList);
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
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Material(
        type: MaterialType.transparency, //设置透明的效果
        child: Center(
          // 让子控件显示到中间
          child: Container(
              //比较常用的一个控件，设置具体尺寸
              width: width_ * 0.7,
              height: width_ * 0.7 * 1.6,
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
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                  '脉搏:',
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
                              decoration: new InputDecoration(
                                labelText: '请输入脉搏 次/分钟',
                                labelStyle: new TextStyle(
                                    fontSize: 15.0,
                                    color: Color.fromARGB(255, 93, 93, 93)),
                                border: InputBorder.none,
                              ),
                              maxLines: 1,
                              onChanged: (value) {
                                upload = value;
                              },
                              validator: (value) {
                                if (value != null) {
                                  return null;
                                } else {
                                  return '请正确填写信息';
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
                                        color:
                                            Color.fromARGB(255, 255, 255, 255)),
                                  ),
                                  shape: new RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(40.0)),
                                ),
                              ),
                            )
                          ],
                        ),
                      )))),
        ),
      ),
    );
  }
}

class tempretrue extends Dialog {
  GlobalKey<FormState> textFromKey = new GlobalKey<FormState>();

  tempretrue(String uid) {
    this.uid = uid;
  }
  String uid;
  String upload;
  DateTime date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    var loginForm = textFromKey.currentState;
    String dateString = date.toIso8601String();
    void summit() {
      print(date.toIso8601String());
      if (loginForm.validate()) {
        Map<String, dynamic> map = Map();

        map['userId'] = uid;
        Map<String, dynamic> dseaseSelfBaseInfo = new Map();
        dseaseSelfBaseInfo['temperature'] = upload;
        dseaseSelfBaseInfo['date'] = dateString.substring(0, 10);
        dseaseSelfBaseInfo['time'] = dateString.substring(11, 16);
        map['diseaseSelfBaseInfo'] = dseaseSelfBaseInfo;
        print(map.toString());
        DioManager.getInstance().post('DiseaseSelfCheck/SelfInfo', map, (data) {
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
              titleText: '操作成功', contentText: '体温上传成功', ButtonList: bottonList);
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
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Material(
        type: MaterialType.transparency, //设置透明的效果
        child: Center(
          // 让子控件显示到中间
          child: Container(
              //比较常用的一个控件，设置具体尺寸
              width: width_ * 0.7,
              height: width_ * 0.7 * 1.6,
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
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                  '体温:',
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
                              decoration: new InputDecoration(
                                labelText: '请输入体温 ℃',
                                labelStyle: new TextStyle(
                                    fontSize: 15.0,
                                    color: Color.fromARGB(255, 93, 93, 93)),
                                border: InputBorder.none,
                              ),
                              maxLines: 1,
                              onChanged: (value) {
                                upload = value;
                              },
                              validator: (value) {
                                if (value != null) {
                                  return null;
                                } else {
                                  return '请正确填写信息';
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
                                        color:
                                            Color.fromARGB(255, 255, 255, 255)),
                                  ),
                                  shape: new RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(40.0)),
                                ),
                              ),
                            )
                          ],
                        ),
                      )))),
        ),
      ),
    );
  }
}

class bloodSugar extends Dialog {
  GlobalKey<FormState> textFromKey = new GlobalKey<FormState>();

  bloodSugar(String uid) {
    this.uid = uid;
  }

  var _value;
  String uid;
  String upload;
  DateTime date = DateTime.now();
  int type;
  @override
  Widget build(BuildContext context) {
    var loginForm = textFromKey.currentState;
    String dateString = date.toIso8601String();
    void summit() {
      print(date.toIso8601String());
      if (loginForm.validate()) {
        Map<String, dynamic> map = Map();

        map['userId'] = uid;
        Map<String, dynamic> dseaseSelfBaseInfo = new Map();
        dseaseSelfBaseInfo['bloodSugar'] = upload;
        dseaseSelfBaseInfo['bloodType'] = type;
        dseaseSelfBaseInfo['date'] = dateString.substring(0, 10);
        dseaseSelfBaseInfo['time'] = dateString.substring(11, 16);
        map['diseaseSelfBaseInfo'] = dseaseSelfBaseInfo;
        print(map.toString());
        DioManager.getInstance().post('DiseaseSelfCheck/SelfInfo', map, (data) {
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
              titleText: '操作成功', contentText: '血压上传成功', ButtonList: bottonList);
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
    return StatefulBuilder(builder: (context, state) {
      return GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Material(
          type: MaterialType.transparency, //设置透明的效果
          child: Center(
            // 让子控件显示到中间
            child: Container(
                //比较常用的一个控件，设置具体尺寸
                width: width_ * 0.7,
                height: width_ * 0.7 * 1.6,
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
                              DropdownButton(
                                  value: _value,
                                  icon: Icon(Icons.arrow_right),
                                  iconSize: 40,
                                  iconEnabledColor:
                                      Colors.green.withOpacity(0.7),
                                  hint: Text('请选择血糖类型'),
                                  isExpanded: true,
                                  underline: Container(
                                      height: 1,
                                      color: Colors.green.withOpacity(0.7)),
                                  items: [
                                    DropdownMenuItem(
                                        child: Row(children: <Widget>[
                                          Text('空腹'),
                                        ]),
                                        value: 1),
                                    DropdownMenuItem(
                                        child: Row(children: <Widget>[
                                          Text('饭后两小时'),
                                        ]),
                                        value: 2),
                                    DropdownMenuItem(
                                        child: Row(children: <Widget>[
                                          Text(
                                            '即刻血糖',
                                          )
                                        ]),
                                        value: 3)
                                  ],
                                  onChanged: (value){
                                    print(value);
                                    type = value;
                                    state(() => _value = value);
                                  }
                              ),
                              Container(
                                height: 15,
                              ),
                              new Row(
                                children: [
                                  new Text(
                                    '血糖:',
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
                                decoration: new InputDecoration(
                                  labelText: '请输入血糖 mmol/L',
                                  labelStyle: new TextStyle(
                                      fontSize: 15.0,
                                      color: Color.fromARGB(255, 93, 93, 93)),
                                  border: InputBorder.none,
                                ),
                                maxLines: 1,
                                onChanged: (value) {
                                  upload = value;
                                },
                                validator: (value) {
                                  if (value != null) {
                                    return null;
                                  } else {
                                    return '请正确填写信息';
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
                        )))),
          ),
        ),
      );
    });
  }
}

class weight extends Dialog {
  GlobalKey<FormState> textFromKey = new GlobalKey<FormState>();

  weight(String uid) {
    this.uid = uid;
  }
  String uid;
  String upload;
  DateTime date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    var loginForm = textFromKey.currentState;
    String dateString = date.toIso8601String();
    void summit() {
      print(date.toIso8601String());
      if (loginForm.validate()) {
        Map<String, dynamic> map = Map();

        map['userId'] = uid;
        Map<String, dynamic> dseaseSelfBaseInfo = new Map();
        dseaseSelfBaseInfo['weight'] = upload;
        dseaseSelfBaseInfo['date'] = dateString.substring(0, 10);
        dseaseSelfBaseInfo['time'] = dateString.substring(11, 16);
        map['diseaseSelfBaseInfo'] = dseaseSelfBaseInfo;
        print(map.toString());
        DioManager.getInstance().post('DiseaseSelfCheck/SelfInfo', map, (data) {
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
              titleText: '操作成功', contentText: '体重上传成功', ButtonList: bottonList);
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
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Material(
        type: MaterialType.transparency, //设置透明的效果
        child: Center(
          // 让子控件显示到中间
          child: Container(
              //比较常用的一个控件，设置具体尺寸
              width: width_ * 0.7,
              height: width_ * 0.7 * 1.6,
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
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                  '体重:',
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
                              decoration: new InputDecoration(
                                labelText: '请输入体重 kg',
                                labelStyle: new TextStyle(
                                    fontSize: 15.0,
                                    color: Color.fromARGB(255, 93, 93, 93)),
                                border: InputBorder.none,
                              ),
                              maxLines: 1,
                              onChanged: (value) {
                                upload = value;
                              },
                              validator: (value) {
                                if (value != null) {
                                  return null;
                                } else {
                                  return '请正确填写信息';
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
                                        color:
                                            Color.fromARGB(255, 255, 255, 255)),
                                  ),
                                  shape: new RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(40.0)),
                                ),
                              ),
                            )
                          ],
                        ),
                      )))),
        ),
      ),
    );
  }
}

class height extends Dialog {
  GlobalKey<FormState> textFromKey = new GlobalKey<FormState>();

  height(String uid) {
    this.uid = uid;
  }
  String uid;
  String upload;
  DateTime date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    var loginForm = textFromKey.currentState;
    String dateString = date.toIso8601String();
    void summit() {
      print(date.toIso8601String());
      if (loginForm.validate()) {
        Map<String, dynamic> map = Map();

        map['userId'] = uid;
        Map<String, dynamic> dseaseSelfBaseInfo = new Map();
        dseaseSelfBaseInfo['height'] = upload;
        dseaseSelfBaseInfo['date'] = dateString.substring(0, 10);
        dseaseSelfBaseInfo['time'] = dateString.substring(11, 16);
        map['diseaseSelfBaseInfo'] = dseaseSelfBaseInfo;
        print(map.toString());
        DioManager.getInstance().post('DiseaseSelfCheck/SelfInfo', map, (data) {
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
              titleText: '操作成功', contentText: '身高上传成功', ButtonList: bottonList);
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
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Material(
        type: MaterialType.transparency, //设置透明的效果
        child: Center(
          // 让子控件显示到中间
          child: Container(
              //比较常用的一个控件，设置具体尺寸
              width: width_ * 0.7,
              height: width_ * 0.7 * 1.6,
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
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                  '身高:',
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
                              decoration: new InputDecoration(
                                labelText: '请输入身高 cm',
                                labelStyle: new TextStyle(
                                    fontSize: 15.0,
                                    color: Color.fromARGB(255, 93, 93, 93)),
                                border: InputBorder.none,
                              ),
                              maxLines: 1,
                              onChanged: (value) {
                                upload = value;
                              },
                              validator: (value) {
                                if (value != null) {
                                  return null;
                                } else {
                                  return '请正确填写信息';
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
                                        color:
                                            Color.fromARGB(255, 255, 255, 255)),
                                  ),
                                  shape: new RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(40.0)),
                                ),
                              ),
                            )
                          ],
                        ),
                      )))),
        ),
      ),
    );
  }
}

class other extends Dialog {
  GlobalKey<FormState> textFromKey = new GlobalKey<FormState>();

  other(String uid) {
    this.uid = uid;
  }
  String uid;
  String upload;
  DateTime date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    var loginForm = textFromKey.currentState;
    String dateString = date.toIso8601String();
    void summit() {
      print(date.toIso8601String());
      if (loginForm.validate()) {
        Map<String, dynamic> map = Map();

        map['userId'] = uid;
        Map<String, dynamic> dseaseSelfBaseInfo = new Map();
        dseaseSelfBaseInfo['description'] = upload;
        dseaseSelfBaseInfo['date'] = dateString.substring(0, 10);
        dseaseSelfBaseInfo['time'] = dateString.substring(11, 16);
        map['diseaseSelfBaseInfo'] = dseaseSelfBaseInfo;
        print(map.toString());
        DioManager.getInstance().post('DiseaseSelfCheck/SelfInfo', map, (data) {
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
              titleText: '操作成功', contentText: '上传成功', ButtonList: bottonList);
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
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Material(
        type: MaterialType.transparency, //设置透明的效果
        child: Center(
          // 让子控件显示到中间
          child: Container(
              //比较常用的一个控件，设置具体尺寸
              width: width_ * 0.7,
              height: width_ * 0.7 * 1.6,
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
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                  '内容:',
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
                              decoration: new InputDecoration(
                                labelText: '请输入您要输入的内容',
                                labelStyle: new TextStyle(
                                    fontSize: 15.0,
                                    color: Color.fromARGB(255, 93, 93, 93)),
                                border: InputBorder.none,
                              ),
                              maxLines: 4,
                              onChanged: (value) {
                                upload = value;
                              },
                              validator: (value) {
                                if (value != null) {
                                  return null;
                                } else {
                                  return '请正确填写信息';
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
                                        color:
                                            Color.fromARGB(255, 255, 255, 255)),
                                  ),
                                  shape: new RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(40.0)),
                                ),
                              ),
                            )
                          ],
                        ),
                      )))),
        ),
      ),
    );
  }
}
