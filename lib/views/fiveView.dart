import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart' show debugPaintSizeEnabled;
class fivePage extends StatefulWidget {
  @override
  _fivePageState createState() => _fivePageState();
}

class _fivePageState extends State<fivePage> {
  @override
  Widget build(BuildContext context) {
    Widget img = new Expanded(child:
          new Container(
            decoration: new BoxDecoration(
              border:  new Border.all(color: Colors.red,width: 15.0),
              borderRadius: const BorderRadius.all(const Radius.circular(30.0))),
              margin: const EdgeInsets.all(4.0),
             child: new Image.asset('images/0.png'),
            ),
          );
   Widget row = new Row(
     children: <Widget>[
       img,
       img,
     ],
   );

    return new Scaffold(
      appBar: new AppBar(
        title: new Text('cpf跳转'),
      ),
      body: new Container(
        decoration: new BoxDecoration(
          color: Colors.blue,
        ),
        child: new ListView(
          children: <Widget>[
            new RaisedButton(child: new Text('注销'), onPressed: (){
              Navigator.pop(context);
            }),
            row,
            row,
            row,
            row,
          ],

        ),

      ),
    );
  }
}

