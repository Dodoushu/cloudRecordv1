import 'package:cloudrecord/untils/MessageMethod.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:dio/dio.dart';
import 'package:cloudrecord/untils/pickFileMethod.dart';
import 'package:cloudrecord/untils/picWidget.dart';
import 'package:cloudrecord/untils/http_service.dart';
import 'package:cloudrecord/untils/showToast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloudrecord/untils/showAlertDialogClass.dart';
import 'package:yaml/yaml.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

void main() => runApp(MaterialApp(
      home: laboratory(),
    ));

class laboratory extends StatefulWidget {
  @override
  State createState() => new _laboratory();
}

class _laboratory extends State<laboratory> {
  @override
  void initState() {
    super.initState();
    getId();
    getYamlData().then((value){
      checkList = value;
      setState(() {
        print('Loaded checklist');
      });
    });
  }

  Future getYamlData() async {
    var yamlstr = await rootBundle.loadString('assets/userConfig.yaml');
    var doc = loadYaml(yamlstr);
    List list = doc['checkClassfyNum']['labortory'];
    return list;
  }

  GlobalKey<FormState> textFromKey = new GlobalKey<FormState>();

  DateTime date;
  String hospital;
  String office;
  int subSubItems;
  String recordcontent;
  String lebalContent = '请选择科室';
  String checkLebalContent = '请选择分类';

  String introduction;
  String filesname;
  String filespath;
  List selectedFiles = [];
  List displayPath = [];
  var flag2 = 0;
  String uid;

  getId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('uid')) {
      uid = prefs.getString('uid');
    }
  }

  Future<void> _selectFile() async {
    Map filesPaths;
    getMultiFilesPath().then((value) {
      filesPaths = value;
      var selectedFilePaths = filesPaths.values;
      List newList = new List();
      for (String path in selectedFilePaths) {
        newList.add(path);
      }
      if(newList.length+displayPath.length>9){
        Widget okButton = FlatButton(
          child: Text("好的"),
          onPressed: () {
            Navigator.pop(context);
          },
        );

        List<FlatButton> bottonList = new List();
        bottonList.add(okButton);
        showAlertDialog(context,
            titleText: '图片过多', contentText: '图片数量最多为9张', ButtonList: bottonList);
        return;
      }
      for (String path in selectedFilePaths) {
        displayPath.add(path);
      }
      setState(() {
        filesname = displayPath.toString();
      });
    });
  }

  Future<void> _selectFilefromCamera() async {
    getImageFileFromCamera().then((value) {

      if(value!=null){
        if(displayPath.length<9){
          displayPath.add(value);
        }else{
          Widget okButton = FlatButton(
            child: Text("好的"),
            onPressed: () {
              Navigator.pop(context);
            },
          );

          List<FlatButton> bottonList = new List();
          bottonList.add(okButton);
          showAlertDialog(context,
              titleText: '图片过多', contentText: '图片数量最多为9张', ButtonList: bottonList);
        }
      }

      setState(() {
        filesname = displayPath.toString();
      });
    });
  }

//  Future<void> _selectFile() async {
//    Map filesPaths;
//    getMultiFilesPath().then((value) {
//      filesPaths = value;
//      var selectedFilePaths = filesPaths.values;
//      List newList = new List();
//      for (String path in selectedFilePaths) {
//        newList.add(path);
//      }
//      if(newList.length+displayPath.length>9){
//        Widget okButton = FlatButton(
//          child: Text("好的"),
//          onPressed: () {
//            Navigator.pop(context);
//          },
//        );
//
//        List<FlatButton> bottonList = new List();
//        bottonList.add(okButton);
//        showAlertDialog(context,
//            titleText: '图片过多', contentText: '图片数量最多为9张', ButtonList: bottonList);
//        return;
//      }
//      for (String path in selectedFilePaths) {
//        displayPath.add(path);
////        MultipartFile.fromFile(path).then((value) {
////          if (value != Null) {
////            flag2 = 1;
////          }
////          tempfile = value;
////          print('*****************' + path);
////          selectedFiles.add(tempfile);
////          print(selectedFiles.length);
////        });
//      }
//      setState(() {
//        filesname = displayPath.toString();
//      });
//    });
//  }
//
//  Future<void> _selectFilefromCamera() async {
//    getImageFileFromCamera().then((value) {
//      displayPath.add(value);
////      var selectedFilePaths = value;
////      MultipartFile tempfile;
////
////      MultipartFile.fromFile(selectedFilePaths).then((value) {
////        if (value != Null) {
////          flag2 = 1;
////        }
////        tempfile = value;
////        print('1111111111111111111111' + selectedFilePaths);
////        selectedFiles.add(tempfile);
////        print(selectedFiles.length);
////      });
//
//      setState(() {
//        filesname = displayPath.toString();
//      });
//    });
//  }

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

  List checkList;

  List<DropdownMenuItem> getcheckListData() {
    List<DropdownMenuItem> items = new List();
    DropdownMenuItem dropdownMenuItem0 = new DropdownMenuItem(
      child: new Text(checkList[0]),
      value: 0,
    );
    items.add(dropdownMenuItem0);
    DropdownMenuItem dropdownMenuItem1 = new DropdownMenuItem(
      child: new Text(checkList[1]),
      value: 1,
    );
    items.add(dropdownMenuItem1);
    DropdownMenuItem dropdownMenuItem2 = new DropdownMenuItem(
      child: new Text(checkList[2]),
      value: 2,
    );
    items.add(dropdownMenuItem2);
    DropdownMenuItem dropdownMenuItem3 = new DropdownMenuItem(
      child: new Text(checkList[3]),
      value: 3,
    );
    items.add(dropdownMenuItem3);
    DropdownMenuItem dropdownMenuItem4 = new DropdownMenuItem(
      child: new Text(checkList[4]),
      value: 4,
    );
    items.add(dropdownMenuItem4);
    DropdownMenuItem dropdownMenuItem5 = new DropdownMenuItem(
      child: new Text(checkList[5]),
      value: 5,
    );
    items.add(dropdownMenuItem5);
    DropdownMenuItem dropdownMenuItem6 = new DropdownMenuItem(
      child: new Text(checkList[6]),
      value: 6,
    );
    items.add(dropdownMenuItem6);
    DropdownMenuItem dropdownMenuItem7 = new DropdownMenuItem(
      child: new Text(checkList[7]),
      value: 7,
    );
    items.add(dropdownMenuItem7);
    return items;
  }

  Future<void> _selectDate() async {
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
//    验证Form表单

    List MessageList = ['检查日期','检查科室','请填写文字描述或上传图片'];
    List NullList = [];
    if(displayPath.length == 0 && recordcontent == null)
      NullList = [date,office,null];
    else
      NullList = [date,office,1];

    MessageMethod Message = new MessageMethod(MessageList,NullList);
    List messageAndifture = Message.getMessage();
    String message = messageAndifture[0];
    bool IfTrue = messageAndifture[1];





    if (loginForm.validate() && IfTrue) {
      
      Map<String, dynamic> map = Map();

      map['date'] = date.toIso8601String().substring(0, 10);
      map['section'] = office;
      map['hospital'] = hospital;
      map['description'] = recordcontent;
      map['items'] = 1;
      map['subItems'] = subSubItems;
      map['subSubItems'] = 0;
      map['subSubItems'] = 0;
      map['subSubItems'] = 0;
      map['userId'] = uid;
      
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

      DioManager.getInstance().post('UploadCheckRecords', formData,
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
            titleText: '操作成功', contentText: '化验检查上传成功', ButtonList: bottonList);
        print(data);
      }, (error) {
        print(error);
        ShowToast.getShowToast().showToast('网络异常，请稍后再试');
      }, ContentType: 'multipart/form-data');
    } else {
      if(IfTrue == true){
        ShowToast.getShowToast().showToast("信息填写不全，请检查");
      }
      else{
        ShowToast.getShowToast().showToast(message);
      }
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
                  onTap: _selectDate,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        '检查日期:',
                        style: TextStyle(fontSize: 19),
                      ),
                      Text(
//                  date.year.toString()+'-'+date.month.toString()+'-'+date.day.toString(),
                        date==null?'未选择日期':DateFormat.yMd().format(date),
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
                        labelText: '检查医院',
                        labelStyle: new TextStyle(
                            fontSize: 15.0,
                            color: Color.fromARGB(255, 93, 93, 93)),
                        border: InputBorder.none,
                      ),
                      maxLength: 30,
                      inputFormatters: <TextInputFormatter>[
                        LengthLimitingTextInputFormatter(30)//限制长度
                      ],
                      onChanged: (value) {
                        hospital = value;
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return '请填写检查医院';
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
                          '检查科室:',
                          style: TextStyle(fontSize: 19),
                        ),
                        new DropdownButton(
                          items: getListData(),
                          hint: new Text(lebalContent), //当没有默认值的时候可以设置的提示
//                  value: value,//下拉菜单选择完之后显示给用户的值
                          onChanged: (value) {
                            //下拉菜单item点击之后的回调
                            office = value;
                            setState(() {
                              lebalContent = value;
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          '检查分类:',
                          style: TextStyle(fontSize: 19),
                        ),
                        new DropdownButton(
                          items: getcheckListData(),
                          hint: new Text(checkLebalContent), //当没有默认值的时候可以设置的提示
//                  value: value,//下拉菜单选择完之后显示给用户的值
                          onChanged: (value) {
                            //下拉菜单item点击之后的回调
                            subSubItems = value;
                            print(subSubItems);
                            setState(() {
                              checkLebalContent = checkList[value];
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
                    TextField(
                      decoration: new InputDecoration(
                        labelText: '请输入文字描述',
                        labelStyle: new TextStyle(
                            fontSize: 15.0,
                            color: Color.fromARGB(255, 93, 93, 93)),
                        border: InputBorder.none,
                      ),
                      maxLines: 4,
                      maxLength: 250,
                      onChanged: (value) {
                        recordcontent = value;
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
                                  borderRadius:
                                      new BorderRadius.circular(40.0)),
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
          ),
        ));

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
          onPressed: () {
            try {
              summit();
            } catch (e) {
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
            '化验检查',
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
