import 'package:flutter/material.dart';

class CPFButtonWidget extends StatefulWidget {
  final String text;

  final Color color;

  final Color textColor;

  final VoidCallback onPress;

  final double fontSize;
  final int maxLines;

  final MainAxisAlignment mainAxisAlignment;

  CPFButtonWidget ({Key key,this.text, this.color, this.textColor, this.onPress, this.fontSize = 20.0, this.mainAxisAlignment = MainAxisAlignment.center, this.maxLines = 1}):super(key:key);
  @override
  _CPFButtonWidgetState createState() => _CPFButtonWidgetState();
}

class _CPFButtonWidgetState extends State<CPFButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return new RaisedButton(
        padding: new EdgeInsets.only(left: 20.0, top: 10.0, right: 20.0, bottom: 10.0),
        textColor: widget.textColor,
        color: widget.color,
        child: new Flex(
          mainAxisAlignment: widget.mainAxisAlignment,
          direction: Axis.horizontal,
          children: <Widget>[new Text(widget.text, style: new TextStyle(fontSize: widget.fontSize), maxLines: widget.maxLines, overflow:TextOverflow.ellipsis)],
        ),
        onPressed: () {
          this.widget.onPress?.call();
        });
  }
}
