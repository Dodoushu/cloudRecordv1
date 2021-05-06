import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:dio/dio.dart';
import 'package:cloudrecord/untils/pickFileMethod.dart';
import 'package:cloudrecord/untils/picWidget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloudrecord/untils/showToast.dart';
import 'package:cloudrecord/untils/showAlertDialogClass.dart';
import 'package:cloudrecord/untils/http_service.dart';

void main() => runApp(MaterialApp(
      home: physicalExanmination(),
    ));

class physicalExanmination extends StatefulWidget {
  @override
  State createState() => new _physicalExanmination();
}

class _physicalExanmination extends State<physicalExanmination> {
  void initState() {
    super.initState();
    getId();
  }

  getId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('uid')) {
      uid = prefs.getString('uid');
    }
  }

  GlobalKey<FormState> textFromKey = new GlobalKey<FormState>();

  String uid;
  DateTime date = DateTime.now();
  TimeOfDay time = TimeOfDay.now();
  String position;
  String recordcontent;

  String introduction;
  String filesname;
  String filespath;
  List selectedFiles = [];
  List displayPath = [];
  var flag2 = 0;

  Future<void> _selectFile() async {
    Map filesPaths;
    getMultiFilesPath().then((value) {
      filesPaths = value;
      var selectedFilePaths = filesPaths.values;
//      MultipartFile tempfile;
      for (String path in selectedFilePaths) {
        displayPath.add(path);
//        MultipartFile.fromFile(path).then((value) {
//          if (value != Null) {
//            flag2 = 1;
//          }
//          tempfile = value;
//          print('*****************' + path);
//          selectedFiles.add(tempfile);
//          print(selectedFiles.length);
//        });
      }
      setState(() {
        filesname = displayPath.toString();
      });
    });
  }

  Future<void> _selectFilefromCamera() async {
    getImageFileFromCamera().then((value) {
      displayPath.add(value);
//      var selectedFilePaths = value;
//      MultipartFile tempfile;
//
//      MultipartFile.fromFile(selectedFilePaths).then((value) {
//        if (value != Null) {
//          flag2 = 1;
//        }
//        tempfile = value;
//        print('1111111111111111111111' + selectedFilePaths);
//        selectedFiles.add(tempfile);
//        print(selectedFiles.length);
//      });

      setState(() {
        filesname = displayPath.toString();
      });
    });
  }

  List<DropdownMenuItem> getListData() {
    List<DropdownMenuItem> items = new List();
    DropdownMenuItem dropdownMenuItem0 = new DropdownMenuItem(
      child: new Text('无'),
      value: '无',
    );
    items.add(dropdownMenuItem0);
    DropdownMenuItem dropdownMenuItem1 = new DropdownMenuItem(
      child: new Text('皮肤科'),
      value: '皮肤科',
    );
    items.add(dropdownMenuItem1);
    DropdownMenuItem dropdownMenuItem2 = new DropdownMenuItem(
      child: new Text('内科'),
      value: '内科',
    );
    items.add(dropdownMenuItem2);
    DropdownMenuItem dropdownMenuItem3 = new DropdownMenuItem(
      child: new Text('外科'),
      value: '外科',
    );
    items.add(dropdownMenuItem3);
    DropdownMenuItem dropdownMenuItem4 = new DropdownMenuItem(
      child: new Text('妇产科'),
      value: '妇产科',
    );
    items.add(dropdownMenuItem4);
    DropdownMenuItem dropdownMenuItem5 = new DropdownMenuItem(
      child: new Text('男科'),
      value: '男科',
    );
    items.add(dropdownMenuItem5);
    DropdownMenuItem dropdownMenuItem6 = new DropdownMenuItem(
      child: new Text('儿科'),
      value: '儿科',
    );
    items.add(dropdownMenuItem6);
    DropdownMenuItem dropdownMenuItem7 = new DropdownMenuItem(
      child: new Text('五官科'),
      value: '五官科',
    );
    items.add(dropdownMenuItem7);
    DropdownMenuItem dropdownMenuItem8 = new DropdownMenuItem(
      child: new Text('肿瘤科'),
      value: '肿瘤科',
    );
    items.add(dropdownMenuItem8);
    DropdownMenuItem dropdownMenuItem9 = new DropdownMenuItem(
      child: new Text('中医科'),
      value: '中医科',
    );
    items.add(dropdownMenuItem9);
    DropdownMenuItem dropdownMenuItem10 = new DropdownMenuItem(
      child: new Text('传染科'),
      value: '传染科',
    );
    items.add(dropdownMenuItem10);
    return items;
  }

  Future<void> _selectDate() async //异步
  {
    final DateTime selectdate = await showDatePicker(
      //等待异步处理的结果
      //等待返回
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (selectdate == null) return; //点击DatePicker的cancel

    setState(() {
      //点击DatePicker的OK
      date = selectdate;
    });
  }

  void summit() async {
    var loginForm = textFromKey.currentState;
    print(displayPath.length);
//    验证Form表单
    if (loginForm.validate() &&
        ( displayPath.length != 0)) {
      Map<String, dynamic> map = Map();

      map['date'] = date.toIso8601String().substring(0, 10);
      map['time'] = time.format(context);
      map['description'] = recordcontent;
      map['userId'] = uid;
      map['position'] = position;
      selectedFiles.clear();
      for (String path in displayPath) {
        await MultipartFile.fromFile(path).then((value) {
          if (value != Null) {
            flag2 = 1;
          }
          MultipartFile tempfile = value;
          print('*****************' + path);
          selectedFiles.add(tempfile);
          print(selectedFiles.length);
        });
      }

      map['files'] = selectedFiles;
      print(map.toString());
      FormData formData = new FormData.fromMap(map);
      print(formData.toString());

      DioManager.getInstance().post('DiseaseSelfCheck/SelfPhoto', formData, (data) {
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
            titleText: '操作成功', contentText: '门诊病历上传成功', ButtonList: bottonList);
        print(data);
      }, (error) {
        print(error);
        ShowToast.getShowToast().showToast('网络异常，请稍后再试');
      }, ContentType: 'multipart/form-data');
    } else {
      ShowToast.getShowToast().showToast('请将信息填写完整');
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    Widget basicInfo = Container(
      padding: EdgeInsets.only(left: 20, right: 20, bottom: 30),
      child: Container(
          child: Form(
        key: textFromKey,
        child: Column(
          children: <Widget>[
            InkWell(
              onTap: _selectDate,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    '体检日期:',
                    style: TextStyle(fontSize: 19),
                  ),
                  Text(
//                  date.year.toString()+'-'+date.month.toString()+'-'+date.day.toString(),
                    DateFormat.yMd().format(date),
                    style: TextStyle(fontSize: 19),
                  ),
                ],
              ),
            ),
            Divider(
              thickness: 2,
            ),
            InkWell(
              onTap: () async {
                var picker = await showTimePicker(
                    context: context, initialTime: TimeOfDay.now());
                if (picker == null) return;
                setState(() {
                  time = picker;
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    '拍照时间:',
                    style: TextStyle(fontSize: 19),
                  ),
                  Text(
//                  date.year.toString()+'-'+date.month.toString()+'-'+date.day.toString(),
                    time.format(context),
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
                TextFormField(
                  decoration: new InputDecoration(
                    labelText: '拍照部位',
                    labelStyle: new TextStyle(
                        fontSize: 15.0, color: Color.fromARGB(255, 93, 93, 93)),
                    border: InputBorder.none,
                  ),
                  onChanged: (value) {
                    position = value;
                  },
                  validator: (value) {
                    if (value == null) {
                      return '请填写拍照部位';
                    } else {
                      return null;
                    }
                  },
                ),
                Divider(
                  thickness: 2,
                ),
                TextFormField(
                  decoration: new InputDecoration(
                    labelText: '请输入文字描述',
                    labelStyle: new TextStyle(
                        fontSize: 15.0, color: Color.fromARGB(255, 93, 93, 93)),
                    border: InputBorder.none,
                  ),
                  maxLines: 4,
                  maxLength: 250,
                  onChanged: (value) {
                    recordcontent = value;
                  },
                  validator: (value) {
                    if (value == null) {
                      return '请填写文字描述';
                    } else {
                      return null;
                    }
                  },
                ),
                Divider(
                  thickness: 2,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      '图片上传:',
                      style: TextStyle(fontSize: 19),
                    ),
                    Row(
                      children: <Widget>[
                        new Container(
                            margin: EdgeInsets.only(right: 10),
                            child: RaisedButton(
                              elevation: 0,
                              onPressed: _selectFilefromCamera,
                              color: Colors.blue,
                              child: new Text('相机拍照',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                  )),
                              shape: new RoundedRectangleBorder(
                                  borderRadius:
                                      new BorderRadius.circular(40.0)),
                            )),
                        new Container(
//                    margin: EdgeInsets.only(left: 30),
                            child: RaisedButton(
                          elevation: 0,
                          onPressed: _selectFile,
                          color: Colors.blue,
                          child: new Text('选择图片',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                              )),
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(40.0)),
                        )),
                      ],
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      '已选择图片:',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                smallPicGridView(displayPath),
              ],
            )
          ],
        ),
      )),
    );

    Widget dividerline = Container(
      height: 60,
    );

    Widget ok = new Container(
//      padding: EdgeInsets.only(left: 10,right: 10,bottom: 0),
      height: 50.0,
      margin: EdgeInsets.only(top: 0.0, bottom: 30, left: 30, right: 30),
      child: new SizedBox.expand(
        child: new RaisedButton(
          elevation: 0,
          onPressed: summit,
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
            '病症自拍',
            style: TextStyle(color: Colors.black),
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
                children: <Widget>[basicInfo, dividerline, ok],
              ),
            )
          ],
        ));
  }
}
