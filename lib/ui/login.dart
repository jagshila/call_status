import 'package:flutter/material.dart';
//import '../uiComponents/roundedButton.dart';
import '../uiComponents/inputWidget.dart';
import '../uiComponents/textLogo.dart';
import 'package:flutter/services.dart';
//import '../uiComponents/colors.dart';
import '../ui/background.dart';
import '../handler/backButton.dart';
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
    child:Scaffold(
      //  resizeToAvoidBottomPadding: false,
     // resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: 
          SingleChildScrollView(child:
          Container(
            height: MediaQuery.of(context).size.height,
            child: 
        Stack(
          children: <Widget>[

              Background(),
    
  
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
          ]
        )
    )
    )
    )
    );
  }

  

}


