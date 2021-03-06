import 'package:flutter/material.dart';
import 'package:callstatus/handler/myContactHandler.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:callstatus/ui/mainContainer.dart';
import 'package:callstatus/handler/backButton.dart';
import 'package:callstatus/uiComponents/myContactDisplay.dart';
import 'package:callstatus/ui/presetDialog.dart';

class DisplayAllContacts extends StatefulWidget {
  DisplayAllContacts({Key key}) : super(key: key);
  @override
  _DisplayAllContactsState createState() => _DisplayAllContactsState();
}

class _DisplayAllContactsState extends State<DisplayAllContacts> {


  bool gotPermissionsStatus=false;
  List<MyContact> contactsFiltered = [];
  int recentContactCount;
  TextEditingController searchController;
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
    searchController=globalSearchController;
    if(!MyContact.recentFetched)
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

@override
void setState(fn) {
if(mounted)    
super.setState(fn);
  }
 

  void gotPermissions()
  {
if(!gotPermissionsStatus) {
  if(!MyContact.contactFetched)
  getAllContacts();
  searchController.addListener(() {
    filterContacts();

  });
  gotPermissionsStatus=true;
}
  }
/*
    getAllContacts() async {
  MyContact _myContact;
    List<Contact> _contacts = (await ContactsService.getContacts(withThumbnails: false)).toList();
    _contacts.sort((a,b)=>a.displayName.compareTo(b.displayName));
    _contacts.forEach((contact) {

     _myContact=new MyContact();
     _myContact.setUsingContact(contact);
contacts.add(_myContact);
    });
    setState(() {
    });

int contactIndex=0;
        for (final contact in _contacts) {
        Uint8List nullAvatar = Uint8List(2);
        Uint8List _avatar = await ContactsService.getAvatar(contact);
        if (_avatar == null) 
        contacts[contactIndex].avatar=nullAvatar; // Don't redraw if no change.
        else
       contacts[contactIndex].avatar=_avatar;
contactIndex++;
        
    
    }
  }
*/

getAllContacts(){
  if(!MyContact.contactFetched)
  {
    MyContact.setCountryCode().then((value){
    MyContact.fetchAllContacts().then((value) {
      setState((){});
      MyContact.fetchAllAvatars().then((value) {
        setState(() {       
        });
      });
    });
      });
  }
}


  filterContacts() {
    List<MyContact> _contacts = [];
    _contacts.addAll(MyContact.contacts);
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

 Widget appBarTitle = new Text("Call status",
                                 style: TextStyle(color: Colors.white),

 );
  Icon actionIcon = new Icon(Icons.search, color: Colors.white,);


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
 bool isSearching = searchController.text.isNotEmpty;
 List<MyContact> _contactsWithExtra =[];
 if(MyContact.recentContacts!=null && MyContact.recentContacts.length!=0)
 {
_contactsWithExtra.add(recentLabel);
_contactsWithExtra.addAll(MyContact.recentContacts);
 }
 _contactsWithExtra.add(contactsLabel);
_contactsWithExtra.addAll(MyContact.contacts);
    return MainContainer(
                                content: Scaffold(
  /*    appBar: AppBar(
            title: Center(child:Text(widget.title,
            style: TextStyle(color: Colors.white),
            )),  
        ),

          Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => DisplayAllContacts()),
  )
        */
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomPadding: false,
        floatingActionButton: FloatingActionButton.extended(
        
          label: Text("Add Status"),
         // onPressed:()=>Navigator.push(context, MaterialPageRoute(builder:(context)=>PresetDialogDisplay() ))
         onPressed:()=> myTabController.animateTo(2),
         ),
  /*      appBar:  AppBar(
         // backgroundColor: Colors.orange,
         leading: Container(),
        centerTitle: true,
        title:appBarTitle,
        actions: <Widget>[
             IconButton(icon: actionIcon,onPressed:(){
            setState(() {
       if ( this.actionIcon.icon == Icons.search){
        this.actionIcon =  Icon(Icons.close, color: Colors.white,);
        this.appBarTitle = buildSearchField(context);
        focusNode.requestFocus();

        }
        else {
          this.actionIcon = new Icon(Icons.search, color: Colors.white,);
          this.appBarTitle = new Text("Call Status",
          style: TextStyle(color: Colors.white),
          );
          searchController.text="";
        }


      });
        } ,),
        IconButton(icon: Icon(Icons.settings),)
        ]
      ),*/
        body: 
        Container(
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
    );
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