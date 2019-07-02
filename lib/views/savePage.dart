import 'package:flutter/material.dart';
import 'package:flutter_app/location/locationStore.dart';
import 'package:flutter_app/components/CPFTextfield.dart';
import 'package:flutter_app/config/config.dart';
import 'package:oktoast/oktoast.dart';
class savePage extends StatefulWidget {
  @override
  _savePageState createState() => _savePageState();
}

class _savePageState extends State<savePage> {
  final TextEditingController controller = TextEditingController();
  var text = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initParam();
  }
  initParam()async{
    var name = await LocalStorage.get(Config.SaVE_TEST);
    controller.value = new TextEditingValue(text: name ?? '');
  }




  _save()async{
    if(text.length<1){
      showToast("请输入内容");
    }else{
      await LocalStorage.save(Config.SaVE_TEST, text);
      showToast('保存成功');
    }

  }
  _clear()async{
    controller.value = new TextEditingValue(text:'');
    await LocalStorage.remove(Config.SaVE_TEST);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text('本地化储存'),
      ),
      body: new GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              CPFTextfieldPage(
                hintText: '请输入帐号',
                iconData: Icons.home,
                onChanged: (String value) {
                  text = value;
                },
                controller: controller,
              ),
          RaisedButton(
            child: Text("保存"),
            onPressed: () => _save(),
          ),
              RaisedButton(
                child: Text("清除"),
                onPressed: () => _clear(),
              ),
            ],
          ),
        )
      ),
    );
  }
}
