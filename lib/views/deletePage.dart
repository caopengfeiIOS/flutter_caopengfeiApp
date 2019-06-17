import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
class deletePage extends StatefulWidget {
  @override

  _deletePageState createState() => _deletePageState();
}

class _deletePageState extends State<deletePage> {
  @override
  final List<String> items = new List<String>.generate(20, (i) => 'item${i+1}');
  Widget build(BuildContext context) {
    return Scaffold (
      appBar: new AppBar(
         title: new Text('侧滑删除') ,
      ),
      body: new ListView.builder(
        itemCount: items.length,
          itemBuilder: (context,index){
           final item = items[index];
           return new Dismissible(key: new Key(item),
               onDismissed: (direction) {
                 items.removeAt(index);
                 Scaffold.of(context).showSnackBar(
                     new SnackBar(content: new Text('$item dismissed')));
               },
              background: new Container(
                color: Colors.red,
              ),
               child: new ListTile(
                 title: new Text('$item'),
               ),);
          }
      ),
    );
  }
}
