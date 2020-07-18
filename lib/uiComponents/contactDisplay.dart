import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';
import '../handler/database_handler.dart';

class MyContact{
String displayName, initialsVal;
var avatar;
var phones = [];

initials(){
  return initialsVal;
}

}

class MyContactDisplay extends StatefulWidget {
final contact;
MyContactDisplay({Key key ,this.contact}) : super(key: key);


  @override
  _MyContactDisplayState createState() => _MyContactDisplayState();
}

class _MyContactDisplayState extends State<MyContactDisplay> {
  @override
  void initState() {
    super.initState();
    print("displaying");
    /*  var phones=widget.contact.phones.toList();
      print("Checking"+widget.contact.displayName);
      if(!(phones.first is String) && widget.contact.avatar.length<2){
fetchAvatar();
print("fetching");
      }*/
  }



fetchAvatar(){
      ContactsService.getAvatar(widget.contact).then((avatar) {
        if (avatar == null) return; // Don't redraw if no change.
        setState(() => widget.contact.avatar = avatar);
        print(avatar);
      });

}

  @override
  Widget build(BuildContext context) {
    return contactDisplay(widget.contact, Colors.orange, Colors.white);
  }


 Widget contactDisplay(contact, Color color1, Color color2) {
    var allPhones=cleanAllContacts(contact.phones);
    bool onePhone=false;
    if(allPhones.length==0)
    return SizedBox.shrink();
    else
    if(allPhones.length==1)
    onePhone=true;
    return onePhone?
    singlePhoneContactDisplay(allPhones, contact, color1, color2)
    :multiPhonesContactDisplay(contact, allPhones, color1, color2)
    ;
  }

  ExpansionTile multiPhonesContactDisplay(contact, allPhones, Color color1, Color color2) {
    return ExpansionTile(
                    title: Text(contact.displayName),
                      children: getAll(allPhones),

                    


                    leading: setAvatar(contact, color1, color2)
                );
  }

  StatelessWidget setAvatar(contact, Color color1, Color color2) {
    return (contact.avatar != null && contact.avatar.length > 3) ?
                  CircleAvatar(
                    backgroundImage: MemoryImage(contact.avatar),
                  ) :
                  Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                              colors: [
                                color1,
                                color2,
                              ],
                              begin: Alignment.bottomLeft,
                              end: Alignment.topRight
                          )
                      ),
                      child: CircleAvatar(
                          child: Text(
                              contact.initials(),
                              style: TextStyle(
                                  color: Colors.white
                              )
                          ),
                          backgroundColor: Colors.transparent
                      )
                  );
  }

  GestureDetector singlePhoneContactDisplay(allPhones, contact, Color color1, Color color2) {
    return GestureDetector(
                onTap:(){_setDialog(allPhones[0]);},
                child:ListTile
                (
                    title: Text(contact.displayName),

                    


                    leading: setAvatar(contact, color1, color2)
                )
                );
  }


cleanAllContacts(phones)
{
    var phonesObj=<String>[];

if(phones.first is String)
phones.forEach((phone){
      phonesObj.add(validateContact(phone));
});
else
phones.forEach((phone){
      phonesObj.add(validateContact(phone.value));
});


    phones=phonesObj.toSet().toList();
    return phones;
}


  List<Widget> getAll(obj){
    var retVal = <Widget>[];

    obj.forEach((phone){
      retVal.add(
 
     /*     Row(
              children:[Text(phone),
                IconButton(
                  icon:Icon(Icons.play_circle_filled),
                  onPressed: (){_setDialog(phone);},
                )
              ]
          )*/
          GestureDetector(
            onTap: (){_setDialog(phone);},
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

 FirestoreHandler().getFirestoreData(context,phone);
  }


  
  String validateContact(String phone)
  {
    phone=phone.replaceAll(new RegExp(r'[^0-9+]'),'');
    if(phone[0]=='0')
      phone=phone.substring(1);
    if(phone[0]!='+')
      phone="+91"+phone;
    return phone;

  }


}


/*
main()=>runApp(
MaterialApp(
home:Scaffold(
  body:
  TryContactDisplay()
  ,
)

)

);


class TryContactDisplay extends StatefulWidget {
  TryContactDisplay({Key key}) : super(key: key);

  @override
  _TryContactDisplayState createState() => _TryContactDisplayState();
}



class _TryContactDisplayState extends State<TryContactDisplay> {

var allContacts;
Contact contactFromStorage;
MyContact contactCreated;
Item x;
  @override
  void initState() { 
    super.initState();
getAllContacts();
contactCreated = new MyContact();
contactCreated.displayName="Ultimate Jugadu";
contactCreated.initialsVal="AK";
contactCreated.phones=["9850477230","8693090385","9766712032"];
  }

getAllContacts() async{

    List<Contact> _contacts = (await ContactsService.getContacts(withThumbnails: false)).toList();
    
    setState(() {
          allContacts=_contacts;
    contactFromStorage=allContacts[0];

    });


}


displayContact(contact){

return MyContactDisplay(
contact:contact
);

}


  @override
  Widget build(BuildContext context) {
    return Container(
       child: Column(children:[
         contactFromStorage==null?Text("Contact will apprear here"):displayContact(contactFromStorage),
         displayContact(contactCreated),
  
         ]),
    );
  }
}
*/