import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class webView extends StatelessWidget {
  final String url;
  webView({Key key,this.url}):super(key:key);

  @override
  Widget build(BuildContext context) {
    List<Widget> titleContent = [];
    titleContent.add(new Text("关于我们",
    style: TextStyle(color: Colors.white),
    ));
    titleContent.add(new Container(width: 50,));
    return new WebviewScaffold(url: url,
// 登录的URL
      appBar: new AppBar(
        title: new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: titleContent,
        ),
        iconTheme: new IconThemeData(color: Colors.white),
      ),
      withZoom: true,
      // 允许网页缩放
      withLocalStorage: true,
      // 允许LocalStorage
      withJavascript: true, // 允许执行js代码
    );

  }
}
