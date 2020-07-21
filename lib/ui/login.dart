import 'package:flutter/material.dart';
//import '../uiComponents/roundedButton.dart';
import 'package:callstatus/uiComponents/inputWidget.dart';
import 'package:callstatus/uiComponents/textLogo.dart';
import 'package:flutter/services.dart';
//import '../uiComponents/colors.dart';
import 'package:callstatus/ui/mainContainer.dart';
import 'package:callstatus/handler/backButton.dart';
class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  //final mobileNoKey = GlobalKey<_InputWidgetMobileState>();

  TextEditingController textEditingController =new TextEditingController();
  @override
  void initState() {
        super.initState();

    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
  
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
    onWillPop: ()=>onBackPressed(context),
    child:MainContainer(
      //  resizeToAvoidBottomPadding: false,
     // resizeToAvoidBottomInset: false,
        content: 
          SingleChildScrollView(child:
          Container(
            height: MediaQuery.of(context).size.height,
            child: 
  
    
  
        Column(
          children: <Widget>[
            ///holds email header and inputField
               Padding(
           padding:
              EdgeInsets.only(top: MediaQuery.of(context).size.height / 6),
        ),
            TextLogo(),
            InputWidgetMobile(),

            Padding(
              padding: EdgeInsets.only(bottom: 30),
            ),
                               //     roundedRectButton("Create an Account", signUpGradients, false),

                        Padding(
                          padding:EdgeInsets.all(20),
                          child:Text("By registering you agree \nto accept the terms of use and privacy policy.",
                          style: TextStyle(color: Color(0xFFA0A0A0),
                                fontSize: 12),
                                textAlign: TextAlign.center,
                                )),
           // roundedRectButton("Let's get Started", signInGradients, false),
          ],
        
    )
       
    )
    )
    )
    );
  }

  

}


