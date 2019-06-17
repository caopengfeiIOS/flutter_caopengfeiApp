import 'package:flutter/material.dart';
class gridPage extends StatefulWidget {
  @override
  _gridPageState createState() => _gridPageState();
}

class _gridPageState extends State<gridPage> {
  @override



  Widget build(BuildContext context) {
    List<Container> _buildCell(int count){
      return new List.generate(

          count,
              (int index) =>new Container(
            color: Colors.blue,
            child: new Image.asset('images/0.png'),

          )
      );
    }
    Widget grideView = new CustomScrollView(
      primary: true,
      slivers: <Widget>[
        new SliverPadding(
            padding:const EdgeInsets.all(10.0),
            sliver: new SliverGrid.count(
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 30,
                crossAxisCount: 2,

              children: _buildCell(10),
            ),
        ),
      ],
    );

    return Scaffold(
      appBar: new AppBar(
        title: new Text('grideView'),
      ) ,
      body: grideView,
    );
  }
}
