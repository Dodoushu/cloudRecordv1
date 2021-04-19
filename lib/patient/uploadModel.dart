import 'package:flutter/material.dart';

void main() {
  runApp(new MaterialApp(
    title: '',
    theme: new ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: new uploadModel(),
  ));
}

class uploadModel extends StatefulWidget {
  @override
  _State createState() => new _State();
}

class _State extends State<uploadModel> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(''),
      ),
    );
  }
}