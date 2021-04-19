import 'package:flutter/material.dart';

import 'mainPage.dart';
import 'mainPage2.dart';

void main() {
  runApp(MaterialApp(
    home: BottomNavigationWidget(),
  ));
}

class BottomNavigationWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => BottomNavigationWidgetState();
}

class BottomNavigationWidgetState extends State<BottomNavigationWidget> {
  int currentIndex = 0;
//  List listTabs = [MainPage(), SearchPage(), Setting()];
  List listTabs = [MainPage(), mainPage2()];

  Widget build(BuildContext context) {
    return Scaffold(
      body: listTabs[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.black,
        iconSize: 22,
//        type: BottomNavigationBarType.shifting,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(
                Icons.pages,
                color: Colors.black,
              ),
              title: Text(
                '主页',
                style: TextStyle(
                  fontSize: 18,
                ),
              )),
//          BottomNavigationBarItem(
//              icon: Icon(
//                Icons.search,
//                color: Colors.black,
//              ),
//              title: Text(
//                '查询',
//                style: TextStyle(fontSize: 18),
//              )),
          BottomNavigationBarItem(
              icon: Icon(Icons.accessibility, color: Colors.black),
              title: Text(
                '我的',
                style: TextStyle(fontSize: 18),
              ))
        ],
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
          print(index);
        },
      ),
    );
  }
}

//class BottomNavigationBarClass{
//  BottomNavigationBar Create() {
//    return new BottomNavigationBar(
//      selectedItemColor: Colors.blue,
//      unselectedItemColor: Colors.black,
//      iconSize: 30,
////        type: BottomNavigationBarType.shifting,
//      items: <BottomNavigationBarItem>[
//        BottomNavigationBarItem(
//            icon: Icon(
//              Icons.search,
//              color: Colors.black,
//            ),
//            title: Text(
//              '主页',
//              style: TextStyle(
//                fontSize: 18,
//              ),
//            )),
//        BottomNavigationBarItem(
//            icon: Icon(Icons.pages, color: Colors.black,),
//            title: Text(
//              '我的',
//              style: TextStyle(fontSize: 18),
//            )),
//        BottomNavigationBarItem(
//            icon: Icon(Icons.account_circle, color: Colors.black),
//            title: Text(
//              '设置',
//              style: TextStyle(fontSize: 18),
//            ))
//      ],
//    );
//  }
//}
//
