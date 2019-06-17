import 'package:flutter/material.dart';

//自定义带图标的输入框
class CPFTextfieldPage extends StatefulWidget {
  final bool obscureText;

  final String hintText;

  final IconData iconData;

  final ValueChanged<String> onChanged;

  final TextStyle textStyle;

  final TextEditingController controller;
  CPFTextfieldPage({Key key,this.obscureText = false,this.hintText,this.iconData,this.onChanged,this.textStyle,this.controller }) :super(key :key);



  @override
  _CPFTextfieldPageState createState() => _CPFTextfieldPageState();
}

class _CPFTextfieldPageState extends State<CPFTextfieldPage> {
  @override
  Widget build(BuildContext context) {
    return new TextField(
      controller: widget.controller,
      onChanged: widget.onChanged,
      obscureText: widget.obscureText,
      decoration: new InputDecoration(
        hintText: widget.hintText,
        icon: widget.iconData == null ? null : new Icon(widget.iconData),
      ),
    );
  }
}
