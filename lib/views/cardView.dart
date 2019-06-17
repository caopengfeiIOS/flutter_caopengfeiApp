import 'package:flutter/material.dart';

class cardPage extends StatefulWidget {
  @override
  _cardPageState createState() => _cardPageState();
}

class _cardPageState extends State<cardPage> {
  @override



  Widget build(BuildContext context) {
    Widget img = new Stack(
       alignment: AlignmentDirectional.bottomStart,
       children: <Widget>[
         new Image.asset('images/4.png'),
    new Container(
    padding: const EdgeInsets.only(left: 15.0, bottom: 15.0),
    child: new Text(
    "Top 10 Australian beaches",
    style: new TextStyle(color: Colors.white, fontSize: 20.0),
    ))
       ],
    );
    Widget getrowText(String str){
        return new Text(
          str,
          style: TextStyle(color: Colors.white,fontSize: 14.0),
        );
    }
    Widget rowText = new Expanded(
        child: new Container(
          margin: const EdgeInsets.only(left: 10.0, top: 10.0),
          padding: const EdgeInsets.all(5.0),
          child: new Column(
            //横轴对齐方式 起始测对齐
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              new Text("Number 10",style: const TextStyle(color: Colors.red),),
              new Text("Whitehaven Beach",style: const TextStyle(color: Colors.red),),
              new Text("Whitsunday lsland, Whitsunday lslands",style: const TextStyle(color: Colors.red),),
            ],
          ),
        )
    );
    getNewRowText(String str){
      return new Text(
        str,
        style: TextStyle(color: Colors.blue,fontSize: 16.0),
      );
    }
    Widget botttomRwo = new Row(
      children: <Widget>[
        getNewRowText('bottomText1'),
        getNewRowText('bottomText2'),
      ],
    );
    Widget mainCard = new Card(
      //背景色
      color: Colors.cyan,
      //阴影大小-默认2.0
      elevation: 5.0,
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          img,
          rowText,
          botttomRwo,

        ],
      ),
    );
    return Scaffold(
     appBar: new AppBar(
       title: new Text('card'),
     ),
      body:  new SizedBox(
        height: 420.0,
        child: mainCard,
      ),

    );
  }
}

