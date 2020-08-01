import 'package:flutter/material.dart';
import 'package:callstatus/handler/constants.dart';
class Settings extends StatelessWidget {
  const Settings({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
appBar: AppBar(
  title:Text("Setting"),
),
body: MyAvailableSettings(),
    );
  }
}

class MyAvailableSettings extends StatelessWidget {
  const MyAvailableSettings({Key key}) : super(key: key);

  
  @override
  Widget build(BuildContext context) {
    int length=MyConstants.settingsMenu.length;
    return ListView.builder(itemCount:length,itemBuilder: (context,index){
      var menu=MyConstants.settingsMenu[index];
      if(menu.name==MyConstants.seperator)
      return Divider();
      return ListTile(
        title: Text(menu.name),
        subtitle: Text(menu.description),
        leading: CircleAvatar(
          child:Icon(menu.iconData)
        ),
      );
    });
  }
}
