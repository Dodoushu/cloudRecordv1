
import 'package:cloudrecord/untils/http_service.dart';
import 'package:cloudrecord/untils/showAlertDialogClass.dart';
import 'package:cloudrecord/untils/showToast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LeaveMessage extends StatefulWidget {
  String userid;
  LeaveMessage(String userid){
    this.userid = userid;
  }
  @override
  _LeaveMessage createState() => new _LeaveMessage(userid);
}

class _LeaveMessage extends State<LeaveMessage> {

  _LeaveMessage(String userid) {
    this.userid = int.parse(userid);
  }

  String date;
  int duid;
  int userid;
  String leaveMessage = null;


  void getInfo() async{

    SharedPreferences prefs = await SharedPreferences.getInstance();
    duid = int.parse(prefs.getString('uid'));
    print(duid);
    DateTime date_ = DateTime.now();
    date = date_.toString().substring(0,10);
    print(date);
  }

  void submit() async {
    print("!!!!");
    if(leaveMessage.isNotEmpty){
      Map map = Map();
      map['date'] = date;
      map['userId'] = userid;
      map['patientId'] = duid;
      map['leaveMessage'] = leaveMessage;
      print(map);
      DioManager.getInstance().post('/LeaveMessage', map, (data){
        ShowToast.getShowToast().showToast('留言成功');
        print(data['status_code']);
      }, (error) {
        print(error);
        ShowToast.getShowToast().showToast('网络异常，请稍后再试');
      });
    }
    else{
      ShowToast.getShowToast().showToast("请检查留言");
      print("***");
    }

  }
  @override
  Widget build(BuildContext context) {
    getInfo();
    return new Scaffold(
      appBar: new AppBar(
        title: Text('留言'),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                    padding: EdgeInsets.only(left: 5,top: 5),
                  child: Text("请在下方留言:",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(left: 10,right: 10),
                  child: TextFormField(
                    decoration: new InputDecoration(
                      labelText: '最多250字',
                      labelStyle: new TextStyle(
                          fontSize: 15.0,
                          color: Color.fromARGB(255, 93, 93, 93)),
                      border: InputBorder.none,
                    ),
                    maxLines: 3,
                    maxLength: 250,
                    maxLengthEnforced: true,
                    onChanged: (value) {
                      leaveMessage  = value;
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 10,right: 10),
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
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

}