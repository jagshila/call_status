
import 'package:callstatus/handler/loginStateChecker.dart';
import 'package:flutter/material.dart';
//import 'package:url_launcher/url_launcher.dart';
//import 'package:shared_preferences/shared_preferences.dart';
//import 'DisplayOverlay1.dart';
import 'package:callstatus/ui/myHomePage.dart';
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
          primarySwatch: Colors.cyan,
        ),
     home:LoginStateChecker()

    );

}


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
}