 import 'package:flutter/material.dart';
 


 showBottomDialog(BuildContext context,content) {
    return   showModalBottomSheet(
barrierColor: Color.fromARGB(1, 0, 0, 0),
backgroundColor: Color.fromARGB(180, 255, 255, 255),
     elevation: 8,
     context: context, builder: (context){
      return Container(
        height: 230,
        child:Stack(
        children: <Widget>[
Align(
  alignment: Alignment.topRight,
  child: IconButton(icon: Icon(Icons.close),
  iconSize: 30,
  color: Colors.black87,
  onPressed: ()=>Navigator.pop(context),),

),
Column(children: <Widget>[
SizedBox(height: 10,),
Container(
height: 220,
            
            child: Center(child: content,
),
 

)

],),

        ],
            
          ));
    });
  }
