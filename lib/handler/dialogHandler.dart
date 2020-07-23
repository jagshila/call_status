import 'package:flutter/material.dart';
class MyDialog{
 String title, status, phone, imageLoc;
   int bgColor,titleColor,statusColor;
 // final Image overlayImage;
   bool isLocalImage,isEditing;
   double sidePadding, topPadding;
   int timeToDisplay;

  MyDialog(this.title,this.status,this.phone,this.imageLoc,
  this.bgColor,this.titleColor,this.statusColor,this.isLocalImage,
  this.isEditing,this.sidePadding,this.topPadding, this.timeToDisplay);


Map<String,dynamic> toData() {
        Map<String,dynamic> data = {
        'title': title,
        'status': status,
        'imageLoc':imageLoc,
        'bgColor':bgColor,
        'titleColor':titleColor,
        'statusColor':statusColor,
        'isLocalImage':isLocalImage,
        "sidePadding":sidePadding,
        "topPadding":topPadding,
        "timeToDisplay":timeToDisplay
        };
return data;
      }


   static MyDialog   getInitialDialog()
      {
MyDialog myDialog = new MyDialog("My Title", "My current call status", "00", "assets/images/gun.png", Colors.orange.value, Colors.black87.value, Colors.black38.value, true, false, 0, 0,3600);
return myDialog;
      }

         static MyDialog   getNotInstalledDialog()
      {
MyDialog myDialog = new MyDialog("Sorry", "This person has not installed Call Status app, ask this person to install..", "00", "assets/images/gun.png", Colors.orange.value, Colors.black87.value, Colors.black38.value, true, false, 0, 0,0);
return myDialog;
      }

}

