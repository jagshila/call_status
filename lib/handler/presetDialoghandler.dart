import 'package:flutter/material.dart';
import 'package:callstatus/handler/dialogHandler.dart';
import 'package:callstatus/handler/firebaseLoginHandler.dart';
import 'package:callstatus/handler/prefHandler.dart';

class PresetDialogs{
//static List<MyDialog> presetDialogs=[];
static bool isInitiated=false;
static int selectedIndex;
static List<String> presetStrings;


static resetAllPresetDialogs()
{
  presetStrings=[];
  if(!isInitiated)
  {
    isInitiated=true;
String presetString;
presetString = "Driving"+"/-1-/"+ "I am driving right now. Please Call me after some time."+"/-1-/"+ "assets/images/1.png"+"/-1-/"+ Colors.orange.value.toString()+"/-1-/"+ Colors.purple.value.toString()+"/-1-/"+ Colors.amber.value.toString()+"/-1-/"+(true).toString()+"/-1-/"+ (0).toString()+"/-1-/"+ (0).toString()+"/-1-/"+(3600).toString();
presetStrings.add(presetString);
presetString = "Sleeping"+"/-1-/"+ "I am sleeping right now. Please Call me after some time."+"/-1-/"+ "assets/images/1.png"+"/-1-/"+ Colors.orange.value.toString()+"/-1-/"+ Colors.purple.value.toString()+"/-1-/"+ Colors.amber.value.toString()+"/-1-/"+(true).toString()+"/-1-/" + (0).toString()+"/-1-/"+ (0).toString()+"/-1-/"+(3600).toString();
presetStrings.add(presetString);
presetString = "Studying"+"/-1-/"+ "I am studying right now. Please Call me after some time."+"/-1-/"+ "assets/images/1.png"+"/-1-/"+ Colors.orange.value.toString()+"/-1-/"+ Colors.purple.value.toString()+"/-1-/"+ Colors.amber.value.toString()+"/-1-/"+(true).toString()+"/-1-/" + (0).toString()+"/-1-/"+ (0).toString()+"/-1-/"+(3600).toString();
presetStrings.add(presetString);
presetString = "Working"+"/-1-/"+ "I am working right now. Please Call me after some time."+"/-1-/"+ "assets/images/1.png"+"/-1-/"+ Colors.orange.value.toString()+"/-1-/"+ Colors.purple.value.toString()+"/-1-/"+ Colors.amber.value.toString()+"/-1-/"+(true).toString()+"/-1-/" + (0).toString()+"/-1-/"+ (0).toString()+"/-1-/"+(3600).toString();
presetStrings.add(presetString);
presetString = "Presentaion"+"/-1-/"+ "I am attending presentation right now. Please Call me after some time."+"/-1-/"+ "assets/images/1.png"+"/-1-/"+ Colors.orange.value.toString()+"/-1-/"+ Colors.purple.value.toString()+"/-1-/"+ Colors.amber.value.toString()+"/-1-/"+(true).toString()+"/-1-/" + (0).toString()+"/-1-/"+ (0).toString()+"/-1-/"+(3600).toString();
presetStrings.add(presetString);
presetString = "Travelling"+"/-1-/"+ "I am travelling right now. Please Call me after some time."+"/-1-/"+ "assets/images/1.png"+"/-1-/"+ Colors.orange.value.toString()+"/-1-/"+ Colors.purple.value.toString()+"/-1-/"+ Colors.amber.value.toString()+"/-1-/"+(true).toString()+"/-1-/" + (0).toString()+"/-1-/"+ (0).toString()+"/-1-/"+(3600).toString();
presetStrings.add(presetString);
presetString = "Quiz"+"/-1-/"+ "I am solving online quiz right now. Please Call me after some time."+"/-1-/"+ "assets/images/1.png"+"/-1-/"+ Colors.orange.value.toString()+"/-1-/"+ Colors.purple.value.toString()+"/-1-/"+ Colors.amber.value.toString()+"/-1-/"+(true).toString()+"/-1-/" + (0).toString()+"/-1-/"+ (0).toString()+"/-1-/"+(3600).toString();
presetStrings.add(presetString);
presetString = "Gaming"+"/-1-/"+ "I am playing onlinegame right now. Please Call me after some time."+"/-1-/"+ "assets/images/1.png"+"/-1-/"+ Colors.orange.value.toString()+"/-1-/"+ Colors.purple.value.toString()+"/-1-/"+ Colors.amber.value.toString()+"/-1-/"+(true).toString()+"/-1-/" + (0).toString()+"/-1-/"+ (0).toString()+"/-1-/"+(3600).toString();
presetStrings.add(presetString);
presetString = "Meeting"+"/-1-/"+ "In a metting right now. Please Call me after some time."+"/-1-/"+ "assets/images/1.png"+"/-1-/"+ Colors.orange.value.toString()+"/-1-/"+ Colors.purple.value.toString()+"/-1-/"+ Colors.amber.value.toString()+"/-1-/"+(true).toString()+"/-1-/" + (0).toString()+"/-1-/"+ (0).toString()+"/-1-/"+(3600).toString();
presetStrings.add(presetString);
}

saveArrayToPref("presetDialogs", presetStrings);
}

MyDialog presetStringToDialog(String presetString)
{
String phone = FirebaseLoginHandler.phone;
var params = presetString.split("/-1-/");

MyDialog myDialog = MyDialog(params[0], params[1], phone, params[2], int.parse(params[3]), int.parse(params[4]), int.parse(params[5]), params[6].toLowerCase()=="true", true, double.parse(params[7]), double.parse(params[8]), int.parse(params[9]));
return myDialog;

}


String myDialogToPresetString(MyDialog myDialog){
String presetString="";
String seperator="/-1-/";
presetString+=myDialog.title+seperator;
presetString+=myDialog.status+seperator;
presetString+=myDialog.imageLoc+seperator;
presetString+=myDialog.bgColor.toString()+seperator;
presetString+=myDialog.titleColor.toString()+seperator;
presetString+=myDialog.statusColor.toString()+seperator;
presetString+=myDialog.isLocalImage.toString()+seperator;
presetString+=myDialog.sidePadding.toString()+seperator;
presetString+=myDialog.topPadding.toString()+seperator;
presetString+=(3600).toString();
return presetString;

}

saveDialogToPresetPref(MyDialog myDialog, int index){
      getArrayFromPref("presetDialogs").then((array) {
if(array==null)
  PresetDialogs.resetAllPresetDialogs();
else
PresetDialogs.presetStrings=array;
presetStrings[index]=PresetDialogs().myDialogToPresetString(myDialog);
  saveArrayToPref("presetDialogs", presetStrings);
    });


}

MyDialog presetStringToDialogUsingIndex(int index){
  PresetDialogs.selectedIndex=index;
return presetStringToDialog(presetStrings[index]);
}

savePresetDialogs(int index){


}


/*
static initDialogs()
{
  if(!isInitiated)
  {
isInitiated=true;
MyDialog myDialog;
for(int i=0;i<9;i++)
{
  
}

}
}

*/
}
