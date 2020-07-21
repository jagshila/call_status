import 'package:callstatus/handler/backgroundImageHandler.dart';
import 'package:callstatus/handler/presetDialogHandler.dart';
import 'package:flutter/material.dart';
import 'package:callstatus/uiComponents/bottomDialog.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:callstatus/uiComponents/roundedButton.dart';
import 'package:callstatus/uiComponents/myColors.dart';
import 'package:callstatus/ui/mainContainer.dart';
import 'package:callstatus/uiComponents/dialog.dart';
import 'package:callstatus/handler/dialogHandler.dart';
import 'package:callstatus/handler/database_handler.dart';


class MyDialogEditor extends StatefulWidget {
  final MyDialog myDialog;
  final int presetIndex;
  MyDialogEditor({Key key, this.myDialog,this.presetIndex}) : super(key: key);

  @override
  _MyDialogEditorState createState() => _MyDialogEditorState();
}

class _MyDialogEditorState extends State<MyDialogEditor> {

@override
  void initState() {
    super.initState();
widget.myDialog.isEditing=true;
  }

  @override
  Widget build(BuildContext context) {


    return      MainContainer(

      
    content:
      
    
 SingleChildScrollView(
    child: Container(
      height:MediaQuery.of(context).size.height,
          child: Column(
       children: <Widget>[
         Container(
           height: MediaQuery.of(context).size.height/2.2,
           child: SingleChildScrollView(
                  child: CustomDialog(
   myDialog: widget.myDialog,
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

             

createInputWidget(
Row(children: <Widget>[
           Text("Top Margin "),
            Expanded(
                child: Slider(
                  min: 0,
                  max: 100,
                  value: widget.myDialog.topPadding,
                  onChanged: (value) {
                    setState(() {
                      widget.myDialog.topPadding = value;
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
                  value: widget.myDialog.sidePadding,
                  onChanged: (value) {
                    setState(() {
                      widget.myDialog.sidePadding = value;
                    });
                  },
                ),
            ),

],),
),

createInputWidget(buildBackground(context)),

           
              ]),
),
         ),
   
              Row(
                children: <Widget>[
                  GestureDetector(
                   onTap:(){
                                               FocusScope.of(context).requestFocus(FocusNode());
                     showDialog(context: context,
             child: CustomDialog(
      myDialog: widget.myDialog,
)
             );},
child:roundedRectButton("View", signInGradients,2, false),
             ),              
             
             GestureDetector(
                   onTap:(){
                FocusScope.of(context).requestFocus(FocusNode());
                Navigator.pop(context);
                Navigator.pop(context);

                showDialog(context: context,
             child: CustomDialog(
      myDialog: widget.myDialog,
)
             );
             PresetDialogs().saveDialogToPresetPref(widget.myDialog, widget.presetIndex);
            FirestoreHandler().saveFireStoreData(widget.myDialog.toData());
                  },
child:roundedRectButton("Save", signInGradients,2, false),
             ),
                ],
              ),
   
       ],
   ),
    ),
 ),



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
Padding(
  padding: const EdgeInsets.only(right:8.0),
  child:   FlatButton(
  
    shape: RoundedRectangleBorder(
  
    borderRadius: BorderRadius.circular(18.0),
  
    side: BorderSide(color: Colors.red)
  
  ),
  
  onPressed: () => showBottomDialog(context, MyBackgroundImages(
onChangeImage: changeBgImage,

  )),
  
  child: Text("Background Image"),
  
  ),
)
),
GestureDetector(
onTap: () { changeBgColor();},
child:
CircleAvatar(
backgroundColor: Color(widget.myDialog.bgColor),

)
)
,
],);
  }

  changeBgImage(imageName) {
    setState(() {
widget.myDialog.imageLoc="assets/images/"+imageName;
widget.myDialog.isLocalImage=true;
    });
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
widget.myDialog.status=value;
}),

)),

GestureDetector(
onTap: () {changeStatusColor();},
child:
CircleAvatar(

backgroundColor: Color(widget.myDialog.statusColor),
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
widget.myDialog.title=value;
}),
)),
GestureDetector(
onTap: () { changeTitleColor();},
child:
CircleAvatar(
foregroundColor: Colors.red,
backgroundColor: Color(widget.myDialog.titleColor),
)
),
],)
;


  }


    void changeBgColor() async {
    showBottomDialog(context,
      MaterialColorPicker(
        colors: fullMaterialColors,
        selectedColor: Color(widget.myDialog.bgColor),
                onColorChange: (color) => setState(() { widget.myDialog.bgColor = color.value;
                }),

 
      ),
    );
  }


    void changeTitleColor() async {
    showBottomDialog(context,
      MaterialColorPicker(
        colors: fullMaterialColors,
        selectedColor: Color(widget.myDialog.titleColor),
                onColorChange: (color) => setState(() { widget.myDialog.titleColor = color.value;
                }),

 
      ),
    );
  }



  
    void changeStatusColor() async {
    showBottomDialog(context,
      MaterialColorPicker(
        colors: fullMaterialColors,
        selectedColor: Color(widget.myDialog.statusColor),
                onColorChange: (color) => setState(() { widget.myDialog.statusColor = color.value;
                }),

 
      ),
    );
  }


}
