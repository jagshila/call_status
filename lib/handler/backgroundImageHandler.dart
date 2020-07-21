import 'package:flutter/material.dart';
class BackgroundImageHandler{
static List<String> assetPath=[];
static List<String> imageNames=["gun.png","4.png"];


static initAssetPath(){
/*for(int i=1;i<100;i++)
{
  imageNames.add("4 - Copy ("+i.toString()+").png");
}
  */
}


}
/*
void main() => runApp(
  MaterialApp(
home:Scaffold(
  body: 
  
  Column(
    children: <Widget>[
      
      MyApp(),
    ],
  )
),
  )
);

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RaisedButton(
        child: Text("Open"),
        onPressed: () => showBottomDialog(context, MyBackgroundImages()),
      ),
    );
  }
}*/


class MyBackgroundImages extends StatefulWidget {
  MyBackgroundImages({Key key,this.onChangeImage}) : super(key: key);

final Function(String) onChangeImage;

  @override
  _MyBackgroundImagesState createState() => _MyBackgroundImagesState();
}

class _MyBackgroundImagesState extends State<MyBackgroundImages> {
  @override
  void initState() {
    super.initState();
    BackgroundImageHandler.initAssetPath();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      
                child: ListView.builder(
           itemCount: BackgroundImageHandler.imageNames.length,
           itemBuilder: (context,index){
             return GestureDetector(
               onTap: (){widget.onChangeImage(BackgroundImageHandler.imageNames[index]);
                    Navigator.pop(context);
               },
                            child: Padding(
                 padding: const EdgeInsets.all(2.0),
                 child: Image.asset("assets/images/"+BackgroundImageHandler.imageNames[index]),
               ),
             );
           }),
       );
    
  }
}