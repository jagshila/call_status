import 'package:flutter/material.dart';
class MyConstants{
 static const String settings="Settings";
 static const String logout="Logout";
 static const String clearRecent="Clear Recent";
 static const String clearPreset="Clear Preset";
 static const String newStatus="New Status";
 static const String feedback="Feed Back";
static const String privacyPolicy="Terms and Privacy Policy";
static const String appInfo="App Info";
static const String seperator="x__x";
static const String invite="Invite a friend";

 static const List<String> popUpMenu=[
  newStatus,
  clearPreset,
  clearRecent,
  settings,
  logout
 ];


 static const List<SettingMenuItem> settingsMenu=[
    SettingMenuItem(logout,Icons.subdirectory_arrow_right,"To logout for changing the number"),
    SettingMenuItem(seperator,Icons.ac_unit,"Dummy"),

 SettingMenuItem(clearRecent,Icons.recent_actors,"Clear recent checks"),
 SettingMenuItem(clearPreset,Icons.chat,"Reset the preset dialogs"),
 SettingMenuItem(feedback,Icons.feedback,"Feedbacks are always welcomed"),
 SettingMenuItem(privacyPolicy,Icons.info_outline,"Terms and Privacy Policy"),
SettingMenuItem(appInfo,Icons.info,"Information about app"),
SettingMenuItem(seperator,Icons.ac_unit,"Dummy"),
SettingMenuItem(invite,Icons.accessibility,"Invite a friend"),




 ];
}

class SettingMenuItem{
final String name;
final IconData iconData;
final String description;
const SettingMenuItem(this.name,this.iconData,this.description);
}