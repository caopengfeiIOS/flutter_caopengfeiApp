import 'package:flutter/material.dart';
class List extends StatefulWidget{
  @override
  ListState createState() => new ListState();


}
class ListState extends State<List>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new ListView.builder(
        itemCount: 10,
        itemBuilder: (BuildContext context,int index){
          return new Card();
        }


    );
  }
}