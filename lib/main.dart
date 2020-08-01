
import 'dart:ui';

import 'package:callstatus/handler/loginStateChecker.dart';
import 'package:flutter/material.dart';
//import 'package:callstatus/ui/displayAllContacts.dart';
//import 'package:url_launcher/url_launcher.dart';
//import 'package:shared_preferences/shared_preferences.dart';
//import 'DisplayOverlay1.dart';
void main() => runApp(MyApp());
String globalContactNo="";
class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {


    return myMaterialApp();
    

  }
}


Widget myMaterialApp()
{
return     MaterialApp(
        title: 'Call Status',
        theme: ThemeData(
          primarySwatch: Colors.green,
          primaryColor: Colors.teal[800],


        ),
     home:LoginStateChecker()

    );

}

/*
class TryTest extends StatelessWidget {
 // const tryTest({Key key}) : super(key: key);
var x=Colors.green;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: 
      Container(
        color: x[800],
        child:SizedBox(width:100,height:100)
      )
      ,
    );
  }
}*/