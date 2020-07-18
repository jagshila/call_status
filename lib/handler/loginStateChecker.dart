import 'package:flutter/material.dart';
import 'firebaseLoginHandler.dart';
import '../ui/background.dart';
import '../ui/login.dart';
import '../ui/myHomePage.dart';
import 'package:flutter/services.dart';


class LoginStateChecker extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);

   


 FirebaseLoginHandler().isUserLoggedIn().then((value) => 
    {    if(value)
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => MyHomePage(title: 'Call Status')),
  )
  else
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => Login()),
  )
    }
    );


    return Scaffold(
      body: 
      Stack(children: <Widget>[
Background(),
Center(child: 
Column(
  mainAxisAlignment: MainAxisAlignment.center,
  children:[
CircularProgressIndicator(backgroundColor: Colors.red,),
            Text("Checking Login Status", 
            style:TextStyle(fontSize: 20)),
])
)
      ],)
    );
  }
}