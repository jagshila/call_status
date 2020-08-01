
import 'package:callstatus/handler/loginStateChecker.dart';
import 'package:callstatus/ui/displayAllContacts.dart';
import 'package:callstatus/ui/login.dart';
import 'package:callstatus/ui/loginNew.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:callstatus/ui/mainContainer.dart';
class FirebaseLoginHandler{
String _verificationId;
String _message;
final FirebaseAuth _auth = FirebaseAuth.instance;
static int uiCode;
static int resendingToken=0;
static String phone;

///0->Initiated
///1->Successfully signed in
///2->Code sent
///3->Failed




Future<bool> isUserLoggedIn() async{
  FirebaseUser user;
if ((user = await FirebaseAuth.instance.currentUser()) != null) 
{
  phone = user.phoneNumber;
  return true;}
else
return false;
}


void verifyPhoneNumber(BuildContext context, String phoneNumber) async {
  phone=phoneNumber;
      _message = '';
      uiCode=0;
      print("Checking for "+ phoneNumber);
    final PhoneVerificationCompleted verificationCompleted =
        (AuthCredential phoneAuthCredential) {
          uiCode=1;
      _auth.signInWithCredential(phoneAuthCredential);
        _message = 'Received phone auth credential: $phoneAuthCredential';
        print("PhoneVerificationCompleted "+_message);
        loginSuccessRedirect(context);
phone=phoneNumber;



    };

    final PhoneVerificationFailed verificationFailed =
        (AuthException authException) {
        _message =
        'Phone number verification failed. Code: ${authException.code}. Message: ${authException.message}';
        uiCode=-1;
        print(_message);
    };

    final PhoneCodeSent codeSent =
        (String verificationId, [int forceResendingToken]) async {
          Scaffold.of(context).showSnackBar(const SnackBar(
        content: Text('Please check your phone for the verification code.'),
      ));
      _verificationId = verificationId;
      uiCode = 2;
      resendingToken=forceResendingToken;
      print("Code Sent");
      
    };

    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      _verificationId = verificationId;
    };

   if(resendingToken!=0)
    await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: const Duration(seconds: 5),
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
        forceResendingToken: resendingToken
        );
else
await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: const Duration(seconds: 5),
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
        );

  }

  // Example code of how to sign in with phone.
  void signInWithPhoneNumber(context,String otp) async {
    print("Checking against otp:"+otp);
    final AuthCredential credential = PhoneAuthProvider.getCredential(
      verificationId: _verificationId,
      smsCode: otp,
    );
try{
    final FirebaseUser user =
        (await _auth.signInWithCredential(credential)).user;

    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);

      if (user != null) {
   /*     Firestore.instance
            .collection('status')
            .document(user.phoneNumber).setData({"Display Name":"Ak", "Status":"Free"});*/
            uiCode=1;
        _message = 'Successfully signed in, uid: ' + user.uid;
 loginSuccessRedirect(context);
        print(_message);
   /*     Firestore.instance
            .collection('status')
            .document(user.phoneNumber)
            .get()
            .then((DocumentSnapshot ds) {
print(ds.data);
print(_message);
            });
            */


      } else {
        uiCode=-1;
        _message = 'Sign in failed';
        loginFailedRedirect(context);
      }
      }
      catch(error){
        showDialog(
          barrierDismissible: false,
          context: context, 
        child: AlertDialog(
          title: Column(children:[
            Icon(Icons.error, color: Colors.red,size: 80,),
            Text("Invalid Code!")]),
          content: Text("Click resend SMS to receive code again. Please provide valid code received in SMS."),
          actions: <Widget>[
            FlatButton(child: Text("OK"),
            onPressed: () { Navigator.pop(context);
            Navigator.pop(context);
            }
            )
          ],
        )
        );
        print(error.code);
        print(error.message);        
      }
  }


static void signOut(context)  async{
    await FirebaseAuth.instance.signOut().then((val){
Navigator.pop(context);
Navigator.push(context, MaterialPageRoute(builder: (context) => LoginStateChecker(),));
    });
    
}



void loginSuccessRedirect(context){
            Scaffold.of(context).showSnackBar(const SnackBar(
        content: Text('Sign in successfull.'),
      ));
      Navigator.popUntil(context, (route) => route.isFirst);
      Navigator.pop(context);
Navigator.push(
    context,
   // MaterialPageRoute(builder: (context) => DisplayAllContacts()),
  MaterialPageRoute(builder: (context) => MainContainer2()),
  );
}

void loginFailedRedirect(context)
{
            Scaffold.of(context).showSnackBar(const SnackBar(
        content: Text('Sign in failed. Please try again.'),
      ));
      Navigator.pop(context);
Navigator.push(
    context,
   // MaterialPageRoute(builder: (context) => Login()),

    MaterialPageRoute(builder: (context) => LoginPage()),

  );

}

redirectToPage(){
switch(uiCode){

///0->Initiated
///1->Successfully signed in
///2->Code sent
///-1->Failed

case 1:
//Redirect to Home
break;
case 2: //Code Sent
break;
case -1: //Redirect to Login
break;
default:
//Redirect to login

}

}

}