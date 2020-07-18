import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<bool> onBackPressed(context) {
  return showDialog(
    context: context,
    
    builder: (context) => new AlertDialog(
      elevation: 2,
      backgroundColor: Colors.white,
      contentTextStyle: TextStyle(color: Colors.cyan,fontWeight: FontWeight.bold),
      titleTextStyle: TextStyle(color:Colors.cyan,fontWeight: FontWeight.w800),
      shape: Border.all(width:8,color:Colors.deepOrange, style: BorderStyle.solid),
actionsPadding: EdgeInsets.all(10),
      title: new Text('Are you sure?'),
      content: new Text('Do you want to exit an App'),
      actions: <Widget>[
        new GestureDetector(
          onTap: () => Navigator.of(context).pop(false),
          child: Text("NO"),
        ),
        SizedBox(height: 16),
        new GestureDetector(
          onTap: () => SystemNavigator.pop(),
          child: Text("YES"),
        ),
      ],
    ),
  ) ??
      false;
}