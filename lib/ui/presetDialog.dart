import 'package:flutter/material.dart';
import 'package:callstatus/ui/mainContainer.dart';
import 'package:callstatus/uiComponents/dialog.dart';
import 'package:callstatus/ui/myDialogEditor.dart';
import 'package:callstatus/handler/prefHandler.dart';
import 'package:callstatus/handler/presetDialoghandler.dart';

class PresetDialogDisplay extends StatefulWidget {
  PresetDialogDisplay({Key key}) : super(key: key);

  @override
  _PresetDialogDisplayState createState() => _PresetDialogDisplayState();
}

class _PresetDialogDisplayState extends State<PresetDialogDisplay> {
  @override
  void initState() { 
    super.initState();
    getArrayFromPref("presetDialogs").then((array) {
if(array==null)
setState(() {
  PresetDialogs.resetAllPresetDialogs();

});
else
      setState(() {
      PresetDialogs.presetStrings=array;
          });

    }
    );
  }

  @override
  Widget build(BuildContext context) {
    return MainContainer(
                   content: 
                       
               
               Column(
                 children: <Widget>[
                   Container(
                                           child: Text("Select Preset to edit",
                     style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                     ),
                   ),
                   Expanded(
                                       child: ListView.builder(
                       itemCount: PresetDialogs.presetStrings.length,
                       itemBuilder: (context,index){
return GestureDetector(
  
  child: CustomDialog(myDialog:PresetDialogs().presetStringToDialogUsingIndex(index)),
  onTap: () { 
    PresetDialogs.selectedIndex=index;
    Navigator.push(context, MaterialPageRoute(builder:(context)=>MyDialogEditor(presetIndex: index,myDialog: PresetDialogs().presetStringToDialogUsingIndex(index),) ));}
  );

                     }),
                   ),
                 ],
               )
               
               );
  }
}

/*
main()=>runApp(MaterialApp(
home: PresetDialogDisplay(),

));
*/