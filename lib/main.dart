import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import './views/firstpage.dart';
import './views/secondView.dart';
import './views/thirdView.dart';
import './views/fourView.dart';
import 'package:redux/redux.dart';
import './redux/cpf_state.dart';
import './redux/user_redux.dart';
import './model/user_model.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_app/generated/translations.dart';
import 'package:flutter_app/generated/application.dart';
import 'package:flutter_app/Scoped_model/CountModel.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_app/Localizations/LocalizationsTest.dart';
import 'package:oktoast/oktoast.dart';
import 'package:fluro/fluro.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter_app/views/SplashPage.dart';
void main() => runApp(MyApp());

//class MyApp extends StatelessWidget {
//  // This widget is the root of your application.
//
//
//  @override
//  Widget build(BuildContext context) {
////    final wordPair = new WordPair.random();
//    return MaterialApp(
//      title: 'Welcome to Flutter',
//      theme: new ThemeData(
//        brightness: Brightness.light,
//        primaryColor: Colors.lightBlue[800],
//        accentColor: Colors.cyan[600],
//      ),
//      home: new MyHomePage(),
//    );
//  }
//}

class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  CountModel countModel = CountModel();


  SpecificLocalizationDelegate _localeOverrideDelegate;

  @override
  void initState() {
    super.initState();
    _initAsync();
    /// 初始化一个新的Localization Delegate，有了它，当用户选择一种新的工作语言时，可以强制初始化一个新的Translations
    _localeOverrideDelegate = new SpecificLocalizationDelegate(null);

    /// 保存这个方法的指针，当用户改变语言时，我们可以调用applic.onLocaleChanged(new Locale('en',''));，通过SetState()我们可以强制App整个刷新
    applic.onLocaleChanged = onLocaleChange;
  }
  _initAsync() async {
    /// App启动时读取Sp数据，需要异步等待Sp初始化完成。
    await SpUtil.getInstance();

    /// 同步使用Sp。
//    SpUtil.remove("username");
//    String defName = SpUtil.getString("username", defValue: "sky");
//    SpUtil.putString("username", "sky24");
//    String name = SpUtil.getString("username");
//    print("MyApp defName: $defName, name: $name");
  }
  /// 改变语言时的应用刷新核心，每次选择一种新的语言时，都会创造一个新的SpecificLocalizationDelegate实例，强制Translations类刷新。
  onLocaleChange(Locale locale) {
    setState(() {
      _localeOverrideDelegate = new SpecificLocalizationDelegate(locale);
    });
  }
  @override
  Widget build(BuildContext context) {

    return ScopedModel<CountModel>(
        model: countModel,
        child: OKToast(
            child:MaterialApp(
              onGenerateTitle: (context){                                              // 此处
                return localizationTest.of(context).taskTitle;
              },

              theme: new ThemeData(
                brightness: Brightness.light,
                primaryColor: Colors.lightBlue[800],
                accentColor: Colors.cyan[600],
              ),
              routes: {
                'route_main' : (context) => new MyHomePage(),
              },
              home: new SplashPage(),
              localizationsDelegates: [
                _localeOverrideDelegate, // 注册一个新的delegate
                const TranslationsDelegate(),
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                LocalizationTestDelegate.delegate
              ],
              supportedLocales: applic.supportedLocales(),
            ),
        ),
    );
//    final wordPair = new WordPair.random();
  }
}



class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}




class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {




  int _counter = 0;
  final _suggestions = <WordPair>[];
  final _saved = new Set<WordPair>();
  final _biggerFont = const TextStyle(fontSize: 18.0);

  Widget _buildSuggestions() {
    return new ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, i) {
          print(i);
          if (i.isOdd) return new Divider();
          final index = i ~/ 2;
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10));
          }
          return _buildRow(_suggestions[index]);
        }
    );
  }
Widget _buildRow (WordPair pair){
    final alreadySaved = _saved.contains(pair);
  return new ListTile(
    title: new Text(
     pair.asPascalCase,
      style: _biggerFont,
  ),
    trailing: new Icon(
      alreadySaved?Icons.favorite : Icons.favorite_border,
      color: alreadySaved? Colors.red : null,
    ),
    onTap: (){
      setState(() {
        if(alreadySaved){
          _saved.remove(pair);
        }else{
          _saved.add(pair);
        }
      });
    },
  );
}
void _pushSaved(){
  Navigator.of(context).push(
    new MaterialPageRoute(
      builder: (context) {
        final tiles = _saved.map(
              (pair) {
            return new ListTile(
              title: new Text(
                pair.asPascalCase,
                style: _biggerFont,
              ),
            );
          },
        );
        final divided = ListTile
            .divideTiles(
          context: context,
          tiles: tiles,
        )
            .toList();

        return new Scaffold(
          appBar: new AppBar(
            title: new Text('Saved Suggestions'),
          ),
          body: new ListView(children: divided),
        );
      },
    ),
  );
}
  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

    TabController controller;
  @override
  void initState(){
    controller = new TabController(length: 4, vsync: this);
  }


  @override
  Widget build(BuildContext context) {
//    final wordPair = new WordPair.random();
//    return new Text(wordPair.asPascalCase);

//    return StoreProvider<CPFState>(store: store,

        return new Scaffold(

          body: new TabBarView(
              controller: controller,
              children: <Widget>[
                new FirstPage('1'),
                new SecondPage(),
                new ThirdPage(),
                new TutorialHome()
              ]
          ),

          bottomNavigationBar: new Material(
            color: Colors.orangeAccent,
            child: new TabBar(
                controller: controller,
                tabs: <Tab>[
                  new Tab(text: localizationTest.of(context).taskTitle ,icon: new Icon(Icons.home)),
                  new Tab(text: localizationTest.of(context).orderTitle,icon: new Icon(Icons.message)),
                  new Tab(text: localizationTest.of(context).myTitle,icon: new Icon(Icons.cloud)),
                  new Tab(text: localizationTest.of(context).testTitle,icon: new Icon(Icons.list))
                ]),
          ),
//      appBar: new AppBar(
//        title: new Text('caopengfei ceshi'),
//        actions: <Widget>[new IconButton(icon: new Icon(Icons.list), onPressed: _pushSaved)],
//      ),
//      body: new Center(
//        child: new Column(
//          mainAxisAlignment: MainAxisAlignment.center,
//          children: <Widget>[new Text(
//            '123132131'
//          ),
//            new Text(
//              '$_counter',
//              style: Theme.of(context).textTheme.display1,
//            ),
//          ],
//        ),
//      ),
//      floatingActionButton: new FloatingActionButton(
//        onPressed: _incrementCounter,
//        tooltip: 'Increment',
//        child: new Icon(Icons.add),
//      ), // This trailing comma makes auto-formatting nicer for build methods.
        );
//    );
  }
}
