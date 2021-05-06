import 'package:flutter/material.dart';
import 'package:cloudrecord/untils/pickFileMethod.dart';
import 'package:dio/dio.dart';
import 'package:cloudrecord/untils/picWidget.dart';
import 'package:cloudrecord/untils/http_service.dart';
import 'package:cloudrecord/untils/showAlertDialogClass.dart';
import 'package:cloudrecord/untils/showToast.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(new MaterialApp(
    title: '',
    theme: new ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: new DoctorCheck(),
  ));
}

class DoctorCheck extends StatefulWidget {
  @override
  _State createState() => new _State();
}

class _State extends State<DoctorCheck> {
  GlobalKey<FormState> textFromKey = new GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setInfo();
    Future.delayed(new Duration(milliseconds: 300)).then((value) {
      setState(() {});
    });
  }

  void setInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    uid = prefs.get('uid');
    setState(() {});
  }

  String uid;

  String IDnumber;

  String ID1;

  String ID2;

  String yishizige;

  String yishizhiye;

  String yishizhicheng;

  Future<String> _selectFile() {
    getSingleImagePath().then((value) {
      print(value);
      return value;
    });
  }

  Future _selectFilefromCamera() async {
    await getImageFileFromCamera().then((value) {
//      MultipartFile.fromFile(path).then((value) {
//        ID1path = value;
//      });
      return value.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    double width_ = MediaQuery.of(context).size.width;
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('医生认证'),
        ),
        body: Form(
          key: textFromKey,
          child: Container(
            margin: EdgeInsets.only(right: 20, left: 20, top: 20),
            child: ListView(
              children: <Widget>[
                Container(
                    child: Column(
                  children: <Widget>[
                    new Row(
                      children: [
                        Text(
                          '身份证号：',
                          style: TextStyle(fontSize: 18),
                          textAlign: TextAlign.left,
                        ),
                        Container()
                      ],
                    ),
                    TextFormField(
                      decoration: new InputDecoration(
                        labelText: '请输入您的身份证号',
                        labelStyle: new TextStyle(
                            fontSize: 15.0,
                            color: Color.fromARGB(255, 93, 93, 93)),
                        border: InputBorder.none,
                      ),
                      onChanged: (value) {
                        IDnumber = value;
                      },
                      validator: (value) {
                        RegExp cardReg = RegExp(
                            r'^\d{6}(18|19|20)?\d{2}(0[1-9]|1[012])(0[1-9]|[12]\d|3[01])\d{3}(\d|X)$');
                        if (!value.isEmpty) {
                          if (!cardReg.hasMatch(value)) {
                            return '请输入有效身份证号';
                          } else {
                            return null;
                          }
                        }
                        return "请输入身份证号";
                      },
                    ),
                  ],
                )),
                new Column(
                  children: [
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('请上传身份证正面:', style: TextStyle(fontSize: 18)),
                        new Container(
                            margin: EdgeInsets.only(left: 10),
                            child: RaisedButton(
                              elevation: 0,
                              onPressed: () async {
                                await getSingleImagePath().then((value) {
                                  print(value);
                                  setState(() {
                                    ID1 = value;
                                  });
                                });
                              },
                              color: Colors.blue,
                              child: new Text('选择照片',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                  )),
                              shape: new RoundedRectangleBorder(
                                  borderRadius:
                                      new BorderRadius.circular(40.0)),
                            )),
                      ],
                    ),
                    new Center(
                        child: onePicWidget(
                            ID1, width_ * 0.6, width_ * 0.6 / 1.6)),
                    Container(
                      height: 20,
                    )
                  ],
                ),
                new Column(
                  children: [
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('请上传身份证反面:', style: TextStyle(fontSize: 18)),
                        new Container(
                            margin: EdgeInsets.only(left: 10),
                            child: RaisedButton(
                              elevation: 0,
                              onPressed: () async {
                                await getSingleImagePath().then((value) {
                                  print(value);
                                  setState(() {
                                    ID2 = value;
                                  });
                                });
                              },
                              color: Colors.blue,
                              child: new Text('选择照片',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                  )),
                              shape: new RoundedRectangleBorder(
                                  borderRadius:
                                      new BorderRadius.circular(40.0)),
                            )),
                      ],
                    ),
                    new Center(
                        child: onePicWidget(
                            ID2, width_ * 0.6, width_ * 0.6 / 1.6)),
                    Container(
                      height: 20,
                    )
                  ],
                ),
                new Column(
                  children: [
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('请上传医师资格证:', style: TextStyle(fontSize: 18)),
                        new Container(
                            margin: EdgeInsets.only(left: 10),
                            child: RaisedButton(
                              elevation: 0,
                              onPressed: () async {
                                await getSingleImagePath().then((value) {
                                  print(value);
                                  setState(() {
                                    yishizige = value;
                                  });
                                });
                              },
                              color: Colors.blue,
                              child: new Text('选择照片',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                  )),
                              shape: new RoundedRectangleBorder(
                                  borderRadius:
                                      new BorderRadius.circular(40.0)),
                            )),
                      ],
                    ),
                    new Center(
                        child: onePicWidget(
                            yishizige, width_ * 0.6, width_ * 0.6 / 1.6)),
                    Container(
                      height: 20,
                    )
                  ],
                ),
                new Column(
                  children: [
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('请上传医师执业证:', style: TextStyle(fontSize: 18)),
                        new Container(
                            margin: EdgeInsets.only(left: 10),
                            child: RaisedButton(
                              elevation: 0,
                              onPressed: () async {
                                await getSingleImagePath().then((value) {
                                  print(value);
                                  setState(() {
                                    yishizhiye = value;
                                  });
                                });
                              },
                              color: Colors.blue,
                              child: new Text('选择照片',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                  )),
                              shape: new RoundedRectangleBorder(
                                  borderRadius:
                                      new BorderRadius.circular(40.0)),
                            )),
                      ],
                    ),
                    new Center(
                        child: onePicWidget(
                            yishizhiye, width_ * 0.6, width_ * 0.6 / 1.6)),
                    Container(
                      height: 20,
                    )
                  ],
                ),
                new Column(
                  children: [
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('请上传医师职称证书:', style: TextStyle(fontSize: 18)),
                        new Container(
                            margin: EdgeInsets.only(left: 10),
                            child: RaisedButton(
                              elevation: 0,
                              onPressed: () async {
                                await getSingleImagePath().then((value) {
                                  print(value);
                                  setState(() {
                                    yishizhicheng = value;
                                  });
                                });
                              },
                              color: Colors.blue,
                              child: new Text('选择照片',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                  )),
                              shape: new RoundedRectangleBorder(
                                  borderRadius:
                                      new BorderRadius.circular(40.0)),
                            )),
                      ],
                    ),
                    new Center(
                        child: onePicWidget(
                            yishizhicheng, width_ * 0.6, width_ * 0.6 / 1.6)),
                    Container(
                      height: 20,
                    )
                  ],
                ),
                new Container(
//      padding: EdgeInsets.only(left: 10,right: 10,bottom: 0),
                  height: 50.0,
                  margin: EdgeInsets.only(
                      top: 0.0, bottom: 30, left: 30, right: 30),
                  child: new SizedBox.expand(
                    child: new RaisedButton(
                      elevation: 0,
                      onPressed: () async {
                        var loginForm = textFromKey.currentState;
                        if (loginForm.validate() && ID1!=null && ID2 != null && yishizhicheng!=null &&yishizige != null &&yishizhiye!= null) {
                          Map<String, dynamic> map = Map();
                          List fileList = new List();
                          List fileNum = new List();
                          fileNum.add('1');
                          fileNum.add('2');
                          fileNum.add('3');
                          fileNum.add('4');
                          fileNum.add('5');

                          await MultipartFile.fromFile(ID1).then((value) {
                            fileList.add(value);
                          });
                          await MultipartFile.fromFile(ID2).then((value) {
                            fileList.add(value);
                          });
                          await MultipartFile.fromFile(yishizige).then((value) {
                            fileList.add(value);
                          });
                          await MultipartFile.fromFile(yishizhiye)
                              .then((value) {
                            fileList.add(value);
                          });
                          await MultipartFile.fromFile(yishizhicheng)
                              .then((value) {
                            fileList.add(value);
                          });

                          map['files'] = fileList;
                          map['types'] = fileNum;
                          map['userId'] = uid;
                          map['idCard'] = IDnumber;

                          FormData formData = new FormData.fromMap(map);
                          print(map.toString());

                          DioManager.getInstance().post('DoctorCheck', formData,
                              (data) {
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
                                titleText: '操作成功',
                                contentText: '认证信息上传成功',
                                ButtonList: bottonList);
                            print(data);
                          }, (error) {
                            print(error);
                            ShowToast.getShowToast().showToast('网络异常，请稍后再试');
                          }, ContentType: 'multipart/form-data');
                        } else {
                          ShowToast.getShowToast().showToast('请将信息填写完整');
                        }
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
          ),
        ));
  }
}
