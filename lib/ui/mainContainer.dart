import 'package:flutter/material.dart';
import 'package:callstatus/uiComponents/background.dart';
class MainContainer extends StatelessWidget {
  final Widget content;
  const MainContainer({Key key, this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
          children: <Widget>[
              Background(),
              content
          ],
      ),
    );
  }
}