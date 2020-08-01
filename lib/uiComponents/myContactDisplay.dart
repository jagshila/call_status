import 'package:flutter/material.dart';
import 'package:callstatus/handler/myContactHandler.dart';
import 'package:callstatus/handler/database_handler.dart';
class MyContactDisplay extends StatefulWidget {
final MyContact contact;
MyContactDisplay({Key key ,this.contact,this.stateSetter}) : super(key: key);

final VoidCallback stateSetter;

  @override
  _MyContactDisplayState createState() => _MyContactDisplayState();
}

class _MyContactDisplayState extends State<MyContactDisplay> {
  @override
  void initState() {
    super.initState();

  }




  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border(bottom:BorderSide(color: Colors.black12))),
      child: contactDisplay(widget.contact));
  }


 Widget contactDisplay(contact) {
    bool onePhone=false;
    int _phoneCount = contact.phones.length;
    if(_phoneCount==0)
    return SizedBox.shrink();
    else
    if(_phoneCount==1)
    onePhone=true;
    return onePhone?
    singlePhoneContactDisplay(contact)
    :multiPhonesContactDisplay(contact)
    ;
  }

  ExpansionTile multiPhonesContactDisplay(contact) {
    return ExpansionTile(
                    title: Text(contact.displayName),
                    subtitle: Container(child: Text("Tap to show")),
                      children: getAll(contact),
                    leading: setAvatar(contact),
                );
  }

  StatelessWidget setAvatar(MyContact contact) {
    return (contact.avatar != null && contact.avatar.length > 3) ?
                  CircleAvatar(
                    backgroundImage: MemoryImage(contact.avatar),
                  ) :
                  Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                              colors: [
                                contact.avatarColor[800],
                                contact.avatarColor[400],
                              ],
                              begin: Alignment.bottomLeft,
                              end: Alignment.topRight
                          )
                      ),
                      child: CircleAvatar(
                          child: Text(
                              contact.initials,
                              style: TextStyle(
                                  color: Colors.white
                              )
                          ),
                          backgroundColor: Colors.transparent
                      )
                  );
  }

  Widget singlePhoneContactDisplay( MyContact contact) {
    return ListTile
    (
        title: Text(contact.displayName),
        subtitle: Text(contact.phones[0]),

        


        leading: setAvatar(contact),
        onTap: (){_setDialog(contact.phones[0]);
    contact.contactClicked();
    widget.stateSetter();
    },
    );
  }





  List<Widget> getAll(MyContact contact){
    var retVal = <Widget>[];

    contact.phones.forEach((phone){
      retVal.add(
          GestureDetector(
            onTap: (){_setDialog(phone);
            contact.contactClicked();
            widget.stateSetter();

            },
            child:ListTile(
            title:Text(phone),
            leading: Icon(Icons.phone_android),
          )
          )
          );
    });
    return retVal;

  }

  
   _setDialog(phone){
  /*showDialog(
      context: context,
      builder: (BuildContext context) => CustomDialog(
        phone:phone,
        title: "Driving",
        status:"Message me, and I will callback after reaching my destination.",
        imageLoc:"assets/images/gun.png",
isLocalImage:true,
bgColor: Colors.cyan[400],
titleColor:Colors.black87,
statusColor: Colors.black45,
isEditing:false,
sidePadding:25,
topPadding:30,
      ),
    );*/
    showDialog(context: context,
    child:Center(child: CircularProgressIndicator(backgroundColor: Colors.red,)),
);
     FirestoreHandler().getFirestoreData(context,phone);
  }


}