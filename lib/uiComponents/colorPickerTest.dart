import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Material Color Picker",
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Use temp variable to only update color when press dialog 'submit' button
  ColorSwatch _tempMainColor;
  Color _tempShadeColor;
  ColorSwatch _mainColor = Colors.blue;
  Color _shadeColor = Colors.blue[800];

  void _openDialog( Widget content) {

   showModalBottomSheet(
barrierColor: Color.fromARGB(1, 0, 0, 0),
backgroundColor: Color.fromARGB(50, 200, 10, 100),
    // elevation: 0,
     context: context, builder: (context){
      return Container(
        height: 230,
        child:Stack(
        children: <Widget>[
Align(
  alignment: Alignment.topRight,
  child: IconButton(icon: Icon(Icons.close),
  iconSize: 30,
  color: Colors.black87,
  onPressed: ()=>Navigator.pop(context),),

),
Column(children: <Widget>[
SizedBox(height: 10,),
Container(
height: 220,
            
            child: Center(child: content,
),
 

)

],),

        ],
            
          ));
    });
    /*
Navigator.of(context).push(
                  PageRouteBuilder(
                      pageBuilder: (context, _, __) => AlertDialog(
          backgroundColor: Colors.transparent,
          contentPadding: const EdgeInsets.all(6.0),
         // elevation: 0,
        //  title: Text(title),
          content: Container(
            height: 120,
            
            child: content
          ),
          actions: [
       
            FlatButton(
              child: Text('SUBMIT'),
              onPressed: () {
                Navigator.of(context).pop();
                setState(() => _mainColor = _tempMainColor);
                setState(() => _shadeColor = _tempShadeColor);
              },
            ),
          ],
        ),
                      opaque: false),
);

    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          contentPadding: const EdgeInsets.all(6.0),
          elevation: 0,
          title: Text(title),
          content: Container(
            height: 120,
            
            child: content
          ),
          actions: [
       
            FlatButton(
              child: Text('SUBMIT'),
              onPressed: () {
                Navigator.of(context).pop();
                setState(() => _mainColor = _tempMainColor);
                setState(() => _shadeColor = _tempShadeColor);
              },
            ),
          ],
        );
      },
    );*/
  }

 

  void _openFullMaterialColorPicker() async {
    _openDialog(
      MaterialColorPicker(
        colors: fullMaterialColors,
        selectedColor: _mainColor,
                onColorChange: (color) => setState(() { _tempShadeColor = color;
                }),

        onMainColorChange: (color) => setState(() { _tempMainColor = color;
                     //   Navigator.pop(context);

        }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    
    int intColor=_tempShadeColor==null?_shadeColor.value:_tempShadeColor.value;
    print("Color:"+intColor.toString());
    Color myColorMain = new Color(intColor);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Material color picker",
            style: Theme.of(context).textTheme.headline,
          ),
          const SizedBox(height: 62.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: _tempMainColor,
                radius: 35.0,
                child: const Text("MAIN"),
              ),
              const SizedBox(width: 16.0),
              CircleAvatar(
                backgroundColor: myColorMain,
                radius: 35.0,
                child: const Text("SHADE"),
              ),
            ],
          ),
          
          const SizedBox(height: 16.0),
          OutlineButton(
            onPressed: _openFullMaterialColorPicker,
            child: const Text('Show full material color picker'),
          ),
        ],
      ),
    );
  }
}