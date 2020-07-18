import 'dart:typed_data';

import 'package:callstatus/uiComponents/contactDisplay.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
//import 'package:url_launcher/url_launcher.dart';
import 'package:permission_handler/permission_handler.dart';
//import 'package:shared_preferences/shared_preferences.dart';
import '../uiComponents/dialog.dart';
//import 'DisplayOverlay1.dart';
import '../ui/background.dart';
import 'package:flutter/services.dart';
import 'package:callstatus/handler/backButton.dart';
import 'package:callstatus/handler/database_handler.dart';
class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  bool gotPermissionsStatus=false;
  List<Contact> contacts = [];
  List<Contact> contactsFiltered = [];
  Map<String, Color> contactsColorMap = new Map();
  TextEditingController searchController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
     getPermission().then((value) => 
     gotPermissions()
     );
  }

  void gotPermissions()
  {
if(!gotPermissionsStatus) {
  getAllContacts();
  searchController.addListener(() {
    filterContacts();

  });
  gotPermissionsStatus=true;
}
  }

  String flattenPhoneNumber(String phoneStr) {
    return phoneStr.replaceAllMapped(RegExp(r'^(\+)|\D'), (Match m) {
      return m[0] == "+" ? "+" : "";
    });
  }

  getAllContacts() async {
    var nullAvatar=Uint8List(2);
    List colors = [
      Colors.green,
      Colors.indigo,
      Colors.yellow,
      Colors.orange
    ];
    int colorIndex = 0;
    List<Contact> _contacts = (await ContactsService.getContacts(withThumbnails: false)).toList();
    _contacts.forEach((contact) {

      /*  ContactsService.getAvatar(contact).then((avatar) {
        if (avatar == null) contact.avatar=nullAvatar; // Don't redraw if no change.
        contact.avatar = avatar;
      });
*/
      Color baseColor = colors[colorIndex];
      contactsColorMap[contact.displayName] = baseColor;
      colorIndex++;
      if (colorIndex == colors.length) {
        colorIndex = 0;
      }
    });
    setState(() {
      contacts = _contacts;
      contacts.sort((a,b)=>a.displayName.compareTo(b.displayName));

    });
  }



  filterContacts() {
    List<Contact> _contacts = [];
    _contacts.addAll(contacts);
    if (searchController.text.isNotEmpty) {
      _contacts.retainWhere((contact) {
        String searchTerm = searchController.text.toLowerCase();
        String searchTermFlatten = flattenPhoneNumber(searchTerm);
        String contactName = contact.displayName.toLowerCase();
        bool nameMatches = contactName.contains(searchTerm);
        if (nameMatches == true) {
          return true;
        }

        if (searchTermFlatten.isEmpty) {
          return false;
        }

        var phone = contact.phones.firstWhere((phn) {
          String phnFlattened = flattenPhoneNumber(phn.value);
          return phnFlattened.contains(searchTermFlatten);
        }, orElse: () => null);

        return phone != null;
      });

      setState(() {
        contactsFiltered = _contacts;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isSearching = searchController.text.isNotEmpty;
    return WillPopScope(
    onWillPop: ()=>onBackPressed(context),
    child:Scaffold(
  /*    appBar: AppBar(
        title: Center(child:Text(widget.title,
        style: TextStyle(color: Colors.white),
        )),  
      ),
      */
      resizeToAvoidBottomPadding: false,
      body: 
      Stack(
          children: <Widget>[
            Opacity(
              opacity: 0.5,
              child:Background()),
            
        
      Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
              Container(
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                    labelText: 'Search',
                    border: new OutlineInputBorder(
                        borderSide: new BorderSide(
                            color: Theme.of(context).primaryColor
                        )
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                      color: Theme.of(context).primaryColor,
                    )
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: isSearching == true ? contactsFiltered.length : contacts.length,
                itemBuilder: (context, index) {
                  Contact contact = isSearching == true ? contactsFiltered[index] : contacts[index];

                  var baseColor = contactsColorMap[contact.displayName] as dynamic;

                  Color color1 = baseColor[800];
                  Color color2 = baseColor[400];
                  var allPhones=cleanAllContacts(contact.phones);
                  bool onePhone=false;
                  if(allPhones.length==0)
                  return SizedBox.shrink();
                  if(allPhones.length==1)
                  onePhone=true;
                 // return Text(contact.displayName);
                  return MyContactDisplay(contact:contact);
                  /*return onePhone?
                  GestureDetector(
                  onTap:(){_setDialog(allPhones[0]);},
                  child:ListTile
                  (
                      title: Text(contact.displayName),

                      


                      leading: (contact.avatar != null && contact.avatar.length > 0) ?
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
                      )
                  )
                  )
                  :ExpansionTile(
                      title: Text(contact.displayName),
                        children: getAll(allPhones),

                      


                      leading: (contact.avatar != null && contact.avatar.length > 0) ?
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
                      )
                  )
                  ;*/
                },
              ),
            )
          ],
        ),
      ),
          ])));
  }


cleanAllContacts(obj)
{
    var obj1=<String>[];
    obj.forEach((phone) {
      obj1.add(validateContact(phone.value));
    });
    obj=obj1.toSet().toList();
    return obj;
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

  String validateContact(String phone)
  {
    phone=phone.replaceAll(new RegExp(r'[^0-9+]'),'');
    if(phone[0]=='0')
      phone=phone.substring(1);
    if(phone[0]!='+')
      phone="+91"+phone;
    return phone;

  }



  Future<bool> getPermission() async{
    var x = await [Permission.phone,Permission.contacts].request();
    if(await Permission.phone.status == PermissionStatus.granted && await Permission.phone.status==PermissionStatus.granted)
      {
        gotPermissions();
        return true;
      }
    else
      return false;
  }



   _setDialog(phone){

 FirestoreHandler().getFirestoreData(context,phone);
  }


  }
