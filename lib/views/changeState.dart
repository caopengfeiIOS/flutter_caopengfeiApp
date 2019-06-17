import 'package:flutter/material.dart';
class changeStatePage extends StatefulWidget {
  @override
  _changeStatePageState createState() => _changeStatePageState();
}

class _changeStatePageState extends State<changeStatePage> {




  @override
  Widget build(BuildContext context) {

    Widget _getnewContent (){
      return new Container(
        color: Colors.blue,
        width: 180,
        child: new ListTile(
          title: new Text('111'),
        ),
      );
    }

    return new Scaffold(
      appBar: new AppBar(
        title:  new Text('改变列表状态'),
      ),
      body: new ListView(
        padding: new EdgeInsets.symmetric(vertical: 10.0),
        children: <Widget>[
             

        ],
      ),
    );
  }
}
