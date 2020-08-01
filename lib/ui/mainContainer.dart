
import 'package:callstatus/ui/displayAllContacts.dart';
import 'package:callstatus/ui/presetDialog.dart';
import 'package:flutter/material.dart';
import 'package:callstatus/uiComponents/background.dart';
import 'package:callstatus/handler/constants.dart';
import 'package:callstatus/ui/settings.dart';
import 'package:callstatus/handler/prefHandler.dart';
import 'package:callstatus/handler/myContactHandler.dart';
import 'package:callstatus/handler/presetDialoghandler.dart';
import 'package:callstatus/handler/firebaseLoginHandler.dart';
TextEditingController globalSearchController;
TabController myTabController;

class MainContainer extends StatelessWidget {
  final Widget content;
  const MainContainer({Key key, this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
          child: Scaffold(
        body: content,
      ),
    );
  }
}
/*
class MainContainer1 extends StatelessWidget {
  final Widget content;
  const MainContainer1({Key key, this.content}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
          child: SafeArea(
                  child: Scaffold(
          
          appBar: myAppBar(context),
          body: Stack(
          children: <Widget>[
              Background(),
              GestureDetector(child: content,
              onTap: ()=>FocusScope.of(context).unfocus(),
              )
          ],
          ),
        ),
      ),
    );
  }

  

mySearchBar(){
  return AppBar(
    
  );
}

myAppBar(context)
{

  return AppBar(
    title: Text("Call Status",),
    
    actions: <Widget>[
      IconButton(onPressed:()=>Navigator.push(context,MaterialPageRoute(builder: (context)=>DisplayAllContacts())),icon:Icon(Icons.search)),
    ],

bottom: TabBar(tabs: 

[

Tab(text:"CONTACTS"),

Tab(text:"CURRENT"),

Tab(text:"PRESETS")

])
  

  );
}


tabBarView(){
return TabBarView(children: [
  DisplayAllContacts(),
  Text("Current Dialog will appear here"),
  PresetDialogDisplay(),

]);
  
}
}

*/


/*
main()=>runApp(
  
  MaterialApp(
    theme:ThemeData(
          primarySwatch: Colors.green,
          primaryColor: Colors.teal[800],
                  ),
    //home: MainContainer2(),
    home: MainContainer(content:DisplayAllContacts()),

  )
);
*/



class MainContainer2 extends StatefulWidget {
  MainContainer2({Key key}) : super(key: key);

  @override
  _MainContainer2State createState() => _MainContainer2State();
}

class _MainContainer2State extends State<MainContainer2> with SingleTickerProviderStateMixin{
bool isSearching;
double appbarHeight;
@override
  void initState() {
isSearching=false;
myTabController= TabController(length: 3, vsync: this);
globalSearchController=TextEditingController();
super.initState();

  }
    @override
  void dispose() {
    myTabController.dispose();
    globalSearchController.dispose();
    super.dispose();
  }

  Future<bool> _willPopCallback() async{
    
        if(isSearching){
          setState(() {
            isSearching=false;
            globalSearchController.clear();
          });

        return false;
        }
        else{
        return true;
        }
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()=>_willPopCallback(),
          child: SafeArea(
                      child: Scaffold(
          
          appBar: !isSearching?myAppBar():mySearchBar(),
          body: Stack(
              children: <Widget>[
                  Background(),
                  GestureDetector(child: tabBarView(),
                  onTap: ()=>FocusScope.of(context).unfocus(),
                  )
              ],
          ),
        ),
          ),
    );

  }

  

mySearchBar(){
  return AppBar(
    backgroundColor: Colors.white,
  //  leading:       IconButton(onPressed:()=>setState((){isSearching=false;}),icon:Icon(Icons.arrow_back, color: Colors.teal[800],)),

    title: Align(
      alignment: Alignment.centerRight,
      child: AnimateExpansion(
                  axisAlignment: -1.0,
            animate: true,
            child: TextField(
          autofocus: true,
          controller: globalSearchController,
          decoration: InputDecoration(
    hintText: "Search...",
    prefixIcon: IconButton(onPressed:()=>setState((){isSearching=false;globalSearchController.clear();}),icon:Icon(Icons.arrow_back, color: Colors.teal[800],))
  ),
        ),
      ),
    ),
    actions: <Widget>[
    ],
  );
}

myAppBar()
{
  
  return AppBar(
    title: Text("Call Status"),
    actions: <Widget>[
      IconButton(onPressed:()=>setState((){
        myTabController.animateTo(0);
        isSearching=true;
      }),icon:Icon(Icons.search)),
     PopupMenuButton(
       onSelected: choiceAction,
       itemBuilder: (context){
         return MyConstants.popUpMenu.map((e){ 
         return PopupMenuItem(
           value: e,
           child: Text(e),
         );
       }
         ).toList();
       }
       ,
     )
    ],

bottom: TabBar(
  indicatorColor: Colors.white,
  indicatorWeight: 3,
  controller: myTabController,
  tabs: 

[

Tab(text:"CONTACTS"),

Tab(text:"CURRENT"),

Tab(text:"PRESETS")

])
  

  );
}


tabBarView(){
return TabBarView(
  controller: myTabController,
  children: [
  DisplayAllContacts(),
  Text("Current Dialog will appear here"),
  PresetDialogDisplay(),

]);
  
}

void choiceAction(choice)
{
switch(choice)
{
  case MyConstants.settings:{
Navigator.push(context, MaterialPageRoute(builder: (context) => Settings(),));
  break;}
  case MyConstants.clearPreset:{
    showDialog(context: context,child:
    AlertDialog(
      title: Text("Are you sure?"),
      content: Text("You want to clear presets?"),
      actions: <Widget>[
        FlatButton(
          child: Text("YES"),
          onPressed: () {
            PresetDialogs.isInitiated=false;
PresetDialogs.resetAllPresetDialogs();
Navigator.pop(context);
myTabController.animateTo(2);

  setState(() {
    
  });
          },
        ),
        FlatButton(
          child: Text("Cancel"),
          onPressed: () => Navigator.pop(context),
        )
      ],
    )
    );

  break;}
  case MyConstants.clearRecent:{

    showDialog(context: context,child:
    AlertDialog(
      title: Text("Are you sure?"),
      content: Text("You want to clear recent?"),
      actions: <Widget>[
        FlatButton(
          child: Text("YES"),
          onPressed: () {
    MyContact().resetContactHash();

 myTabController.animateTo(0);
 setState(() {
   
 });
 Navigator.pop(context);
          },
        ),
        FlatButton(
          child: Text("Cancel"),
          onPressed: () => Navigator.pop(context),
        )
      ],
    )
    );
    
  break;}
  case MyConstants.logout:{
FirebaseLoginHandler.signOut(context);
  break;}
  case MyConstants.newStatus:{
myTabController.animateTo(2);
  break;}


  
  
}
}
}


class AnimateExpansion extends StatefulWidget {
  final Widget child;
  final bool animate;
  final double axisAlignment;
  AnimateExpansion({
    this.animate = false,
    this.axisAlignment,
    this.child,
  });

  @override
  _AnimateExpansionState createState() => _AnimateExpansionState();
}

class _AnimateExpansionState extends State<AnimateExpansion>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _animation;

  void prepareAnimations() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 350),
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInCubic,
      reverseCurve: Curves.easeOutCubic,
    );
  }

  void _toggle() {
    if (widget.animate) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  @override
  void initState() {
    super.initState();
    prepareAnimations();
    _toggle();
  }

  @override
  void didUpdateWidget(AnimateExpansion oldWidget) {
    super.didUpdateWidget(oldWidget);
    _toggle();
  }

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
        axis: Axis.horizontal,
        axisAlignment: -1.0,
        sizeFactor: _animation,
        child: widget.child);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}


//3rd UI

class MainContainer3 extends StatefulWidget {
  MainContainer3({Key key,this.title}) : super(key: key);
final title;
  @override
  _MainContainer3State createState() => _MainContainer3State();
}

class _MainContainer3State extends State<MainContainer3> {

@override
  void initState() {
    globalSearchController=new TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
  floatingActionButton: FloatingActionButton(
    onPressed: () { },
    tooltip: 'Add Status',
    child: Icon(Icons.add),
    elevation: 2.0,
  ),
      bottomNavigationBar: _myBottomNavigationBar(),
     // appBar: _myAppBar(),
      body:NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return <Widget>[
_mySliverAppBar(innerBoxIsScrolled)
          ];
        },
      body: DisplayAllContacts(),
      )
    );

  }

Widget _mySliverAppBar(innerBoxIsScrolled){
return SliverAppBar(
  pinned: true,
  floating: true,
  forceElevated: innerBoxIsScrolled,
      elevation: 0,
      title: Text(widget.title),
      flexibleSpace: Align(
        alignment: Alignment.topRight,
        child: Image.asset("assets/images/background.png")),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: Container(
                      decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.transparent,Theme.of(context).scaffoldBackgroundColor],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.5,0.5]
              )
          ),
            
            child: _getSearchBarUI(context))),
    );
}

 

  Container _getSearchBarUI(context) {
    return Container(
          padding: EdgeInsets.only(left:MediaQuery.of(context).size.width*0.1,right:MediaQuery.of(context).size.width*0.1),
          child: TextField(
            
            autofocus: false,
decoration:MyDecorations.getInputDecorationSearch()
          ));
  }

_myBottomNavigationBar(){
return BottomAppBar(
    child: Container(
      height:10
    ),
    shape: CircularNotchedRectangle(),
  );
}
}


class MyDecorations{
static getInputDecorationSearch(){
  return  InputDecoration(
             filled: true,
          fillColor: MyColors.inputFieldFillColor,
          hintText: "Search",
        contentPadding:
            EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),

 enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(14.0)),
              borderSide: BorderSide(
    color: MyColors.inputFieldBorderColor

  ),
          ),
 
            
focusedBorder: OutlineInputBorder(
  borderSide: BorderSide(
    color: MyColors.inputFieldBorderColor

  ),
  borderRadius: BorderRadius.all(Radius.circular(12.0)),
  

),
           
  suffixIcon: IconButton(
    icon: Icon(Icons.search,color: MyColors.inputFieldIconColor),
    onPressed: () {
      
    },
  )
            );


}
}

class MyColors{
  static final  MaterialColor primarySwatches=Colors.blue;
  static final Color inputFieldFillColor=Colors.white;
    static final Color inputFieldBorderColor=Colors.black12;
    static final Color inputFieldIconColor=Colors.black38;

}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.yellow,
    primaryColor: Colors.yellowAccent,
    textSelectionColor: Colors.black,
    
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MainContainer3(title: 'Call Status'),
    );
  }
}