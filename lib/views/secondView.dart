import 'package:flutter/material.dart';
class SecondPage extends StatefulWidget{
  @override
  SecondPageState createState() => new SecondPageState();


}
class SecondPageState extends State<SecondPage> {
  @override
  Widget build(BuildContext context) {
     Widget titleSection = new Container(
      padding: const EdgeInsets.all(30.0),
      child: new Row(
        children: <Widget>[
          new Expanded(child:
          new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Container(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: new Text(
                  'ceshiyixia',
                  style: new TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              new Text(
                  'hjhkhkhjkhj',
                  style: new TextStyle(
                    color: Colors.red,
                  )
              ),
            ],
          )
          ),
          new Icon(
            Icons.star,
            color: Colors.grey,
          ),
          new Text('44444')

        ],
      ),

    );
     @override
     Column  getText(IconData icon,String text){
       return new Column(
         mainAxisSize: MainAxisSize.max,
         mainAxisAlignment: MainAxisAlignment.end,
         children: <Widget>[
           new Icon(icon,color: Colors.blue),
           new Container(
             margin: const EdgeInsets.only(top: 10.0),
             child: new Text(
               text,
               style: new TextStyle(
                   color: Colors.blue
               ),
             ),
           )
         ],
       );
     }
     Widget buttonSection = new Container(
       child: new Row(
         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
         children: <Widget>[
           getText(Icons.cloud, 'NER'),
           getText(Icons.home, 'HIOM'),
           getText(Icons.list, 'NEWW')
         ],
       ),
     );
     Widget textSecttion = new Container(
       padding: const EdgeInsets.only(top:100.0),
       child: new Text(
         '罚款哈姐姐反馈哈开始就放寒假卡号发快递就会发空间啊的护肤科技啊的护肤科技啊护肤科技阿富汗金卡换房间卡的话费即可获得房间看哈看到卷发好看绝代风华卡家的哈大家开发哈看绝代风华卡缴费和卡缴费后',
         softWrap: true,
       ),
     );
     return new MaterialApp(
       title: 'caopengfei app',
       home: new Scaffold(
         appBar: new AppBar(
           title: new Text('caopgnfeiAPPPPP'),
         ),
         body: new ListView(
           children: <Widget>[
             new Image.asset(
               'images/0.png',
               width: 600,
               height: 240,
               fit: BoxFit.cover,
             ),
             titleSection,
             buttonSection,
             textSecttion,
           ],
         ),
       ),
     );

  }


}