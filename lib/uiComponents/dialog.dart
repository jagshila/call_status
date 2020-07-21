import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:callstatus/handler/dialogHandler.dart';

class Consts {
  Consts._();

  static const double padding = 16.0;
  static const double avatarRadius = 40;
}

class CustomDialog extends StatelessWidget {
  final MyDialog myDialog;

  CustomDialog({
    this.myDialog,
  });

  @override
  Widget build(BuildContext context){
 
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Consts.padding),
      ),
      elevation: 1.0,
      backgroundColor:Color(myDialog.bgColor),
      child: dialogContent(context),

    );

  }



 dialogContent(BuildContext context) {
      Image overlayImage =  myDialog.isLocalImage?Image.asset(myDialog.imageLoc,
):Image.network(myDialog.imageLoc,
  fit: BoxFit.fill,

);
    return Stack(
      children: <Widget>[
  
        overlayImage,
        Container(
          padding: EdgeInsets.only(
            top: Consts.avatarRadius + Consts.padding,
            bottom: Consts.padding,
            left: Consts.padding,
            right: Consts.padding,
          ),
          margin: EdgeInsets.only(top: Consts.avatarRadius),
          decoration: new BoxDecoration(
           // color: Colors.amberAccent,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(Consts.padding),
  
          ),
          child: Padding(
            padding: EdgeInsets.only(top: myDialog.topPadding,left: myDialog.sidePadding,right: myDialog.sidePadding),
            child: Column(
              mainAxisSize: MainAxisSize.min, // To make the card compact
              children: <Widget>[
                Text(
                  myDialog.title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w700,
                    color: Color(myDialog.titleColor)
                  ),
                ),
                SizedBox(height: 16.0),
                Text(
                  myDialog.status,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color:Color(myDialog.statusColor)
                  ),
                ),
                SizedBox(height: 24.0),
                Align(
                  alignment: Alignment.bottomRight,
                  child: IconButton(
                    onPressed: () {
                      if(!myDialog.isEditing)
                     {_makePhoneCall(myDialog.phone);
                      Navigator.of(context).pop(); }// To close the dialog
                    },
                    icon: Icon(Icons.call),
                    iconSize: 40,
                    color: Color(myDialog.titleColor),
                      
                  ),
                ),
              ],
            ),
          ),
        ),

      ],
    );
  }


   _makePhoneCall(String phone) async {
  //  if(!isEditing)
     await FlutterPhoneDirectCaller.callNumber(phone);
    //  _launchCaller("tel://"+phone);
   // _launchCaller(phone);
    /*  if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
*/
    /*    final AndroidIntent intent = AndroidIntent(
        action: "action_call",
        data: url, // replace com.example.app with your applicationId
      );
      await intent.launch();
    globalContactNo=phone;

*/
/*    print("Displaying overlay!");
    android_intent.Intent()
      ..setAction(android_action.Action.ACTION_CALL)
      ..setData(Uri(scheme: 'tel', path: phone))
      ..startActivity().catchError((e) => print(e));
    Navigator.pushNamed(context, '/DisplayOverlay');
*/
  }

/*
  _launchCaller(phone) async {
     if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }



  }*/
}

/*
main()=>runApp(MaterialApp(

  home:MyDialogEditor()
));
*/

