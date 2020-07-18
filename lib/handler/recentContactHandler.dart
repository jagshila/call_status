import 'package:flutter/material.dart';
import 'prefHandler.dart';

class RecentContact {
  String displayName = "", initials = "";
  var phones = [];
static var storedContactHash=[];
var avatar;




String getHash()
{
    String returnValue = "";
      returnValue += displayName + "/-1-/";
      returnValue += initials + "/-1-/";
      for (var phone in phones) {
        returnValue += phone + "/-1-/";
      }
return returnValue;
}


getContactWidget(){




}


int updateContactHash(){
  var hashValue=this.getHash();
int indexOfContact=RecentContact.storedContactHash.indexOf(hashValue);
int sizeOfArray = RecentContact.storedContactHash.length;
if(sizeOfArray>0)
if(indexOfContact==-1 && sizeOfArray>9)
{
  RecentContact.storedContactHash.removeLast();
}
else if(indexOfContact!=-1)
{
  RecentContact.storedContactHash.removeAt(indexOfContact);
}
  RecentContact.storedContactHash.insert(0,this.getHash());
  return indexOfContact;

}

static String getContactStringToStore(){
    String returnValue = "";
    var contactHashes=RecentContact.storedContactHash;
    for (var contactHash in contactHashes) {
    returnValue+=contactHash;      
    returnValue += "/-3-/";
    }
    return returnValue;

}

  static String convertToString(contacts) {
    String returnValue = "";
    for (var contact in contacts) {
    returnValue+=contact.getHash();      
    returnValue += "/-3-/";
    }
    return returnValue;
  }

  setContactFromHash(contactHash)
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

}

  static List convertToMyContact(stringValue) {
    var returnValue = [];
    RecentContact current;
    var splittedArray = stringValue.split("/-3-/");
    splittedArray.removeLast();
    RecentContact.storedContactHash = splittedArray;
    for (var splitString in splittedArray) {
      current = new RecentContact();
    current.setContactFromHash(splitString);
      returnValue.add(current);
    }
    return returnValue;

 
  }


  int contactClicked(){
int indexOfContact=updateContactHash();
String stringToStore=RecentContact.getContactStringToStore();
saveStringContact(stringToStore);
return indexOfContact;
    }



  bool isEqual(RecentContact x) {
    bool phoneEqual = false;
    int myLength = this.phones.length;
    if (myLength == x.phones.length) {
      phoneEqual = true;
      for (int i = 0; i < myLength; i++) {
        if (this.phones[i] != x.phones[i]) phoneEqual = false;
      }
    }
    return (this.displayName == x.displayName &&
        this.initials == x.initials &&
        phoneEqual);
  }
}






void saveStringContact( String value) {
  // 2
 // SharedPreferences prefs = await SharedPreferences.getInstance();
  // 3
saveStringPref("preCachedContacts", value);
  //await prefs.setString("preCachedContacts",value);
 // print(prefs.getString("preCachedContacts"));
}

Future<String> getStringContact() async {
  // 2
  //SharedPreferences prefs = await SharedPreferences.getInstance();
  // 3
  return getStringPref("preCachedContacts");
}




class MainDisp extends StatefulWidget {
  MainDisp({Key key}) : super(key: key);

  @override
  _MainDispState createState() => _MainDispState();
}

class _MainDispState extends State<MainDisp> {

  var contacts = [];
  var recentContacts = [];
String fromWhere="Hardcoded";

@override
void initState() { 
  super.initState();
  getFromPrefs();
  main2();
  
}


Widget printMyContact(contact) {
List<Widget> columnChildren = [];
columnChildren.add(Text("Name:"+contact.displayName));
columnChildren.add(Text("Initials:"+contact.initials));
for(var phone in contact.phones)
columnChildren.add(Text(phone));
    return GestureDetector(
      onTap:(){updateRecentContacts(contact.contactClicked(),contact);},
      child:Container(child:Column(children: columnChildren,),
      margin: const EdgeInsets.all(15.0),
  padding: const EdgeInsets.all(3.0),
  decoration: BoxDecoration(
    border: Border.all(color: Colors.blueAccent)
  )));
    
  }

updateRecentContacts(indexOfContact, RecentContact current)
{

  setState(() {
int sizeOfArray = recentContacts.length;
if(sizeOfArray>0)
if(indexOfContact==-1 && sizeOfArray>9)
{
  recentContacts.removeLast();
}
else if(indexOfContact!=-1)
{
  recentContacts.removeAt(indexOfContact);
}
  recentContacts.insert(0,current);
  });
}

getFromPrefs(){
  recentContacts=[];
  getStringContact().then((val)=>
    setState((){
fromWhere="From File";
recentContacts=RecentContact.convertToMyContact(val);
    })
  );

}

List<Widget> contactsToWidget(contactsArray)
{
List<Widget> returnList=[];
for (RecentContact contact in contactsArray)
returnList.add(printMyContact(contact));
return returnList;
}



  @override
  Widget build(BuildContext context) {
    return ListView(
      
       children: [
         Text("Recent:"),
         Column(children: contactsToWidget(recentContacts))
         ,
         Text("Contacts:")
         ,
         Column(children:contactsToWidget(contacts)),
       
       ],
    );
  }

   main2(){
  var nums = ["98555555000", "98555555000", "98555555000", "98555555000"];
  RecentContact x = new RecentContact();
  x.displayName = "Akshay";
  x.phones = nums;
  contacts.add(x);
  x=new RecentContact();
  x.displayName = "1Akshay";
  x.phones = nums;
  contacts.add(x);
  x = new RecentContact();
  x.displayName = "Bhakshay";
  x.phones = nums;
  x.initials = "b";
  contacts.add(x);
  x = new RecentContact();
  x.displayName = "Chakshay";
  x.phones = nums;
  contacts.add(x);
  x = new RecentContact();
  x.displayName = "Dhakshay";
  x.phones = nums;
  contacts.add(x);
    x = new RecentContact();
  x.displayName = "Ehakshay";
  x.phones = nums;
  contacts.add(x);
    x = new RecentContact();
  x.displayName = "Fhakshay";
  x.phones = nums;
  contacts.add(x);
    x = new RecentContact();
  x.displayName = "Ghakshay";
  x.phones = nums;
  contacts.add(x);
    x = new RecentContact();
  x.displayName = "Hhakshay";
  x.phones = nums;
  contacts.add(x);
    x = new RecentContact();
  x.displayName = "Ihakshay";
  x.phones = nums;
  contacts.add(x);
    x = new RecentContact();
  x.displayName = "zhakshay";
  x.phones = nums;
  contacts.add(x);
  
//String convertedString = MyContact.convertToString(contacts);
//print(convertedString);
//saveStringContact("");
  
  
}
  
}



main()=>runApp(MaterialApp(
  title:"Contact Try",
  home:Scaffold(
body: Container(
  child:MainDisp()
)

  )

));