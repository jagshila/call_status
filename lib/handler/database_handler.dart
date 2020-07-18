
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../uiComponents/dialog.dart';
class FirestoreHandler{

  saveFireStoreData(phone,data){
 Firestore.instance
            .collection('test')
            .document(phone).setData(data);
  }

 Future<Map>  getFirestoreData( context, phone) async{
         return Firestore.instance
            .collection('test')
            .document("00")
            .get()
            .then((DocumentSnapshot ds){
//print(ds.data);

Map<String,dynamic> data =  ds.data;
  showDialog(
      context: context,
      builder: (BuildContext context) => CustomDialog(
        phone:phone,
        title: data["Title"],
        status:data["Subtitle"],
        overlayImage:Image.asset("assets/images/gun.png"),
isLocalImage:true,
bgColor: Colors.cyan,
titleColor:Colors.black87,
statusColor: Colors.black45,
isEditing:false,
sidePadding:0,
topPadding:0,
      ),
    );
 return data;
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