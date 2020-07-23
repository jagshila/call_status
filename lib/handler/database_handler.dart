

import 'package:callstatus/handler/dialogHandler.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:callstatus/uiComponents/dialog.dart';
import 'package:callstatus/handler/firebaseLoginHandler.dart';
class FirestoreHandler{

  saveFireStoreData(data){
    data["timeToEnd"]=Timestamp.now().seconds+data["timeToDisplay"];
    data.remove("timeToDisplay");
    String phone=FirebaseLoginHandler.phone;
 Firestore.instance
            .collection('status')
            .document(phone).setData(data);
  }

 void  getFirestoreData( context, phone) async{
         return Firestore.instance
            .collection('status')
            .document(phone)
            .get()
            .then((DocumentSnapshot ds){

//print(ds.data);
              if(ds.exists)
{
Map<String,dynamic> data =  ds.data;

int timeToDisplay=data["timeToEnd"]-Timestamp.now().seconds;
if(timeToDisplay<0)
timeToDisplay=0;
print(timeToDisplay.toString());
Navigator.pop(context);
  showDialog(
      context: context,
      builder: (BuildContext context) => CustomDialog(
       myDialog: 
        new MyDialog(data["title"], data["status"], phone, data["imageLoc"], data["bgColor"], data["titleColor"],
         data["statusColor"], data["isLocalImage"], false, data["sidePadding"], data["topPadding"],timeToDisplay)
 
      ),
    );
}
else
{
  Navigator.pop(context);

showDialog(context: context,  builder: (BuildContext context) => CustomDialog(
       myDialog: MyDialog.getNotInstalledDialog()));
}
 //return data;
            });
  }


}

/*
main()=>runApp(MaterialApp(home: Scaffold(
body:
Container(
  child:DisplayDataFromFireStore()
)


),));


class DisplayDataFromFireStore extends StatefulWidget {
  DisplayDataFromFireStore({Key key}) : super(key: key);

  @override
  _DisplayDataFromFireStoreState createState() => _DisplayDataFromFireStoreState();
}

class _DisplayDataFromFireStoreState extends State<DisplayDataFromFireStore> {
String _data;

  @override
  void initState() {
    super.initState();
_data="Data from firestore will appear here!";
  }
  @override
  Widget build(BuildContext context) {
    return Column(
       children:<Widget>[
          Text(_data),
          RaisedButton(onPressed: () {
            FirestoreHandler().getFirestoreData(context,"00").then((data){
              setState(() {
print(data);
                _data="Firestore invoked:"+data["Title"]+"\n";
data.forEach((key, value) {
  _data+=key+":"+value+"\n";
});
             
              });
            });
          },)
       ],

    );
  }
}
*/
