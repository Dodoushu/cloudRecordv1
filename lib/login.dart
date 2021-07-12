import 'package:cloudrecord/untils/http_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloudrecord/untils/showAlertDialogClass.dart';
import 'package:flutter/gestures.dart';
import 'select.dart';
import 'untils/showToast.dart';
import 'patient/register2.dart';
import 'doctor/mainPage.dart' as doctorMain;
import 'patient/bottomNavigationBar.dart' as patientMain;

void main() => runApp(new MaterialApp(home: new Login()));

/// 用户协议中“低调”文本的样式。
final TextStyle _lowProfileStyle = TextStyle(
  fontSize: 15.0,
  color: Color(0xFF4A4A4A),
);

/// 用户协议中“高调”文本的样式。
final TextStyle _highProfileStyle = TextStyle(
  fontSize: 15.0,
  color: Color(0xFF00CED2),
);

class Login extends StatefulWidget {
  @override
  LLogin createState() => new LLogin();
}

class LLogin extends State<Login> {
  GlobalKey<FormState> loginKey = new GlobalKey<FormState>();

  //上传内容
  String userName;
  String password;

  //记住的密码
  String prePhoneNumber;

  //页面变量
  bool isShowPassWord = false;
  bool ishavephoneNumber = false;
  bool ifremeberpwd = false;
  bool remberPwd = false;
  List<bool> select = [true, false];

  TextEditingController _controller = new TextEditingController();
  TextEditingController _pwdcontroller = new TextEditingController();

  void showPassWord() {
    setState(() {
      isShowPassWord = !isShowPassWord;
    });
  }

  void patientNavigate2(Map data)async{
    //患者
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('puid', data["userId"].toString());
    print(prefs.getString('puid'));
    print('登录成功');

    prefs.setString('name', null);
    prefs.setString('sex', null);
    prefs.setString('phoneNum', null);
    prefs.setString('birthday', null);
    prefs.setString('race', null);
    prefs.setString('nowAddr', null);
    prefs.setString('contactAddr', null);
    prefs.setString('idCard', null);
    prefs.setString('mergeName', null);
    prefs.setString('mergeNum', null);
    print('登录成功');
    print('用户姓名:');
    print('用户性别:');
    print('用户年龄:');
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => patientMain.BottomNavigationWidget()),
            (route) => false);
  }


  void patientNavigate(Map data)async{
    //患者
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('puid', data["userId"].toString());
    print(prefs.getString('puid'));
    Map<String, dynamic> data1 = data['patient'];
    print('登录成功');
    String sex = data1['sex'].toString();

    DateTime now = DateTime.now();
    String birthday2 = data1['birthday'].substring(0,10);
    DateTime birth = DateTime.parse(birthday2);
    var diff = now.difference(birth);
    int age = (diff.inDays/365).toInt();
    prefs.setString('age', age.toString());
    prefs.setString('name', data1["name"]);
    prefs.setString('sex', sex);
    prefs.setString('phoneNum', data1["phoneNum"]);
    prefs.setString('birthday', data1["birthday"]);
    prefs.setString('race', data1["race"]);
    prefs.setString('nowAddr', data1["nowAddr"]);
    prefs.setString('contactAddr', data1["contactAddr"]);
    prefs.setString('idCard', data1["idCard"]);
    prefs.setString('mergeName', data1["mergeName"]);
    prefs.setString('mergeNum', data1["mergeNum"]);
    print('登录成功');
    print('用户姓名:'+data1['name']);
    print('用户性别:'+sex);
    print('用户年龄:'+age.toString());
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => patientMain.BottomNavigationWidget()),
            (route) => false);
  }

  void successCallback(Map data) async{
    if(data['status_code'] == 11){
      Widget okButton = FlatButton(
        child: Text("好的"),
        onPressed: () {
          Navigator.pop(context);
        },
      );
      List<FlatButton> bottonList = new List();
      bottonList.add(okButton);
      showAlertDialog(context, titleText: '登陆失败', contentText: '账号或密码错误，请检查账号密码', ButtonList: bottonList);
    }else{
      if(data['status_code'] == 12){
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('detailInfo', "0");
        print('该用户尚未填写身份信息');
        patientNavigate2(data);
//        ShowToast.getShowToast().showToast('您尚未填写身份信息，即将跳转至填写页面');
//        Future.delayed(Duration(seconds: 3), (){
//          Navigator.of(context).pop();
//          print('延时3s执行');
//          Navigator.pushAndRemoveUntil(
//              context,
//              MaterialPageRoute(builder: (context) => register2()), (route) => false);
//        });
      }else if(data['status_code'] == 10){
        if(select[0]){
          patientNavigate(data);
        }else{
          //医生
          SharedPreferences prefs = await SharedPreferences.getInstance();
//          prefs.setString('uid', data["doctorRegister"]["userId"]);
          prefs.setString('name', data["doctorRegister"]["name"]);
          prefs.setString('section', data["doctorRegister"]["section"]);
          prefs.setString('jobTitle', data["doctorRegister"]["jobTitle"]);
          prefs.setString('hospital', data["doctorRegister"]["hospital"]);
          prefs.setString('approve', data["doctorRegister"]["approve"].toString());
          prefs.setString('duid', data["userId"].toString());
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => doctorMain.MainPage()),
                  (route) => false);

        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text(
          '登录',
        ),
        centerTitle: true,
      ),
      body: new ListView(
        children: <Widget>[
          new Container(
            padding: EdgeInsets.only(top: 0.0, bottom: 0.0),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            width: double.infinity,
            height: 90,
            child: Center(
                child: new Text(
              '欢迎登录携诊平台',
              style: TextStyle(color: Colors.white, fontSize: 30.0),
            )),
          ),
          new Container(
            padding: const EdgeInsets.all(16.0),
            child: new Form(
              key: loginKey,
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
                      controller: _controller,
                      decoration: new InputDecoration(
                        labelText: '请输入手机号',
                        labelStyle: new TextStyle(
                            fontSize: 15.0,
                            color: Color.fromARGB(255, 93, 93, 93)),
                        border: InputBorder.none,
                      ),
                      keyboardType: TextInputType.phone,
                      onChanged: (value) {
                        userName = value;
                      },
                      validator: (phone) {
                        if(phone.isEmpty){
                          return '请输入手机号';
                        }
                        return null;
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
                      controller: _pwdcontroller,
                      decoration: new InputDecoration(
                          labelText: '请输入密码',
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
                      validator: (phone) {
                        if(phone.isEmpty){
                          return '请输入密码';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            select[0] = true;
                            select[1] = false;
                          });
                        },
                        child: new Row(
                          children: [
                            Checkbox(
                              value: select[0],
                            ),
                            Text('患者登录')
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            select[0] = false;
                            select[1] = true;
                          });
                        },
                        child: new Row(
                          children: [
                            Checkbox(
                              value: select[1],
                            ),
                            Text('医生登录')
                          ],
                        ),
                      ),
//                      InkWell(
//                        onTap: () {},
//                        child: new Row(
//                          children: [
//                            Checkbox(
//                              value: remberPwd,
//                            ),
//                            Text('记住密码')
//                          ],
//                        ),
//                      )
                    ],
                  ),

                  Container(
                    padding: EdgeInsets.all(0),
                    height: 50.0,
                    margin: EdgeInsets.only(top: 10.0),
                    child: new SizedBox.expand(
                      child: new RaisedButton(
                        elevation: 20,
                        onPressed: () {

                          var loginForm = loginKey.currentState;
                          //验证Form表单
                          if (loginForm.validate()) {
                            Map map = Map();
                            Map sign = Map();
                            map['callType'] = select[0]? 0:1;
                            sign['phoneNum'] = userName;
                            sign['passWord'] = password;
                            map['sign'] = sign;
                            print(map);
                            DioManager.getInstance().post('Sign', map,
                                    (data){
                                      successCallback(data);
                                },
                                    (error){
                                  print(error);
                                  ShowToast.getShowToast().showToast('网络异常，请稍后再试');
                                });

                          } else {
                            ShowToast.getShowToast().showToast('请填写账号密码');
                          }

                        },
                        color: Colors.blue,
                        child: new Text(
                          '登录',
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
                    //margin: EdgeInsets.only(top: 30.0),
                    padding: EdgeInsets.only(left: 8.0, right: 8.0, top: 20.0),
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        new Container(
                          child: Text(
                            '忘记密码？',
                            style: TextStyle(
                                fontSize: 15.0,
                                color: Color.fromARGB(255, 53, 53, 53)),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => Select()));
                          },
                          child: Text(
                            '注册账号',
                            style: TextStyle(
                                fontSize: 15.0,
                                color: Color.fromARGB(255, 53, 53, 53)),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 15),
                    child: Center(
                        child: Text.rich(
                      // 文字跨度（`TextSpan`）组件，不可变的文本范围。
                      TextSpan(
                        // 文本（`text`）属性，跨度中包含的文本。
                        text: '登录即同意',
                        // 样式（`style`）属性，应用于文本和子组件的样式。
                        style: _lowProfileStyle,
                        children: [
                          TextSpan(
                            // 识别（`recognizer`）属性，一个手势识别器，它将接收触及此文本范围的事件。
                            // 手势（`gestures`）库的点击手势识别器（`TapGestureRecognizer`）类，识别点击手势。
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                print('点击了“服务条款”');
                              },
                            text: '“服务条款”',
                            style: _highProfileStyle,
                          ),
                          TextSpan(
                            text: '和',
                            style: _lowProfileStyle,
                          ),
                          TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                print('点击了“隐私政策”');
                              },
                            text: '“隐私政策”',
                            style: _highProfileStyle,
                          ),
                        ],
                      ),
                    )),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MyScaffoldBody extends StatelessWidget {
  String userName;
  String password;

  MyScaffoldBody(this.userName, this.password);

  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: EdgeInsets.all(0),
      height: 50.0,
      margin: EdgeInsets.only(top: 10.0),
      child: new SizedBox.expand(
        child: new RaisedButton(
          elevation: 20,
          onPressed: () {
            Scaffold.of(context).removeCurrentSnackBar();
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text('111'),
              ),
            );
          },
          color: Colors.blue,
          child: new Text(
            '登录',
            style: TextStyle(
                fontSize: 14.0, color: Color.fromARGB(255, 255, 255, 255)),
          ),
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(40.0)),
        ),
      ),
    );
  }
}
