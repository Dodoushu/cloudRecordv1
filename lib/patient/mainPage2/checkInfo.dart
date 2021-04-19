import 'package:flutter/material.dart';
import 'package:cloudrecord/untils/http_service.dart';
import 'package:intl/intl.dart';
import 'package:cloudrecord/untils/showAlertDialogClass.dart';
import 'package:city_pickers/city_pickers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloudrecord/untils/showToast.dart';

void main() => runApp(MaterialApp(
  home: checkInfoPage(),
  routes: <String, WidgetBuilder>{
    // 这里可以定义静态路由，不能传递参数
    '/dialog': (BuildContext context) => new NetLoadingDialog(),
  },
));

class checkInfoPage extends StatefulWidget {
  @override
  State createState() => new _checkInfoPage();
}

class _checkInfoPage extends State<checkInfoPage> {
  @override
  void initState() {
    super.initState();
    getId();
    getInfo();
  }

  getId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('uid')) {
      uid = prefs.getString('uid');
    }
  }

  getInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    name = prefs.getString('name');
    sex = prefs.getString('sex');
//    prefs.getString('phoneNum');
    birthday = DateTime.parse(prefs.getString('birthday'));
    ethnicity = prefs.getString('race');
    address = prefs.getString('nowAddr');
    mailAddress = prefs.getString('contactAddr');
    ID = prefs.getString('idCard');
    ICE1name = prefs.getString('mergeName');
    ICE1phone = prefs.getString('mergeNum');
    print(name);
    print(sex);
    print(birthday.toIso8601String());
    print(ethnicity);
    print(address);
    print(mailAddress);
    print(ID);
    print(ICE1name);
    print(ICE1phone);
    setState(() {

    });
  }

  GlobalKey<FormState> textFromKey = new GlobalKey<FormState>();

  String uid;

  DateTime birthday = new DateTime.now();

  String name;
  static final TextEditingController nameController =
  new TextEditingController();

  String sex;

  String ethnicity;
  static final TextEditingController ethnicityController =
  new TextEditingController();

  String ID;
  static final TextEditingController idController = new TextEditingController();

  String mailAddress;
  static final TextEditingController mailaddressController =
  new TextEditingController();

  String address;
  static final TextEditingController addressController =
  new TextEditingController();

  String FR1;
  static final TextEditingController fr1Controller =
  new TextEditingController();

  String ICE1name;
  static final TextEditingController ICE1nameController =
  new TextEditingController();
  String ICE1phone;
  static final TextEditingController ICE1phoneController =
  new TextEditingController();

  String lebalContent = '请选择性别';
  Map labelmap = {
    '0': '男',
    '1': '女',
  };

  Result nowAddressResult = new Result(
      provinceId: '110000',
      provinceName: "北京市",
      cityName: '北京城区',
      cityId: '110100',
      areaName: '东城区',
      areaId: '110101');

  Result mailAddressResult = new Result(
      provinceId: '110000',
      provinceName: "北京市",
      cityName: '北京城区',
      cityId: '110100',
      areaName: '东城区',
      areaId: '110101');
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
      value: '0',
    );
    items.add(dropdownMenuItem1);
    DropdownMenuItem dropdownMenuItem2 = new DropdownMenuItem(
      child: new Text('女'),
      value: '1',
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
    if (selectdate == null) return; //点击DatePicker的cancel

    setState(() {
      //点击DatePicker的OK
      startDate = selectdate;
    });
  }

  var data;


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    Widget basicInfo = Container(
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
                new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('姓名',style: TextStyle(fontSize: 19),),
                    Text(name,style: TextStyle(fontSize: 19),)
                  ],
                ),
                Divider(
                  thickness: 2,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      '性别:',
                      style: TextStyle(fontSize: 19),
                    ),
                    Text(sex == '0'?'男':'女',style: TextStyle(fontSize: 19),)
                  ],
                ),
                Divider(
                  thickness: 2,
                ),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('民族',style: TextStyle(fontSize: 19),),
                    Text(ethnicity,style: TextStyle(fontSize: 19),)
                  ],
                ),
                Divider(
                  thickness: 2,
                ),
                InkWell(
                  onTap: _selectstartDate,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        '出生日期:',
                        style: TextStyle(fontSize: 19),
                      ),
                      Text(
//                  date.year.toString()+'-'+date.month.toString()+'-'+date.day.toString(),
                        DateFormat.yMd().format(birthday),
                        style: TextStyle(fontSize: 19),
                      ),
                    ],
                  ),
                ),
                Divider(
                  thickness: 2,
                ),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('身份证号',style: TextStyle(fontSize: 19),),
                    Text(ID==null?'无':ID,style: TextStyle(fontSize: 19),)
                  ],
                ),
                Divider(
                  thickness: 2,
                ),
              ],
            )
          ],
        ),
      ),
    );

    Widget dividerline = Container(
      height: 30,
    );

    Widget contact = Container(
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      '通讯地址:',
                      style: TextStyle(fontSize: 19),
                    ),
                    Container(),
                  ],
                ),
                Text(mailAddress,style: TextStyle(fontSize: 19),maxLines: 3,),
                Divider(
                  thickness: 2,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      '现居住地:',
                      style: TextStyle(fontSize: 19),
                    ),
                    Container(),
                  ],
                ),
                Text(address,style: TextStyle(fontSize: 19),maxLines: 3,),
                Divider(
                  thickness: 2,
                ),
              ],
            ),

            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('紧急联系人姓名',style: TextStyle(fontSize: 19),),
                Text(ICE1name,style: TextStyle(fontSize: 19),)
              ],
            ),
            Divider(
              thickness: 2,
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('紧急联系人电话',style: TextStyle(fontSize: 19),),
                Text(ICE1phone,style: TextStyle(fontSize: 19),)
              ],
            ),
            Divider(
              thickness: 2,
            ),
          ],
        ),
      ),
    );


    return Scaffold(
        appBar: AppBar(
          title: Text(
            '个人信息',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
//            backgroundColor: Colors.white,
        ),
        body: new ListView(
          children: <Widget>[
            Form(
              key: textFromKey,
              child: new Column(
                children: [
                  basicInfo,
                  dividerline,
                  contact,
                ],
              ),
            )
          ],
        ));
  }
}
