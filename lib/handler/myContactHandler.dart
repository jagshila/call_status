import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';
import 'prefHandler.dart';
import 'database_handler.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'backButton.dart';
import 'package:callstatus/ui/background.dart';
import 'package:callstatus/uiComponents/dialog.dart';
class AvatarColor{
static const colors=[
      Colors.green,
      Colors.indigo,
      Colors.yellow,
      Colors.orange
];
static int maxColors=colors.length;
static int count=0;

static getColor(){
  count++;
return (colors[count%4]);
}


}

class MyContact {
String displayName, initials;
var phones=[];
Uint8List avatar;
static List<String> storedContactHash=[];
static List<String> storedAvatarHash=[];
static List<MyContact> recentContacts=[];
var avatarColor;

MyContact(){
  avatarColor=AvatarColor.getColor();

}


static Future<bool> fetchRecentContacts() async{
   return MyContact.getContactHashFromSharedPref().then((storedContactHashArray) {
      if(storedContactHashArray==null)
      return false;
      MyContact.storedContactHash=storedContactHashArray;
    
     return MyContact.getAvatarHashFromSharedPref().then((storedAvatarHashArray) {
        MyContact _myContact ;
    MyContact.storedAvatarHash=storedAvatarHashArray;
    int _index=0;
    storedContactHashArray.forEach((contactHash) { 
    _myContact = new MyContact(); 
    _myContact.setContactFromHash(contactHash, storedAvatarHashArray[_index]);
    _index++;
    recentContacts.add(_myContact);
 
print(contactHash);
    });
    return true;
      });
    
    
    });
}


setUsingContact(Contact contact){
    var  _phones=<String>[];
displayName = contact.displayName;
initials = contact.initials();
contact.phones.forEach((phone){
_phones.add(_validateContact(phone.value));
});

    phones=_phones.toSet().toList();

      ContactsService.getAvatar(contact).then((_avatar) {
        Uint8List nullAvatar = Uint8List(2);
        if (_avatar == null) 
        avatar=nullAvatar; // Don't redraw if no change.
        else
        avatar = _avatar;
        });
      

}

 String _validateContact(String phone)
  {
    phone=phone.replaceAll(new RegExp(r'[^0-9+]'),'');
    if(phone[0]=='0')
      phone=phone.substring(1);
    if(phone[0]!='+')
      phone="+91"+phone;
    return phone;

  }



  //From recent

  String _getContactHash()
{
    String returnValue = "";
      returnValue += displayName + "/-1-/";
      returnValue += initials + "/-1-/";
      for (var phone in phones) {
        returnValue += phone + "/-1-/";
      }
return returnValue;
}

String _getAvatarHash(){

  
  String _stringHash,_stringAvatar = avatar.toString();
    int _length = _stringAvatar.length;

  _stringHash=_stringAvatar.substring(1,_length-1);
  return _stringHash;
}


  setContactFromHash(contactHash,avatarHash)
{
  var contactDetails = contactHash.split("/-1-/");
      contactDetails.removeLast();
      var count = -1;

      for (var detail in contactDetails) {
        count++;
        if (count == 0)
          this.displayName = detail;
        else if (count == 1)
          this.initials = detail;
        else
          this.phones.add(detail);
      }
      _setAvatarFromHash(avatarHash);

}

_setAvatarFromHash(String avatarHash){
  Uint8List _avatar= new Uint8List.fromList(avatarHash.split(",").map((i)=>int.parse(i)).toList());
avatar= _avatar;
}



_updateStoredArray(){
  String hashValue=_getContactHash();
  String avatarHash=_getAvatarHash();
int indexOfContact=MyContact.storedContactHash.indexOf(hashValue);
int sizeOfArray = MyContact.storedContactHash.length;
if(sizeOfArray>0)
if(indexOfContact==-1 && sizeOfArray>9)
{
  MyContact.storedContactHash.removeLast();
  MyContact.storedAvatarHash.removeLast();
  MyContact.recentContacts.removeLast();
}
else if(indexOfContact!=-1)
{
  MyContact.storedContactHash.removeAt(indexOfContact);
  MyContact.storedAvatarHash.removeAt(indexOfContact);
  MyContact.recentContacts.removeAt(indexOfContact);
}
  MyContact.storedContactHash.insert(0,hashValue);
  MyContact.storedAvatarHash.insert(0, avatarHash);
  MyContact.recentContacts.insert(0, this);

}

 contactClicked(){
_updateStoredArray();
saveHashToSharedPref();
    }



saveHashToSharedPref(){
saveArrayToPref("contactHash", storedContactHash);
saveArrayToPref("avatarHash", storedAvatarHash);
}

static Future<List<String>> getContactHashFromSharedPref() async{
  return getArrayFromPref("contactHash");
}


static Future<List<String>> getAvatarHashFromSharedPref() async{
  return getArrayFromPref("avatarHash");
}

}

//Display



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
    return contactDisplay(widget.contact);
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
                      children: getAll(contact),
                    leading: setAvatar(contact)
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

  GestureDetector singlePhoneContactDisplay( MyContact contact) {
    return GestureDetector(
                onTap:(){_setDialog(contact.phones[0]);
                contact.contactClicked();
                widget.stateSetter();
                },
                child:ListTile
                (
                    title: Text(contact.displayName),
                    subtitle: Text(contact.phones[0]),

                    


                    leading: setAvatar(contact)
                )
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
  showDialog(
      context: context,
      builder: (BuildContext context) => CustomDialog(
        phone:phone,
        title: "Driving",
        status:"Message me, and I will callback after reaching my destination.",
        overlayImage:Image.asset("assets/images/gun.png"),
isLocalImage:true,
bgColor: Colors.cyan[400],
titleColor:Colors.black87,
statusColor: Colors.black45,
isEditing:false,
sidePadding:25,
topPadding:30,
      ),
    ); //FirestoreHandler().getFirestoreData(context,phone);
  }


}





class DisplayAllContacts extends StatefulWidget {
  DisplayAllContacts({Key key}) : super(key: key);
  @override
  _DisplayAllContactsState createState() => _DisplayAllContactsState();
}

class _DisplayAllContactsState extends State<DisplayAllContacts> {


  bool gotPermissionsStatus=false;
  List<MyContact> contacts = [];
  List<MyContact> contactsFiltered = [];
  int recentContactCount;
  TextEditingController searchController = new TextEditingController();
  var focusNode = new FocusNode();

  MyContact recentLabel,contactsLabel;
  @override
  void initState() {
    super.initState();
   // SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    recentLabel=new MyContact();
    contactsLabel=new MyContact();
    recentLabel.displayName="0x0xr";
    contactsLabel.displayName="0x0xc";
    MyContact.fetchRecentContacts().then((value){ 
      if(value)
    setState(() {
      
    });
  }
    );
    

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

    getAllContacts() async {
  
  MyContact _myContact;
    List<Contact> _contacts = (await ContactsService.getContacts(withThumbnails: false)).toList();
    _contacts.forEach((contact) {

     _myContact=new MyContact();
     _myContact.setUsingContact(contact);
contacts.add(_myContact);
    });
    setState(() {
      contacts.sort((a,b)=>a.displayName.compareTo(b.displayName));
    });
  }



  filterContacts() {
    List<MyContact> _contacts = [];
    _contacts.addAll(contacts);
    if (searchController.text.isNotEmpty) {
      _contacts.retainWhere((contact) {
        String searchTerm = searchController.text.toLowerCase();
        String searchTermFlatten = searchTerm;
        String contactName = contact.displayName.toLowerCase();
        bool nameMatches = contactName.contains(searchTerm);
        if (nameMatches == true) {
          return true;
        }

        if (searchTermFlatten.isEmpty) {
          return false;
        }

        var phone = contact.phones.firstWhere((phn) {
          String phnFlattened = phn;
          return phnFlattened.contains(searchTermFlatten);
        }, orElse: () => null);

        return phone != null;
      });

      setState(() {
        contactsFiltered = _contacts;
      });
    }
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

 Widget appBarTitle = new Text("Call status");
  Icon actionIcon = new Icon(Icons.search);


 TextField buildSearchField(BuildContext context) {
    return TextField(
      focusNode: focusNode,
      controller: searchController,
                        style: new TextStyle(
                          color: Colors.white,

                        ),
                        decoration: new InputDecoration(
                          prefixIcon: new Icon(Icons.search,color: Colors.white),
                          hintText: "Search...",
                          hintStyle: new TextStyle(color: Colors.white)
                        ),
                      );
  }

  @override
  Widget build(BuildContext context) {
    print("Hey check here.... I am here..."+MyContact.recentContacts.length.toString());
 bool isSearching = searchController.text.isNotEmpty;
 List<MyContact> _contactsWithExtra =[];
 if(MyContact.recentContacts!=null && MyContact.recentContacts.length!=0)
 {
_contactsWithExtra.add(recentLabel);
_contactsWithExtra.addAll(MyContact.recentContacts);
 }
 _contactsWithExtra.add(contactsLabel);
_contactsWithExtra.addAll(contacts);
    return WillPopScope(
    onWillPop: ()=>onBackPressed(context),
    child:GestureDetector(
      onTap: (){
           FocusScope.of(context).requestFocus(new FocusNode());

      },
          child: Scaffold(
                      body: 
                      Stack(
                        children: <Widget>[
                          Opacity(
                  opacity: 0.5,
                  child:Background()),
                          Scaffold(
  /*    appBar: AppBar(
            title: Center(child:Text(widget.title,
            style: TextStyle(color: Colors.white),
            )),  
        ),
        */
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomPadding: false,
        appBar: new AppBar(
          backgroundColor: Color.fromARGB(20, 120, 20, 20),
        centerTitle: true,
        title:appBarTitle,
        actions: <Widget>[
            new IconButton(icon: actionIcon,onPressed:(){
            setState(() {
                           if ( this.actionIcon.icon == Icons.search){
                            this.actionIcon = new Icon(Icons.close);
                            this.appBarTitle = buildSearchField(context);
                            focusNode.requestFocus();

                            }
                            else {
                              this.actionIcon = new Icon(Icons.search);
                              this.appBarTitle = new Text("Call Status");
                              searchController.text="";
                            }


                          });
        } ,),]
      ),
        body: 
        Container(
            padding: EdgeInsets.all(20),
            child: Column(
              children: <Widget>[

                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: isSearching == true ? contactsFiltered.length : _contactsWithExtra.length,
                    itemBuilder: (context, index) {
                          MyContact contact = isSearching == true ? contactsFiltered[index] : _contactsWithExtra[index];             
                          if(contact.displayName=="0x0xr")
                          return getLabel("Recent");
                          if(contact.displayName=="0x0xc")
                          return getLabel("Contacts");
                          return MyContactDisplay(contact:contact,stateSetter:stateSetter);
                
                    },
                  ),
                )
              ],
            ),
        )),
                        ],
                      ),
          ),
    ));
  }

 


  Widget getLabel(String label){
return ListTile(
  title:Text(label,style: TextStyle(fontWeight: FontWeight.w600,fontSize: 15)),
  
);
  }

  void stateSetter(){
    setState(() {
      
    });
  }

}






main()=>runApp(
MaterialApp(
home:
  DisplayAllContacts(),
  theme: ThemeData(primaryColor: Colors.deepOrange),
)

);