import 'package:flutter/material.dart';
import 'firebaseLoginHandler.dart';
import 'package:callstatus/ui/mainContainer.dart';
import 'package:callstatus/ui/login.dart';
import 'package:flutter/services.dart';
import 'package:callstatus/ui/displayAllContacts.dart';


class LoginStateChecker extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);

   


 FirebaseLoginHandler().isUserLoggedIn().then((value) => 
    {    
      

  if(value)
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => DisplayAllContacts()),
  )
  else
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => Login()),
  )
    }
    );


    return 
MainContainer(
  content:   Center(child: 
  
  Column(
  
    mainAxisAlignment: MainAxisAlignment.center,
  
    children:[
  
  CircularProgressIndicator(backgroundColor: Colors.red,),
  
              Text("Checking Login Status", 
  
              style:TextStyle(fontSize: 20)),
  
  ])
  
  ),
);
  }
}