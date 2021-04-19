import 'package:flutter/material.dart';
import 'dart:io';

Widget onePicWidget(String filePath, double width, double height) {
  String Path = filePath;
  if (Path != null) {
    Widget widget = new Center(
        child: Container(
          width: width,
          height: height,
          child: new Image(
            image: FileImage(File(Path)),
            fit: BoxFit.cover,
          ),
        ) //这句可以完成中心裁剪,
    );

//    Container(child: new Image(image: FileImage(File(piclist[index])), fit: BoxFit.cover,), //这句可以完成中心裁剪
    return widget;
  } else {
    return Text(
      '未选择文件',
      style: TextStyle(fontSize: 16),
    );
  }
}

Widget smallPicGridView(List list) {
  List piclist = list;
  if (piclist.length > 0) {
    return new GridView.builder(
      shrinkWrap: true, //解决 listview 嵌套报错
      physics: NeverScrollableScrollPhysics(), //禁用滑动事件
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, //每行三列
          mainAxisSpacing: 4, //
          crossAxisSpacing: 8, //缩略图间距
          childAspectRatio: 1.0 //显示区域宽高相等
      ),
      itemCount: piclist.length,
      itemBuilder: (context, index) {
        return new GestureDetector(
          child: Container(
            child: new Image(
              image: FileImage(File(piclist[index])),
              fit: BoxFit.cover,
            ), //这句可以完成中心裁剪
          ),
          onTap: () {
//                        Navigator.push(context, MaterialPageRoute(builder: (context) => BigPhoto(url: urls[index],)));
          },
        );
      },
    );
  } else {
    return Text(
      '未选择文件',
      style: TextStyle(fontSize: 16),
    );
  }
}