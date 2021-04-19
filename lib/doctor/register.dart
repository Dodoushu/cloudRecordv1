import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:cloudrecord/untils/http_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloudrecord/untils/showAlertDialogClass.dart';
import 'package:cloudrecord/untils/showToast.dart';
import 'package:cloudrecord/untils/pickFileMethod.dart';
import 'package:dio/dio.dart';
import 'dart:io';
import 'mainPage.dart';
import 'package:cloudrecord/untils/picWidget.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: register());
  }
}

class register extends StatefulWidget {
  @override
  _Login createState() => new _Login();
}

class _Login extends State<register> {
  //获取Key用来获取Form表单组件
  GlobalKey<FormState> textFromKey = new GlobalKey<FormState>();

  String phoneNumber;
  static final TextEditingController phoneNumberController = new TextEditingController();
  String password;
  static final TextEditingController passwordController = new TextEditingController();
  String password2;
  static final TextEditingController password2Controller = new TextEditingController();
  String verificationCode;
  static final TextEditingController verificationCodeController = new TextEditingController();

  String name;
  static final TextEditingController nameController = new TextEditingController();
  String hospital;
  static final TextEditingController hospitalController = new TextEditingController();
  String section;
  static final TextEditingController sectionController = new TextEditingController();
  String jobTitle;
  static final TextEditingController jobTitleController = new TextEditingController();
  String introduction;
  static final TextEditingController introductionController = new TextEditingController();
  String speciality;
  static final TextEditingController specialityController = new TextEditingController();
  String socialWork;
  static final TextEditingController socialWorkController = new TextEditingController();

  bool isShowPassWord = false;


  MultipartFile photo;
  String displayPath;

  void _selectFile() async {
    getSingleImagePath().then((path) {
      MultipartFile.fromFile(path).then((value) {
        photo = value;
      });

      setState(() {
        displayPath = path.toString();
      });
    });
  }

  void _selectFilefromCamera() async {
    getImageFileFromCamera().then((path) {
      MultipartFile.fromFile(path).then((value) {
        photo = value;
      });
      setState(() {
        displayPath = path.toString();
      });
    });
  }

  void login() async {
    //读取当前的Form状态
    var loginForm = textFromKey.currentState;
    //验证Form表单
    if (loginForm.validate()) {
      Map<String, dynamic> map = Map();
      map['name'] = name;
      map['phoneNum'] = phoneNumber;
      map['passWord'] = password;
      map['hospital'] = hospital;
      map['section'] = section;
      map['jobTitle'] = jobTitle;
      map['introduction'] = introduction;
      map['speciality'] = speciality;
      map['socialWork'] = socialWork;
      map['verCode'] = verificationCode;


//      map['name'] = '0';
//      map['phoneNum'] = '0';
//      map['passWord'] = '0';
//      map['hospital'] = '0';
//      map['section'] = '0';
//      map['jobTitle'] = '0';
//      map['introduction'] = '0';
//      map['speciality'] = '0';
//      map['socialWork'] = '0';
//      map['verCode'] = '0';

      List fileList = List();
      fileList.add(photo);
      map['files'] = fileList;
      FormData formData = new FormData.fromMap(map);
      print(formData);
      DioManager.getInstance().post('DoctorRegister', formData,
              (data){
            successcallBack(data);
          },
              (error){
            print(error);
            ShowToast.getShowToast().showToast('网络异常，请稍后再试');
          }, ContentType: 'multipart/form-data');
    }else{
      ShowToast.getShowToast().showToast('请正确填写信息');
    }
  }

  void successcallBack(Map data) async{
    print(data);
//    返回参数: {"userId":4,"status_code":1,"doctorRegister":{"id":4,"name":"0","phoneNum":"0","passWord":"0","address":null,"hospital":"0","section":"0","jobTitle":"0","verCode":"0","introduction":"0","speciality":"0","socialWork":"0","approve":0,"flag":0},"patient":null}
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('uid', data["doctorRegister"]["userId"]);
    prefs.setString('name', data["doctorRegister"]["name"]);
    prefs.setString('section', data["doctorRegister"]["section"]);
    prefs.setString('jobTitle', data["doctorRegister"]["jobTitle"]);
    prefs.setString('hospital', data["doctorRegister"]["hospital"]);
    prefs.setString('uid', data["userId"].toString());
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => MainPage()),
            (route) => false);

  }

  void showPassWord() {
    setState(() {
      isShowPassWord = !isShowPassWord;
    });
  }

  // 计时器函数和变量----------------------------
  bool isButtonEnable = true; //按钮状态  是否可点击
  String buttonText = '发送验证码'; //初始文本
  int count = 60; //初始倒计时时间
  Timer timer; //倒计时的计时器
  TextEditingController mController = TextEditingController();

  void _buttonClickListen() {
    setState(() {
      if (isButtonEnable) {
        //当按钮可点击时
        isButtonEnable = false; //按钮状态标记
        _initTimer();

        return null; //返回null按钮禁止点击
      } else {
        //当按钮不可点击时
//        debugPrint('false');
        return null; //返回null按钮禁止点击
      }
    });
  }

  void _initTimer() {
    timer = new Timer.periodic(Duration(seconds: 1), (Timer timer) {
      count--;
      setState(() {
        if (count == 0) {
          timer.cancel(); //倒计时结束取消定时器
          isButtonEnable = true; //按钮可点击
          count = 60; //重置时间
          buttonText = '发送验证码'; //重置按钮文本
        } else {
          buttonText = '重新发送($count)'; //更新文本内容
        }
      });
    });
  }

  @override
  void dispose() {
    timer?.cancel(); //销毁计时器
    timer = null;
    mController?.dispose();
    super.dispose();
  }




  @override
  Widget build(BuildContext context) {

    double width_ = MediaQuery.of(context).size.width;

    return new Scaffold(
      appBar: AppBar(
        title: Text(
          '医生注册',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
//          backgroundColor: Colors.white,
      ),
      body: new ListView(
        children: <Widget>[
//          new Container(
//            padding: EdgeInsets.only(top: 0.0, bottom: 0.0),
//            decoration: BoxDecoration(
//              color: Colors.blue,
//            ),
//            width: double.infinity,
//            height: 90,
//            child: Center(
//                child: new Text(
//                  '医生注册',
//                  style: TextStyle(color: Colors.white, fontSize: 30.0),
//                )),
//          ),
          new Container(
            padding: const EdgeInsets.all(16.0),
            child: new Form(
              key: textFromKey,
              autovalidate: false,
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  new Container(
                    decoration: new BoxDecoration(
                        border: new Border(
                            bottom: BorderSide(
                                color: Color.fromARGB(255, 240, 240, 240),
                                width: 1.0))),
                    child: new TextFormField(
                      controller: phoneNumberController,
                      decoration: new InputDecoration(
                        labelText: '请输入您的手机号',
                        labelStyle: new TextStyle(
                            fontSize: 15.0,
                            color: Color.fromARGB(255, 93, 93, 93)),
                        border: InputBorder.none,
                      ),
                      keyboardType: TextInputType.phone,
                      onChanged: (value) {
                        phoneNumber = value;
                      },
                      validator: (value) {
                        RegExp exp = RegExp(
                            r'^((13[0-9])|(14[0-9])|(15[0-9])|(16[0-9])|(17[0-9])|(18[0-9])|(19[0-9]))\d{8}$');
                        bool matched = exp.hasMatch(value);
                        if (matched == false) {
                          return '请输入正确手机号';
                        } else {
                          return null;
                        }
                      },
                      onFieldSubmitted: (value) {},
                    ),
                  ),
                  new Container(
                    decoration: new BoxDecoration(
                        border: new Border(
                            bottom: BorderSide(
                                color: Color.fromARGB(255, 240, 240, 240),
                                width: 1.0))),
                    child: new TextFormField(
                      controller: passwordController,
                      decoration: new InputDecoration(
                          labelText: '输入密码',
                          labelStyle: new TextStyle(
                              fontSize: 15.0,
                              color: Color.fromARGB(255, 93, 93, 93)),
                          border: InputBorder.none,
                          suffixIcon: new IconButton(
                            icon: new Icon(
                              isShowPassWord
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Color.fromARGB(255, 126, 126, 126),
                            ),
                            onPressed: showPassWord,
                          )),
                      obscureText: !isShowPassWord,
                      onChanged: (value) {
                        password = value;
                      },
                    ),
                  ),
                  new Container(
                    decoration: new BoxDecoration(
                        border: new Border(
                            bottom: BorderSide(
                                color: Color.fromARGB(255, 240, 240, 240),
                                width: 1.0))),
                    child: new TextFormField(
                      controller: password2Controller,
                      decoration: new InputDecoration(
                        labelText: '确认密码',
                        labelStyle: new TextStyle(
                            fontSize: 15.0,
                            color: Color.fromARGB(255, 93, 93, 93)),
                        border: InputBorder.none,
                      ),
                      obscureText: !isShowPassWord,
                      validator: (value) {
                        if (password != null && value != password) {
                          return '请确认两次密码输入相同';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        password2 = value;
                      },
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    padding: EdgeInsets.only(left: 0, right: 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
//                        crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.ideographic,
                      children: <Widget>[
//                          Text(
//                            '验证码',
//                            style: TextStyle(
//                                fontSize: 13, color: Color(0xff333333)),
//                          ),
                        Expanded(
                          child: Padding(
                            padding:
                            EdgeInsets.only(left: 0, right: 0, top: 0),
                            child: TextFormField(
                                maxLines: 1,
                                onSaved: (value) {},
                                controller: mController,
                                textAlign: TextAlign.left,
                                inputFormatters: [
                                  WhitelistingTextInputFormatter.digitsOnly,
                                  LengthLimitingTextInputFormatter(6)
                                ],
                                decoration: InputDecoration(
//                                  hintText: ('填写验证码'),
//                                  contentPadding:
//                                      EdgeInsets.only(top: -5, bottom: 0),
//                                  hintStyle: TextStyle(
//                                    color: Color(0xff999999),
//                                    fontSize: 13,
//                                  ),
//                                  alignLabelWithHint: true,
//                                  border: OutlineInputBorder(
//                                      borderSide: BorderSide.none),

                                  labelText: '请输入验证码',
                                  labelStyle: new TextStyle(
                                      fontSize: 15.0,
                                      color: Color.fromARGB(255, 93, 93, 93)),
                                  border: InputBorder.none,
                                ),
                                onChanged: (value){
                                  verificationCode = value;
                                }
                            ),
                          ),
                        ),
                        Container(
                          width: 120,
                          child: FlatButton(
                            disabledColor: Colors.grey.withOpacity(0.1),
                            //按钮禁用时的颜色
                            disabledTextColor: Colors.white,
                            //按钮禁用时的文本颜色
                            textColor: isButtonEnable
                                ? Colors.white
                                : Colors.black.withOpacity(0.2),
                            //文本颜色
                            color: isButtonEnable
                                ? Color(0xff44c5fe)
                                : Colors.grey.withOpacity(0.1),
                            //按钮的颜色
                            splashColor: isButtonEnable
                                ? Colors.white.withOpacity(0.1)
                                : Colors.transparent,
                            shape: StadiumBorder(side: BorderSide.none),
                            onPressed: () {
                              setState(() {
                                _buttonClickListen();
                              });
                            },
//                        child: Text('重新发送 (${secondSy})'),
                            child: Text(
                              '$buttonText',
                              style: TextStyle(
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  new Container(
                    decoration: new BoxDecoration(
                        border: new Border(
                            bottom: BorderSide(
                                color: Color.fromARGB(255, 240, 240, 240),
                                width: 1.0))),
                    child: new TextFormField(
                      controller: nameController,
                      decoration: new InputDecoration(
                        labelText: '请输入您的姓名',
                        labelStyle: new TextStyle(
                            fontSize: 15.0,
                            color: Color.fromARGB(255, 93, 93, 93)),
                        border: InputBorder.none,
                      ),
                      keyboardType: TextInputType.phone,
                      onChanged: (value) {
                        name = value;
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return '请输入您的姓名';
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        '证件照:',
                        style: TextStyle(
                          fontSize: 20,
                          color: Color.fromARGB(255, 93, 93, 93),
                        ),
                      ),
                      new Row(
                        children: [new Container(
                            margin: EdgeInsets.only(left: 10),
                            child: RaisedButton(
                              elevation: 0,
                              onPressed: _selectFile,
                              color: Colors.blue,
                              child: new Text('选择照片',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                  )),
                              shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(40.0)),
                            )),
                          new Container(
                              margin: EdgeInsets.only(left: 5),
                              child: RaisedButton(
                                elevation: 0,
                                onPressed: () => {_selectFilefromCamera()},
                                color: Colors.blue,
                                child: new Text('相机拍照',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                    )),
                                shape: new RoundedRectangleBorder(
                                    borderRadius: new BorderRadius.circular(40.0)),
                              )),],
                      ),
                    ],
                  ),

                  new Center(child: onePicWidget(displayPath, width_*0.6, width_*0.6/1.6)),

                  new Container(
                    decoration: new BoxDecoration(
                        border: new Border(
                            bottom: BorderSide(
                                color: Color.fromARGB(255, 240, 240, 240),
                                width: 1.0))),
                    child: new TextFormField(
                      controller: hospitalController,
                      decoration: new InputDecoration(
                        labelText: '请输入您的医院',
                        labelStyle: new TextStyle(
                            fontSize: 15.0,
                            color: Color.fromARGB(255, 93, 93, 93)),
                        border: InputBorder.none,
                      ),
                      keyboardType: TextInputType.phone,
                      onChanged: (value) {
                        hospital = value;
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return '请输入您的医院';
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),

                  new Container(
                    decoration: new BoxDecoration(
                        border: new Border(
                            bottom: BorderSide(
                                color: Color.fromARGB(255, 240, 240, 240),
                                width: 1.0))),
                    child: new TextFormField(
                      controller: sectionController,
                      decoration: new InputDecoration(
                        labelText: '请输入您的科室',
                        labelStyle: new TextStyle(
                            fontSize: 15.0,
                            color: Color.fromARGB(255, 93, 93, 93)),
                        border: InputBorder.none,
                      ),
                      keyboardType: TextInputType.phone,
                      onChanged: (value) {
                        section = value;
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return '请输入您的科室';
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),

                  new Container(
                    decoration: new BoxDecoration(
                        border: new Border(
                            bottom: BorderSide(
                                color: Color.fromARGB(255, 240, 240, 240),
                                width: 1.0))),
                    child: new TextFormField(
                      maxLines: 4,
                      controller: jobTitleController,
                      decoration: new InputDecoration(
                        labelText: '请输入您的职称',
                        labelStyle: new TextStyle(
                            fontSize: 15.0,
                            color: Color.fromARGB(255, 93, 93, 93)),
                        border: InputBorder.none,
                      ),
                      keyboardType: TextInputType.phone,
                      onChanged: (value) {
                        jobTitle = value;
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return '请输入您的职称';
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),

                  new Container(
                    decoration: new BoxDecoration(
                        border: new Border(
                            bottom: BorderSide(
                                color: Color.fromARGB(255, 240, 240, 240),
                                width: 1.0))),
                    child: new TextFormField(
                      maxLines: 4,
                      controller: introductionController,
                      decoration: new InputDecoration(
                        labelText: '请输入您的医师简介',
                        labelStyle: new TextStyle(
                            fontSize: 15.0,
                            color: Color.fromARGB(255, 93, 93, 93)),
                        border: InputBorder.none,
                      ),
                      keyboardType: TextInputType.phone,
                      onChanged: (value) {
                        introduction = value;
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return '请输入您的医师简介';
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),

                  new Container(
                    decoration: new BoxDecoration(
                        border: new Border(
                            bottom: BorderSide(
                                color: Color.fromARGB(255, 240, 240, 240),
                                width: 1.0))),
                    child: new TextFormField(
                      maxLines: 4,
                      controller: specialityController,
                      decoration: new InputDecoration(
                        labelText: '请输入您的专业特长',
                        labelStyle: new TextStyle(
                            fontSize: 15.0,
                            color: Color.fromARGB(255, 93, 93, 93)),
                        border: InputBorder.none,
                      ),
                      keyboardType: TextInputType.phone,
                      onChanged: (value) {
                        speciality = value;
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return '请输入您的专业特长';
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),

                  new Container(
                    decoration: new BoxDecoration(
                        border: new Border(
                            bottom: BorderSide(
                                color: Color.fromARGB(255, 240, 240, 240),
                                width: 1.0))),
                    child: new TextFormField(
                      maxLines: 4,
                      controller: socialWorkController,
                      decoration: new InputDecoration(
                        labelText: '请输入您的社会兼职',
                        labelStyle: new TextStyle(
                            fontSize: 15.0,
                            color: Color.fromARGB(255, 93, 93, 93)),
                        border: InputBorder.none,
                      ),
                      keyboardType: TextInputType.phone,
                      onChanged: (value) {
                        socialWork = value;
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return '请输入您的社会兼职';
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),



                  new Container(
                    padding: EdgeInsets.all(0),
                    height: 50.0,
                    margin: EdgeInsets.only(top: 40.0),
                    child: new SizedBox.expand(
                      child: new RaisedButton(
                        elevation: 20,
                        onPressed: login,
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
                  ),
//                    new Container(
//                      //margin: EdgeInsets.only(top: 30.0),
//                      padding:
//                          EdgeInsets.only(left: 8.0, right: 8.0, top: 30.0),
//                      child: new Row(
//                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                        children: <Widget>[
//                          new Container(
//                            child: Text(
//                              '收不到验证码？',
//                              style: TextStyle(
//                                  fontSize: 15.0,
//                                  color: Color.fromARGB(255, 53, 53, 53)),
//                            ),
//                          ),
////                          Text(
////                            '注册账号',
////                            style: TextStyle(
////                                fontSize: 15.0,
////                                color: Color.fromARGB(255, 53, 53, 53)
////                            ),
////                          ),
//                        ],
//                      ),
//                    ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
