import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:async';
import 'dart:io';
class newAppOrder extends StatefulWidget {
  @override
  _newAppOrderState createState() => _newAppOrderState();
}

class _newAppOrderState extends State<newAppOrder> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  _request()async{
    Response response;
    var formData = {'lon':'115.02932','lat':'35.76189'};
    Dio dio = new Dio();
    dio.options.contentType=ContentType.parse("application/x-www-form-urlencoded");
    response = await dio.post('http://v.jspang.com:8088/baixing/wxmini/homePageContent',data:formData);
    print(response.data);
    return response.data;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _request(),
        builder: (context, data){
         if(data.hasData){

         }
        return Container(

        );

        }
    );
  }
}
