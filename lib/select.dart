import 'package:cloudrecord/patient/register2.dart';
import 'package:flutter/material.dart';
import 'doctor/register.dart';
import 'patient/register1.dart';

void main() {
  runApp(new MaterialApp(
    title: '',
    home: new Select(),
  ));
}

class Select extends StatefulWidget {
  @override
  _State createState() => new _State();
}

class _State extends State<Select> {

  @override
  Widget build(BuildContext context) {
    double width_ = MediaQuery.of(context).size.width;

    Widget buttonBuilder(String text, IconData icondata, Function clickFunction) {
      return InkWell(
        onTap: clickFunction,
        child: new Container(
            child: Column(children: <Widget>[
              new SizedBox(
                  height: width_ / 2,
                  width: width_ / 2,
                  child: Card(
                      elevation: 15.0, //阴影
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(100.0)),
                      ),
                      child: new Container(
                          alignment: Alignment.center,
                          child: Icon(
                            icondata,
                            size: width_ / 2.5,
                            color: Colors.black,
                          )))),
              new Container(
                  child: Text(
                    text,
                    style: TextStyle(fontSize: width_ / 12),
                  ))
            ])),
      );
    }

    return new Scaffold(
      appBar: new AppBar(
        title: new Text('注册身份选择'),
        centerTitle: true,
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            buttonBuilder('我是医生', Icons.people, (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => register()));
            }),
            buttonBuilder('我是患者', Icons.people_outline, (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => register1()));
            })
          ],
        ),
      ),
    );
  }
}