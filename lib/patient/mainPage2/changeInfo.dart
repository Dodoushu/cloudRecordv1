import 'package:flutter/material.dart';
import 'package:cloudrecord/untils/http_service.dart';
import 'package:intl/intl.dart';
import 'package:cloudrecord/untils/showAlertDialogClass.dart';
import 'package:city_pickers/city_pickers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloudrecord/untils/showToast.dart';
import 'package:cloudrecord/patient/bottomNavigationBar.dart';

void main() => runApp(MaterialApp(
      home: changeInfo(),
      routes: <String, WidgetBuilder>{
        // 这里可以定义静态路由，不能传递参数
        '/dialog': (BuildContext context) => new NetLoadingDialog(),
      },
    ));

class changeInfo extends StatefulWidget {
  @override
  State createState() => new _changeInfo();
}

class _changeInfo extends State<changeInfo> {
  @override
  void initState() {
    super.initState();
    VeriInfo();
    setState(() {

    });
  }

  void VeriInfo()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String info = prefs.getString('detailInfo');

    if (prefs.containsKey('puid')) {
      uid = prefs.getString('puid');
    }
    if(info == '0'){

    }else{
      getId();
    }
  }

  getId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    name = prefs.getString('name');
    nameController = new TextEditingController(text: name);

    sex = int.parse(prefs.getString('sex'));
    startDate = DateTime.parse(prefs.getString('birthday'));

    ethnicity = prefs.getString('race');
    ethnicityController = new TextEditingController(text: ethnicity);

    mailAddress = prefs.getString('contactAddr');

    if(mailAddress!=null){
      mailaddressController =
      new TextEditingController(text: mailAddress.split('.')[3]);
      mailAddressResult = new Result(
          provinceName: mailAddress.split('.')[0],
          cityName: mailAddress.split('.')[1],
          areaName: mailAddress.split('.')[2]);
      mailAddress = mailAddress.split('.').length>=3?mailAddress.split('.')[3]:null;


    }else{
      mailaddressController = new TextEditingController();
      mailAddressResult = new Result(
//      provinceId: '110000',
        provinceName: "北京市",
        cityName: '北京城区',
//      cityId: '110100',
        areaName: '东城区',
//      areaId: '110101'
      );;
    }

    address = prefs.getString('nowAddr');

    if(address != null){
      addressController = new TextEditingController(text: address.split('.')[3].length>=3?address.split('.')[3]:null);
      nowAddressResult = new Result(
          provinceName: address.split('.')[0],
          cityName: address.split('.')[1],
          areaName: address.split('.')[2]);
      address = address.split('.')[3].length>=3?address.split('.')[3]:null;


    }else{
      addressController = new TextEditingController();
      nowAddressResult = new Result(
//      provinceId: '110000',
        provinceName: "北京市",
        cityName: '北京城区',
//      cityId: '110100',
        areaName: '东城区',
//      areaId: '110101'
      );;
    }

    ID = prefs.containsKey('idCard') ? prefs.getString('idCard') : null;
    if (ID != null) {
      idController = new TextEditingController(text: ID);
    }

    ICE1name = prefs.getString('mergeName');
    ICE1nameController = new TextEditingController(text: ICE1name);

    ICE1phone = prefs.getString("mergeNum");
    ICE1phoneController = new TextEditingController(text: ICE1phone);

    setState(() {});
  }

  bool canEdit = false;

  GlobalKey<FormState> textFromKey = new GlobalKey<FormState>();

  String uid;

  String name;
  TextEditingController nameController = new TextEditingController();

  int sex;

  String ethnicity;
  TextEditingController ethnicityController = new TextEditingController();

  String ID;
  TextEditingController idController = new TextEditingController();

  String mailAddress;
  TextEditingController mailaddressController = new TextEditingController();

  String address;
  TextEditingController addressController = new TextEditingController();

  String ICE1name;
  TextEditingController ICE1nameController = new TextEditingController();

  String ICE1phone;
  TextEditingController ICE1phoneController = new TextEditingController();

  String lebalContent = '请选择性别';
  Map labelmap = {
    0: '男',
    1: '女',
  };

  Result nowAddressResult
  = new Result(
//      provinceId: '110000',
      provinceName: "北京市",
      cityName: '北京城区',
//      cityId: '110100',
      areaName: '东城区',
//      areaId: '110101'
  );

  Result mailAddressResult
  = new Result(
//      provinceId: '110000',
      provinceName: "北京市",
      cityName: '北京城区',
//      cityId: '110100',
      areaName: '东城区',
//      areaId: '110101'
  );
//  Result addressResult = new Result('110000', '110100', '110101', '北京市', '北京城区', '东城区');

  String emptyValid(String value) {
    if (value.isEmpty) {
      return "请输入该项内容";
    }
    return null;
  }

  List<DropdownMenuItem> getListData() {
    List<DropdownMenuItem> items = new List();
    DropdownMenuItem dropdownMenuItem1 = new DropdownMenuItem(
      child: new Text('男'),
      value: 0,
    );
    items.add(dropdownMenuItem1);
    DropdownMenuItem dropdownMenuItem2 = new DropdownMenuItem(
      child: new Text('女'),
      value: 1,
    );
    items.add(dropdownMenuItem2);
    return items;
  }

  DateTime startDate = DateTime.now();
  Future<void> _selectstartDate() async //异步
  {
    final DateTime selectdate = await showDatePicker(
      //等待异步处理的结果
      //等待返回
      context: context,
      initialDate: startDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    DateTime old = startDate;
    if (selectdate == null) return; //点击DatePicker的cancel

    if(old == selectdate){
      Widget okButton = FlatButton(
        child: Text("好的"),
        onPressed: () {
          Navigator.pop(context);
        },
      );
      List<FlatButton> bottonList = new List();
      bottonList.add(okButton);
      showAlertDialog(context, titleText: '', contentText: '您未选择日期', ButtonList: bottonList);
    }
    setState(() {
      //点击DatePicker的OK
      startDate = selectdate;
    });
  }

  var data;

  void submit() async {
    var loginForm = textFromKey.currentState;
//    验证Form表单
    if (true
//    loginForm.validate() && sex != null
    ) {
      Map map = Map();
      Map patient = Map();

      patient['name'] = name;
      patient['sex'] = sex;
      patient['birthday'] = startDate.toIso8601String();
      patient['race'] = ethnicity;
      patient['nowAddr'] = nowAddressResult.provinceName +
          '.' +
          nowAddressResult.cityName +
          '.' +
          nowAddressResult.areaName +
          '.' +
          (address == null ? ' ' : address);
      patient['contactAddr'] = mailAddress==null?null:mailAddressResult.provinceName +
          '.' +
          mailAddressResult.cityName +
          '.' +
          mailAddressResult.areaName +
          '.' +
          mailAddress;
      patient['idCard'] = ID;
      patient['mergeName'] = ICE1name;
      patient['mergeNum'] = ICE1phone;
      map['userId'] = uid;

//      测试
//      patient['name'] = '0';
//      patient['sex'] = '0';
//      patient['birthday'] = '0';
//      patient['race'] = '0';
//      patient['nowAddr'] = '0';
//      patient['contactAddr'] = '0';
//      patient['idCard'] = '0';
//      patient['mergeName'] = '0';
//      patient['mergeNum'] = '0';
//      map['userId'] = '4';

      map['patient'] = patient;
      print(map);
      DioManager.getInstance().post('Patient', map, (data) {
        successcallBack(data);
      }, (error) {
        print(error);
        ShowToast.getShowToast().showToast('网络异常，请稍后再试');
      });
    } else {
      if (sex == null)
        ShowToast.getShowToast().showToast('请填写所需信息并选择性别和生日');
      else
        ShowToast.getShowToast().showToast('请填写所需信息并选择生日');
    }
  }

  successcallBack(Map data1) async {
    //返回参数: {"userId":null,"status_code":1,"doctorRegister":null,"patient":
    // {"id":6,"name":"0","sex":0,"birthday":"0","race":"0","nowAddr":"0","contactAddr":"0","idCard":"0","mergeName":"0","mergeNum":"0","userId":4}}
    if (data1['status_code'] == 1) {
      Map<String, dynamic> data = data1['patient'];
      if(data!=null){
        print('注册成功');
        print('用户姓名:');
        String sex = data['sex'].toString();
        print('用户性别:');
        print('用户年龄:');
        SharedPreferences prefs = await SharedPreferences.getInstance();

        prefs.setString('name', data['name']);

        prefs.setString('name', data["name"]);
        prefs.setString('sex', sex);
        prefs.setString('phoneNum', data["phoneNum"]);
        prefs.setString('birthday', data["birthday"]);
        prefs.setString('race', data["race"]);
        prefs.setString('nowAddr', data["nowAddr"]);
        prefs.setString('contactAddr', data["contactAddr"]);
        prefs.setString('idCard', data["idCard"]);
        prefs.setString('mergeName', data["mergeName"]);
        prefs.setString('mergeNum', data["mergeNum"]);
        prefs.setString('detailInfo', '1');
      }
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => BottomNavigationWidget()),
          (route) => false);
    } else {
      ShowToast.getShowToast().showToast('信息填写失败');
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    Widget dividerline = Container(
      height: 30,
    );

    return Scaffold(
        appBar: AppBar(
          title: Text(
            '用户个人信息',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          actions: canEdit==false?<Widget>[
            Container(
              child: Container(
                margin: EdgeInsets.only(top: 10, bottom: 10, right: 5, left: 5),
                child: RaisedButton(
                  onPressed: () {
                    canEdit = !canEdit;
                    setState(() {});
                  },
                  child: Text('修改'),
                ),
              ),
            )
          ]:null,
        ),
        body: new ListView(
          children: <Widget>[
            new Container(
              padding: EdgeInsets.only(top: 0.0, bottom: 20.0),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              width: double.infinity,
              height: 90,
              child: Center(
                  child: new Text(
                '基础信息填写',
                style: TextStyle(color: Colors.white, fontSize: 30.0),
              )),
            ),
            Form(
//              autovalidate: true,
              key: textFromKey,
              child: new Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 20, right: 20, bottom: 30),
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                '基础信息',
                                style: TextStyle(fontSize: 25),
                              )
                            ],
                          ),
                          Divider(
                            thickness: 2,
                          ),
                          Column(
                            children: <Widget>[
                              TextFormField(
                                enabled: canEdit,
                                controller: nameController,
                                decoration: new InputDecoration(
                                  labelText: '请输入您的姓名',
                                  labelStyle: new TextStyle(
                                      fontSize: 15.0,
                                      color: Color.fromARGB(255, 93, 93, 93)),
                                  border: InputBorder.none,
                                ),
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
                              Divider(
                                thickness: 2,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    '性别:',
                                    style: TextStyle(fontSize: 19),
                                  ),
                                  new DropdownButton(
                                    value: sex,
                                    items: getListData(),
                                    hint: new Text(
                                        lebalContent), //当没有默认值的时候可以设置的提示
                                    disabledHint: Text(sex!=null?labelmap[sex]:lebalContent),
                                    onChanged: canEdit != true
                                        ? null
                                        : (value) {
                                            //下拉菜单item点击之后的回调
                                            sex = value;
                                            print(sex);
                                            print(sex);
                                            setState(() {
                                              lebalContent = labelmap[value];
                                            });
                                          },
                                    elevation: 24, //设置阴影的高度
                                    style: new TextStyle(
                                        //设置文本框里面文字的样式
                                        color: Colors.black,
                                        fontSize: 15),
//              isDense: false,//减少按钮的高度。默认情况下，此按钮的高度与其菜单项的高度相同。如果isDense为true，则按钮的高度减少约一半。 这个当按钮嵌入添加的容器中时，非常有用
                                    iconSize: 50.0, //设置三角标icon的大小
                                  ),
                                ],
                              ),
                              Divider(
                                thickness: 2,
                              ),
                              TextFormField(
                                enabled: canEdit,
                                controller: ethnicityController,
                                decoration: new InputDecoration(
                                  labelText: '请输入您的民族',
                                  labelStyle: new TextStyle(
                                      fontSize: 15.0,
                                      color: Color.fromARGB(255, 93, 93, 93)),
                                  border: InputBorder.none,
                                ),
                                onChanged: (value) {
                                  ethnicity = value;
                                },
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return '请输入您的民族';
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                              Divider(
                                thickness: 2,
                              ),
                              InkWell(
                                onTap:
                                    canEdit == true ? _selectstartDate : null,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      '出生日期:',
                                      style: TextStyle(fontSize: 19),
                                    ),
                                    Text(
//                  date.year.toString()+'-'+date.month.toString()+'-'+date.day.toString(),
                                      DateFormat.yMd().format(startDate),
                                      style: TextStyle(fontSize: 19),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                thickness: 2,
                              ),
                              TextFormField(
                                enabled: canEdit,
                                controller: idController,
                                decoration: new InputDecoration(
                                  labelText: '请输入您的身份证号(选填)',
                                  labelStyle: new TextStyle(
                                      fontSize: 15.0,
                                      color: Color.fromARGB(255, 93, 93, 93)),
                                  border: InputBorder.none,
                                ),
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
                                  return null;
                                },
                                onChanged: (value) {
                                  ID = value;
                                },
                              ),
                              Divider(
                                thickness: 2,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 30,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 20, right: 20, bottom: 30),
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                '联络方式',
                                style: TextStyle(fontSize: 25),
                              )
                            ],
                          ),
                          Divider(
                            thickness: 2,
                          ),
                          Column(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    '通讯地址:',
                                    style: TextStyle(fontSize: 19),
                                  ),
                                  Container(),
                                ],
                              ),
                              InkWell(
                                  onTap: canEdit == true
                                      ? () async {
                                          Result result2 =
                                              await CityPickers.showCityPicker(
                                                  context: context);
                                          if (result2 != null) {
                                            mailAddressResult = result2;
                                            print(mailAddressResult.toString());
                                            setState(() {});
                                          }
                                        }
                                      : null,
                                  child: Container(
                                    margin: EdgeInsets.all(10),
                                    child: new Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(mailAddressResult.provinceName,
                                            style: TextStyle(fontSize: 18)),
                                        Text(mailAddressResult.cityName,
                                            style: TextStyle(fontSize: 18)),
                                        Text(mailAddressResult.areaName,
                                            style: TextStyle(fontSize: 18))
                                      ],
                                    ),
                                  )),
                              TextFormField(
                                enabled: canEdit,
                                controller: mailaddressController,
                                decoration: new InputDecoration(
                                  labelText: '请输入详细地址',
                                  labelStyle: new TextStyle(
                                      fontSize: 15.0,
                                      color: Color.fromARGB(255, 93, 93, 93)),
                                  border: InputBorder.none,
                                ),
                                maxLines: 3,
                                onChanged: (value) {
                                  mailAddress = value;
                                },
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return '请输入您的详细地址';
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                              Divider(
                                thickness: 2,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    '现居住地:',
                                    style: TextStyle(fontSize: 19),
                                  ),
                                  Container(),
                                ],
                              ),
                              InkWell(
                                  onTap: canEdit == true
                                      ? () async {
                                          Result result3 =
                                              await CityPickers.showCityPicker(
                                                  context: context);
                                          if (result3 != null) {
                                            nowAddressResult = result3;
                                            print(nowAddressResult.toString());
                                            setState(() {});
                                          }
                                        }
                                      : null,
                                  child: Container(
                                    margin: EdgeInsets.all(10),
                                    child: new Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(nowAddressResult.provinceName,
                                            style: TextStyle(fontSize: 18)),
                                        Text(nowAddressResult.cityName,
                                            style: TextStyle(fontSize: 18)),
                                        Text(nowAddressResult.areaName,
                                            style: TextStyle(fontSize: 18))
                                      ],
                                    ),
                                  )),
                              TextFormField(
                                enabled: canEdit,
                                controller: addressController,
                                decoration: new InputDecoration(
                                  labelText: '请输入详细地址',
                                  labelStyle: new TextStyle(
                                      fontSize: 15.0,
                                      color: Color.fromARGB(255, 93, 93, 93)),
                                  border: InputBorder.none,
                                ),
                                maxLines: 3,
                                onChanged: (value) {
                                  address = value;
                                },
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return '请输入您的详细地址';
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                              Divider(
                                thickness: 2,
                              ),
                            ],
                          ),
                          Container(
                              margin: EdgeInsets.only(top: 30),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    '紧急联系人',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ],
                              )),
                          Divider(
                            thickness: 2,
                          ),
                          TextFormField(
                            enabled: canEdit,
                            controller: ICE1nameController,
                            decoration: new InputDecoration(
                              labelText: '请输入您的紧急联系人姓名',
                              labelStyle: new TextStyle(
                                  fontSize: 15.0,
                                  color: Color.fromARGB(255, 93, 93, 93)),
                              border: InputBorder.none,
                            ),
                            onChanged: (value) {
                              ICE1name = value;
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return '请输入您的紧急联系人姓名';
                              } else {
                                return null;
                              }
                            },
                          ),
                          Divider(
                            thickness: 2,
                          ),
                          TextFormField(
                            enabled: canEdit,
                            controller: ICE1phoneController,
                            decoration: new InputDecoration(
                              labelText: '请输入您的紧急联系人电话',
                              labelStyle: new TextStyle(
                                  fontSize: 15.0,
                                  color: Color.fromARGB(255, 93, 93, 93)),
                              border: InputBorder.none,
                            ),
                            onChanged: (value) {
                              ICE1phone = value;
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return '请输入您的紧急联系人电话';
                              } else {
                                return null;
                              }
                            },
                          ),
                          Divider(
                            thickness: 2,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    child: canEdit==true?new Container(
                      height: 50.0,
                      margin: EdgeInsets.only(
                          top: 0.0, bottom: 30, left: 30, right: 30),
                      child: new SizedBox.expand(
                        child: new RaisedButton(
                          elevation: 0,
                          onPressed: submit,
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
                    ):null,
                  )
                ],
              ),
            )
          ],
        ));
  }
}
