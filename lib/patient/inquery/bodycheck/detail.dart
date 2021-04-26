import 'dart:io';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'package:file_utils/file_utils.dart';
import 'dart:math';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:cloudrecord/untils/picWidget.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:cloudrecord/untils/showToast.dart';
import 'package:cloudrecord/untils/showAlertDialogClass.dart';
//void main() {
//  runApp(new MaterialApp(
//    title: '',
//    theme: new ThemeData(
//      primarySwatch: Colors.blue,
//    ),
//    home: new (),
//  ));
//}

class detailPage extends StatefulWidget {
  detailPage(Map map) {
    this.map = map;
  }
  Map map;
  @override
  _State createState() => new _State(map);
}

class _State extends State<detailPage> {
  _State(Map map) {
    this.map['date'] = map['date'];
    this.map['hospital'] = map['hospital'];
    this.map['section'] = map['section'];
    this.map['class'] = '体检记录';
    this.map['description'] = map['description'];
    List urlList = new List();
    for (String url in map['address']) {
      print(url.split('.')[url.split('.').length - 1]);
      if (url.split('.')[url.split('.').length - 1] == 'jpg') {
        urlList.add(url);
      } else {
        this.map['file'] = url;
      }
    }
    this.map['address'] = urlList;
    print(this.map);
  }

  static final Random random = Random();
  bool downloading = false;
  double progress = 0;
  var path = "No Data";

  Map map = new Map();

//  {
//    id: 12,
//    date: 2021-04-16,
//    hospital: 1213,
//    section: 中医科,
//    description: 123vr,
//    userId: 30,
//    address: [39.100.100.198/picture/12/ftprush2.2.0.zip],
//    class: 体检记录
//  }

  @override
  Widget build(BuildContext context) {
    Future downloadFile({String url}) async {
      Dio dio = new Dio();
      String path = 'http://' + map['file'];
      //设置连接超时时间
      dio.options.connectTimeout = 100000;
      //设置数据接收超时时间
      dio.options.receiveTimeout = 100000;
      Response response;
      print('start');

      bool status = await Permission.storage.isGranted;
      //判断如果还没拥有读写权限就申请获取权限
      if (!status) {
        return await Permission.storage.request().isGranted;
      }
      // 调用下载方法 --------做该做的事

      try {
        showDialog(                                 //loading动画
            context: context,
            builder: (context) {
              return new NetLoadingDialog();
            }
        );
        response = await dio.download(path, "/storage/emulated/0/test.zip");
        if (response.statusCode == 200) {
          print('下载请求成功');
          ShowToast.getShowToast().showToast('下载文件保存至/storage/emulated/0');
        } else {
          throw Exception('接口出错');
        }
      } catch (e) {
//          showTotast('服务器出错或网络连接失败！');
        ShowToast.getShowToast().showToast('网络出现问题，请稍后重试');
        return print('ERROR:======>$e');
      }finally{
        Navigator.of(context).pop();
      }
    }

    Widget downloadBuilder(){
      Widget download = InkWell(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Flexible(
              child: Text(
                '附带文件:',
                style: TextStyle(fontSize: 19),
              ),
            ),
            Text(
              map.containsKey('file')?map['file'].split('/')[map['file'].split('/').length - 1]:'无',
              style: TextStyle(fontSize: 19),
            ),
          ],
        ),
        onTap: (){

          Widget okButton = FlatButton(
            child: Text("下载"),
            onPressed: () {
              Navigator.pop(context);
              downloadFile().then((value){

              });
            },
          );
          Widget cancelButton = FlatButton(
            child: Text("取消"),
            onPressed: () {
              Navigator.pop(context);
            },
          );
          List<FlatButton> bottonList = new List();
          bottonList.add(okButton);
          bottonList.add(cancelButton);
          showAlertDialog(context, titleText: '下载文件', contentText: '您即将下载附件', ButtonList: bottonList);
        },
      );
      if(map.containsKey('file')){
        return download;
      }else{
        return new Container(
          child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Flexible(
              child: Text(
                '附带文件:',
                style: TextStyle(fontSize: 19),
              ),
            ),
            Text(
              map.containsKey('file')?map['file'].split('/')[map['file'].split('/').length - 1]:'无',
              style: TextStyle(fontSize: 19),
            ),
          ],
        ),
        );
      }
    }

    Widget basicInfo = Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.only(left: 20, right: 20, bottom: 30),
      child: Container(
        child: Column(
          children: <Widget>[
            InkWell(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    '体检日期:',
                    style: TextStyle(fontSize: 19),
                  ),
                  Text(
                    map['date'],
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      '医院:',
                      style: TextStyle(fontSize: 19),
                    ),
                    Flexible(
                      child: Text(
                        map['hospital'],
                        style: TextStyle(fontSize: 19),
                      ),
                    )
                  ],
                ),
                Divider(
                  thickness: 2,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Flexible(
                      child: Text(
                        '体检科室:',
                        style: TextStyle(fontSize: 19),
                      ),
                    ),
                    Text(
                      map['section'],
                      style: TextStyle(fontSize: 19),
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
                      '病例内容:',
                      style: TextStyle(fontSize: 19),
                    ),
                    Container(
                      width: 10,
                    ),
                  ],
                ),
                new Row(
                  children: [
                    Flexible(
                      child: Text(
                        map['description'] == null ? '无' : map['description'],
                        style: TextStyle(fontSize: 19),
                      ),
                    ),
                  ],
                ),
                Divider(
                  thickness: 2,
                ),
                downloadBuilder(),
                Divider(
                  thickness: 2,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      '附带图片:',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                smallPicGridViewNet(map['address'])
              ],
            )
          ],
        ),
      ),
    );

    return new Scaffold(
      appBar: new AppBar(
        title: new Text('体检记录'),
        centerTitle: true,
      ),
      body: Container(
        child: basicInfo,
      ),
    );
  }
}
