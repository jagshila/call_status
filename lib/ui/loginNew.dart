import 'package:callstatus/uiComponents/myTimerDisplay.dart';
import 'package:flutter/material.dart';
import 'package:callstatus/handler/firebaseLoginHandler.dart';
import 'package:callstatus/ui/mainContainer.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:callstatus/handler/prefHandler.dart';




class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  double unitSize;
  String title,_value,phoneNo;
  bool isPhone;
  GlobalObjectKey scaffoldKey = new GlobalObjectKey(Scaffold);
TextEditingController textEditingController;
  final firebaseLogin = new FirebaseLoginHandler();
int timeForResend;
String timeInString;
Timer timer;
  @override
  void initState() {
        super.initState();
    phoneNo="";
isPhone=true;
title="Enter your phone number";
textEditingController = TextEditingController();
      _value="+91";

timeForResend=0;
  timer=Timer.periodic(Duration(seconds:1), (timer) {decreaseTimer();});





  }
  

       @override
   void setState(fn) {
    if(mounted){
      super.setState(fn);
    }
  }


  @override
  Widget build(BuildContext context) {
    unitSize=MediaQuery.of(context).size.width/20;

    return WillPopScope(
      onWillPop: ()=>showDialog(context: context, child: AlertDialog(
        title:Text("Are you sure?"),
        content:Text("Do you want to exit?"),
        actions:[
FlatButton(child: Text("Cancel"),onPressed: () => Navigator.pop(context),),
FlatButton(child: Text("Exit"),onPressed: () => SystemNavigator.pop(),),

        ]

      )),
          child: MainContainer(
            content: Scaffold(
              key:scaffoldKey,
          appBar: AppBar(
            elevation: 0,
            centerTitle: true,
            backgroundColor: Colors.white,

            title: Text(title, style: TextStyle(color: Colors.teal),),

          ),
          body:isPhone?loadPhone():loadOtp()
        ),
      ),
    );
  }



  loadPhone(){
return Container(
  padding: EdgeInsets.all(unitSize),
child: Column(
  children: [
    Text(
      "Call Status will send an SMS message to verify your phone number.",
            textAlign:TextAlign.center,
            style: TextStyle(fontSize: 18),

      ),

      Padding(
        padding: EdgeInsets.only(left:2*unitSize, right:2*unitSize, top: 8, bottom: 8),
        child: Row(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(right:unitSize),
              child: DropdownButton<String>(

          items: <String>['+91', '+1'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );

          }).toList(),

          onChanged: (value) {
                setState(() {
                  _value = value;
                });

          },
          value: _value,
      underline: Container(

      ),
        style: TextStyle(
          color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold),
        isDense: true,
        ),
            ),
        Expanded(
            child: TextField(
          autofocus: true,
          keyboardType: TextInputType.number,
          style: TextStyle(
            letterSpacing: 2,
              fontSize: 18,
              fontWeight: FontWeight.bold),
          controller: textEditingController,
          decoration: InputDecoration(
            
              hintText: "Mobile Number",
              hintStyle: TextStyle(color: Colors.grey, fontSize: 18)),
        ))
          ],
        ),
      ),

      Text("Carrier SMS charges may apply.",
      style: TextStyle(color: Colors.grey, fontSize: 14),
      ),

      Expanded(
        child: Container(),
      ),

FlatButton(
                padding: EdgeInsets.all(15),
                color: Colors.green,
                child: Text("NEXT",
                style: TextStyle(color:Colors.white, fontSize: 15),
                ),
              onPressed: ()  {

                if(textEditingController.text.length<10)
                {
showDialog(context: context,child:
AlertDialog(
  title: Text("Invalid Number!"),
  content: Text("Please enter a valid mobile number to continue..."),
  actions: <Widget>[
    FlatButton(
      onPressed: () => Navigator.pop(context),
      child: Text("OK"),
    )
  ],
)
);

                }
                else{
                getMobileNumber();
saveStringPref("countryCode", _value);
showDialog(context: context,child:
AlertDialog(
title: RichText(
  
  text:TextSpan(
    style: TextStyle(color: Colors.black, fontSize: 20),
  text:"We will verify the phone number:\n\n",
  children: [
    TextSpan(text: phoneNo, style: TextStyle(fontWeight: FontWeight.w500)),
    TextSpan(text:"\n\nIs this OK, or would you like to edit this number?")
  ]
  )
),

actions: [
  FlatButton(
    onPressed: (){
Navigator.pop(context);
    },
    child: Text("EDIT", style: TextStyle(color:Colors.teal,fontSize: 18),),

  ),
 
  
    FlatButton(
    onPressed: (){
      firebaseLogin.verifyPhoneNumber(scaffoldKey.currentContext, getMobileNumber());
      textEditingController.clear();
    Navigator.pop(context);
      setState(() {
        isPhone=false;
        timeForResend=180;
      });

    },
    child: Text("OK", style: TextStyle(color:Colors.teal,fontSize: 18),),

  )

],
)

);

              }
              
              },
              ),
  ]
),

);

  }


  loadOtp(){
    title="Verify "+ phoneNo;
return Container(

  padding: EdgeInsets.all(unitSize),

child: Column(

  children: [

    Text(

      "Waiting to automatically detect an SMS sent to "+phoneNo+".",

            textAlign:TextAlign.center,

            style: TextStyle(fontSize: 18),



      ),



      Padding(

        padding: EdgeInsets.only(left:unitSize, right:unitSize, top: 8, bottom: 8),

        child:  SizedBox(

          width: 140,

                  child: TextField(

                    autofocus: true,

            keyboardType: TextInputType.number,

            textAlign: TextAlign.center,

            style: TextStyle(

              

              letterSpacing: 8,

                fontSize: 20,

                fontWeight: FontWeight.bold),

            controller: textEditingController,

            decoration: InputDecoration(

                hintText: "______",

                hintStyle: TextStyle(color: Colors.grey, fontSize: 20)),

          ),

        ))

         

      ,



      Text("Enter code received ",

      style: TextStyle(color: Colors.grey, fontSize: 14),

      ),

      ListTile(

        leading: Icon(Icons.message),

        title: Text("Resend SMS"),

        trailing: Text(timeInString),
onTap: timeForResend<1
      ? () {
      firebaseLogin.verifyPhoneNumber(scaffoldKey.currentContext, phoneNo.replaceAll(" ", ''));
        setState(() {
          timeForResend=600;
        });
print("Resend initiated !! 1! !!!!!!!");
        }
      : null, 
        

      ),

      ListTile(

        leading: Icon(Icons.phone),

        title: Text("Change Number"),

        onTap: (){

          setState(() {

            isPhone=true;

          });

        },

        

      ),

      Expanded(

        child: Container(),

      ),



FlatButton(

                padding: EdgeInsets.all(15),

                color: Colors.green,

                child: Text("Verify",

                style: TextStyle(color:Colors.white, fontSize: 15),

                ),

              onPressed: () {
if(textEditingController.text.length<6)
                {
showDialog(context: context,child:
AlertDialog(
  title: Text("Invalid Code!"),
  content: Text("Please enter 6 digit code to continue..."),
  actions: <Widget>[
    FlatButton(
      onPressed: () => Navigator.pop(context),
      child: Text("OK"),
    )
  ],
)
);

                }
                else{

                            firebaseLogin.signInWithPhoneNumber(scaffoldKey.currentContext, getOTP());

                                showDialog(
                                    barrierDismissible: false,
                                context: context,

                                builder: (BuildContext context) {

                                  return Row(

                                    mainAxisSize: MainAxisSize.min,

                                    mainAxisAlignment: MainAxisAlignment.center,

                                    children: <Widget>[

                                      CircularProgressIndicator(

                                      )

                                    ],

                                  );

                                },

                              );



  }
  },

              ),

  ]

),



);



  }


  getMobileNumber(){
    phoneNo=_value+" "+textEditingController.text;
    return _value+textEditingController.text;
  }

  getOTP(){
    return textEditingController.text;
  }

decreaseTimer(){
  if(timeForResend>1)
  {
      String twoDigits(int n) => n.toString().padLeft(2, "0");
    setState(() {
          timeForResend--;
          timeInString="${twoDigits((timeForResend/60).floor())}:${twoDigits(timeForResend.remainder(60))}";
    });

  }
  else if(timeForResend!=-1){
          timeForResend=-1;
  setState(() {
      timeInString="";
  });}
}

@override
  void dispose() {
timer.cancel();
super.dispose();
  }

}






class TermsAndConditionsPage extends StatelessWidget {
  TermsAndConditionsPage({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double unitSize=MediaQuery.of(context).size.width/20;
    return Scaffold(
          body: Container(
        child: 
        Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top:2*unitSize,bottom: 2*unitSize),
              child: Text("Welcome to\nCall Status",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: unitSize*2,fontWeight: FontWeight.w500, color: Colors.teal), 
              ),
            ),
            Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(unitSize),
                          child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                                  color: Colors.green,

                ),
              ),
                        ),
            ),
            Padding(
              padding: EdgeInsets.all(unitSize),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
              
                text: "Read our ",
            //    style: DefaultTextStyle.of(context).style,
            style: TextStyle(color: Colors.black),
                children:[
                  TextSpan(text:"Privacy Policy",style:TextStyle(color:Colors.blue)),
                  TextSpan(text:". Tap \"Agree and continue\" to accept the "),
                  TextSpan(text:"Terms of Service", style:TextStyle(color:Colors.blue)),
                  TextSpan(text:".")
                ]
              )),
            ),

            Padding(
              padding: EdgeInsets.only( bottom:unitSize, left:unitSize, right:unitSize),
              child: SizedBox(
                width: unitSize*16,
                            child: FlatButton(
                  padding: EdgeInsets.all(15),
                  color: Colors.green,
                  child: Text("AGREE AND CONTINUE",
                  style: TextStyle(color:Colors.white, fontSize: 15),
                  ),
                onPressed: (){
                  Navigator.pop(context);
Navigator.push(
  context,
  MaterialPageRoute(builder:(context)=>LoginPage())
);


                },
                ),
              ),
            ),

          ],
        )
      ),
    );

  }

}






/*
main()=>runApp(MaterialApp(
  theme:ThemeData(
          primarySwatch: Colors.green,
          primaryColor: Colors.teal[800],
                  ),
  home:Scaffold(
    body: TermsAndConditionsPage(),
  )
));*/