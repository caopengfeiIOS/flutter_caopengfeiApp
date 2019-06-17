import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show SynchronousFuture;
class localizationTest{
  final Locale locale;
  localizationTest(this.locale);
  static Map<String ,Map<String,String>>_localizedValues = {
    'en' : {
      'list title' : 'List',
      'order title' : 'Message',
      'mine title' : 'My',
      'test title' : 'Test',
      'zhongwen' :'chinese',
      'yingwen' : 'english',
      'Internationa lization':'Internationalization',
      'switch lan':'switch language'
    },
    'zh' : {
      'list title' : '列表',
      'order title' : '消息',
      'mine title' : '我的',
      'test title' : '测试',
      'zhongwen' :'中文',
      'yingwen' : '英文',
      'Internationa lization':'国际化',
      'switch lan':'语言切换'
    }
  };
  get  taskTitle{
    return _localizedValues[locale.languageCode]['list title'];
  }
  get  orderTitle{
     return _localizedValues[locale.languageCode]['order title'];
  }
  get myTitle{
     return _localizedValues[locale.languageCode]['mine title'];
  }
  get testTitle{
     return _localizedValues[locale.languageCode]['test title'];
  }
  get zhongwen{
    return _localizedValues[locale.languageCode]['zhongwen'];
  }
  get yingwen{
    return _localizedValues[locale.languageCode]['yingwen'];
  }
  get lization{
    return _localizedValues[locale.languageCode]['Internationa lization'];
  }
  get switchLanguage{
    return _localizedValues[locale.languageCode]['switch lan'];
  }

  static localizationTest of(BuildContext context){
    return Localizations.of(context, localizationTest);
  }
}
class LocalizationTestDelegate extends LocalizationsDelegate<localizationTest>{
  const LocalizationTestDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en','zh'].contains(locale.languageCode);
  }

  @override
  Future<localizationTest> load(Locale locale) {
    return new SynchronousFuture<localizationTest>(new localizationTest(locale));
  }

  @override
  bool shouldReload(LocalizationsDelegate<localizationTest> old) {
    return false;
  }

  static LocalizationTestDelegate delegate = const LocalizationTestDelegate();

}