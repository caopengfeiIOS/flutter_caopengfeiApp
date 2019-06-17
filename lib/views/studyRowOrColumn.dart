import 'package:flutter/material.dart';
class rowPage extends StatefulWidget {

  @override
  _rowPageState createState() => _rowPageState();
}

class _rowPageState extends State<rowPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('控制row和column'),
      ),
      body: new Center(
        child: new Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new Icon(Icons.star,color: Colors.red,),
            new Icon(Icons.star,color: Colors.red,),
            new Icon(Icons.star,color: Colors.red,),
            new Icon(Icons.star,color: Colors.grey,),
            new Icon(Icons.star,color: Colors.grey,),
          ],
        ),
      ),
    );
  }
}
