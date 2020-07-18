import 'package:flutter/material.dart';
class TextLogo extends StatelessWidget {
  const TextLogo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
 padding: EdgeInsets.only(bottom:40),
      child: Text("CALL\nSTATUS",
style: TextStyle(color: Colors.deepOrangeAccent, fontSize: 40, fontWeight: FontWeight.bold),
textAlign: TextAlign.center,),
    );
  }
}
