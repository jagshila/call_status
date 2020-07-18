import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'bottomDialog.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'roundedButton.dart';
import 'colors.dart';
import '../ui/background.dart';
class Consts {
  Consts._();

  static const double padding = 16.0;
  static const double avatarRadius = 40;
}

class CustomDialog extends StatelessWidget {
  final String title, status, phone;
  final Color bgColor,titleColor,statusColor;
  final Image overlayImage;
  final BuildContext dialogContext;
 // final Image overlayImage;
  final bool isLocalImage,isEditing;
  final double sidePadding, topPadding;

  CustomDialog({
    this.isEditing,
    this.phone,
    this.title,
    this.status,
    this.overlayImage,
    this.isLocalImage,
    this.bgColor,
    this.titleColor,
    this.statusColor,
    this.dialogContext,
    this.sidePadding,
this.topPadding
  });

  @override
  Widget build(BuildContext context){
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Consts.padding),
      ),
      elevation: 1.0,
      backgroundColor:bgColor,
      child: dialogContent(context),

    );

  }



 dialogContent(BuildContext context) {

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
            padding: EdgeInsets.only(top: topPadding,left: sidePadding,right: sidePadding),
            child: Column(
              mainAxisSize: MainAxisSize.min, // To make the card compact
              children: <Widget>[
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w700,
                    color: titleColor
                  ),
                ),
                SizedBox(height: 16.0),
                Text(
                  status,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color:statusColor
                  ),
                ),
                SizedBox(height: 24.0),
                Align(
                  alignment: Alignment.bottomRight,
                  child: IconButton(
                    onPressed: () {
                      if(!isEditing)
                     {_makePhoneCall(phone);
                      Navigator.of(context).pop(); }// To close the dialog
                    },
                    icon: Icon(Icons.call),
                    iconSize: 40,
                    color: titleColor,
                      
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


main()=>runApp(MaterialApp(

  home:MyDialogEditor()
));

class MyDialogEditor extends StatefulWidget {
  MyDialogEditor({Key key}) : super(key: key);

  @override
  _MyDialogEditorState createState() => _MyDialogEditorState();
}

class _MyDialogEditorState extends State<MyDialogEditor> {
String name,status,imageLoc,phone;
bool isLocalImage,isEditing;
Color bgColor,titleColor,statusColor;
double sidePadding,topPadding;

@override
  void initState() {
    super.initState();
name="Playing PUBG";
status="I am playing right now, call me after sometime...";
phone="9850477230";
imageLoc="assets/images/gun.png";
isLocalImage=true;
bgColor= Colors.cyan;
titleColor= Colors.black87;
statusColor= Colors.black45;
isEditing=true;
sidePadding=0;
topPadding=0;
  }

  @override
  Widget build(BuildContext context) {

    Image overlayImage =  isLocalImage?Image.asset(imageLoc,
):Image.network(imageLoc,
  fit: BoxFit.fill,

);
    return      Scaffold(

    body:Stack(
          children: <Widget>[
            Opacity(
              opacity: 1,
              child:Background()),
    
 Column(
   children: <Widget>[
     Container(
       height: MediaQuery.of(context).size.height/2.2,
       child: SingleChildScrollView(
              child: CustomDialog(
          phone:phone,
          title: name,
          status: status,
         overlayImage: overlayImage,
isLocalImage: isLocalImage,
bgColor: bgColor,
titleColor: titleColor,
statusColor: statusColor,
isEditing: isEditing,
sidePadding: sidePadding,
topPadding: topPadding,
),
       ),
     ),
     Expanded(
            child: SingleChildScrollView(
        //controller: controller,
        child: Column(
          children:[
createInputWidget(buildTitle(context)),


createInputWidget(buildStatus(context)),

createInputWidget(buildBackground(context)),
         

createInputWidget(
Row(children: <Widget>[
       Text("Top Margin "),
        Expanded(
            child: Slider(
              min: 0,
              max: 100,
              value: topPadding,
              onChanged: (value) {
                setState(() {
                  topPadding = value;
                });
              },
            ),
        ),

],),
),


createInputWidget(
Row(children: <Widget>[
       Text("Side Margin"),
        Expanded(
            child: Slider(
              min: 0,
              max: 100,
              value: sidePadding,
              onChanged: (value) {
                setState(() {
                  sidePadding = value;
                });
              },
            ),
        ),

],),
),


       
          ]),
),
     ),
 
          GestureDetector(
           onTap:(){
                                       FocusScope.of(context).requestFocus(FocusNode());

             showDialog(context: context,
         child: CustomDialog(
        phone:phone,
        title: name,
        status: status,
       overlayImage: overlayImage,
isLocalImage: isLocalImage,
bgColor: bgColor,
titleColor: titleColor,
statusColor: statusColor,
isEditing: isEditing,
sidePadding: sidePadding,
topPadding: topPadding,
)
         );},
child:roundedRectButton("Preview", signInGradients, false),
         ),
 
   ],
 ),


])
  )
    ;
  }

createInputWidget(inputWidget){
 return Padding(
              padding: EdgeInsets.only(right: 10, bottom: 10),
              child: Container(
                width: MediaQuery.of(context).size.width - 10,
                child: Material(
                  elevation: 10,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(0),
                          topRight: Radius.circular(30))),
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: 40, right: 20, top: 10, bottom: 10),
                    child: inputWidget,
                  ),
                ),
              ),
            );
}

  Row buildBackground(BuildContext context) {
    return 
    
    Row(children: <Widget>[


SizedBox(width: MediaQuery.of(context).size.width-110,
child:
TextField(
decoration: InputDecoration(
  hintText: "Background Image"
),
onChanged: (value)=> setState((){
imageLoc=value;
isLocalImage=false;
})

)),
GestureDetector(
onTap: () { changeBgColor();},
child:
CircleAvatar(
backgroundColor: bgColor,

)
)
,
],);
  }

  Row buildStatus(BuildContext context) {
    return Row(children: <Widget>[
SizedBox(width: MediaQuery.of(context).size.width-110,
child:
TextField(
decoration: InputDecoration(
  hintText: "Status"
),
onChanged: (value)=> setState((){
status=value;
}),

)),

GestureDetector(
onTap: () {changeStatusColor();},
child:
CircleAvatar(

backgroundColor: statusColor,
)),
],);
  }

  Row buildTitle(BuildContext context) {
    return Row(children: <Widget>[

SizedBox(width: MediaQuery.of(context).size.width-110,
child:
TextField(

decoration: InputDecoration(
  hintText: "Title"
),
onChanged: (value)=> setState((){
name=value;
}),
)),
GestureDetector(
onTap: () { changeTitleColor();},
child:
CircleAvatar(

backgroundColor: titleColor,
)
),
],)
;


  }


    void changeBgColor() async {
    showBottomDialog(context,
      MaterialColorPicker(
        colors: fullMaterialColors,
        selectedColor: bgColor,
                onColorChange: (color) => setState(() { bgColor = color;
                }),

 
      ),
    );
  }


    void changeTitleColor() async {
    showBottomDialog(context,
      MaterialColorPicker(
        colors: fullMaterialColors,
        selectedColor: titleColor,
                onColorChange: (color) => setState(() { titleColor = color;
                }),

 
      ),
    );
  }



  
    void changeStatusColor() async {
    showBottomDialog(context,
      MaterialColorPicker(
        colors: fullMaterialColors,
        selectedColor: statusColor,
                onColorChange: (color) => setState(() { statusColor = color;
                }),

 
      ),
    );
  }


}


