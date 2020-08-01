import 'package:callstatus/ui/loginNew.dart';
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

   


 FirebaseLoginHandler().isUserLoggedIn().then((value)
    {    
      
Navigator.pop(context);
  if(value)
  Navigator.push(
    context,
  //  MaterialPageRoute(builder: (context) => DisplayAllContacts()),
  MaterialPageRoute(builder: (context)=>MainContainer2())
  );
  else
  Navigator.push(
    context,
  //  MaterialPageRoute(builder: (context) => Login()),
  MaterialPageRoute(builder: (context) => TermsAndConditionsPage(),)
  );
    }
    );


    return 
MainContainer(
  content:   Center(child: 
  
  Column(
  
    mainAxisAlignment: MainAxisAlignment.center,
  
    children:[
  
  CircularProgressIndicator(),
  
              Text("Checking Login Status", 
  
              style:TextStyle(fontSize: 20)),
  
  ])
  
  ),
);
  }
}