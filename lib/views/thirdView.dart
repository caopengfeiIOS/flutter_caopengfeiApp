import 'package:flutter/material.dart';
import '../views/fiveView.dart';
class ThirdPage extends StatefulWidget{
  @override
  ThirdPageState createState() => new ThirdPageState();


}
class ThirdPageState extends State<ThirdPage>{
  final List<String> items = new List<String>.generate(1000, (i) => 'item$i');
  var throwShow = false;
  void initState(){
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    Widget list = new ListTile(
      title: new Text('list'),
      subtitle: new Text('subList'),
      leading: new Icon(Icons.edit,color: Colors.blueAccent),
      trailing: new Checkbox(
          value:throwShow,
          onChanged : (bool value){
           setState((){
             throwShow = value;
           }
           );
      }
      ),
    );
   Widget getContainer(String test,IconData icon){
         return new Container(
           width: 160,
           child: new ListTile(
             leading: new Icon(icon),
             trailing: new Icon(icon),
             title: new Text(test),
             subtitle: new Text('cpf  测试数据'),
           ),
         );
   }

    Widget listView = new ListView(
      children: <Widget>[
          getContainer('11111', Icons.home),
        getContainer('22222', Icons.star),
        getContainer('33333', Icons.print)
      ],
    );
    // TODO: implement build

    Widget bigListVIew = new ListView.builder(
      itemCount: items.length,
        itemBuilder:(context ,index){
        return new ListTile(
          title:new Text ('${items[index]}'),
          onTap: (){
            Navigator.push(context,
            new MaterialPageRoute(builder: (context)=> new fivePage())
            );
          }
        );
        }
    );

    return new Scaffold(
      appBar: new AppBar(
        title: new Text('界面'),

      ),
      body:
          new Card(
            child: bigListVIew,
      ),

    );
  }
}