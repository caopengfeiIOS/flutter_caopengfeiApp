import 'package:flutter/material.dart';
import 'package:flutter_app/Localizations/LocalizationsTest.dart';
class localizaPage extends StatefulWidget {
  @override
  _localizaPageState createState() => _localizaPageState();
}

class _localizaPageState extends State<localizaPage> {
  Locale _locale = const Locale('en','US');

  _click(){

    setState(() {



    });
  }
  @override
  Widget build(BuildContext context) {

    return new Localizations.override(
      context: context,
      locale: _locale,
      child: Scaffold(
        appBar: AppBar(
          title: new Text(localizationTest.of(context).lization),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment:  MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            FlatButton(
              child: Text(localizationTest.of(context).switchLanguage),
              onPressed: () => _click(),
            ),

          ],
        ),

      ),
    );

//    return Scaffold(
//      appBar: AppBar(
//        title: new Text(localizationTest.of(context).lization),
//      ),
//      body: Column(
//        crossAxisAlignment: CrossAxisAlignment.center,
//        mainAxisAlignment:  MainAxisAlignment.center,
//        mainAxisSize: MainAxisSize.max,
//        children: <Widget>[
//          FlatButton(
//            child: Text(localizationTest.of(context).switchLanguage),
//            onPressed: () => _click(iszhongwen),
//          ),
//
//        ],
//      ),
//
//    );
  }
}
