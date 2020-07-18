import 'package:flutter/material.dart';
import '../uiComponents/wavyHeader.dart';
import '../uiComponents/wavyFooter.dart';
class Background extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          new Stack(
            alignment: Alignment.bottomCenter,
            children: <Widget>[
               // Image.asset('assets/images/collaboration.png', width: MediaQuery.of(context).size.width/1.5,),
//TextLogo(),
              WavyHeader(),
            ],
          ),
          Expanded(
            child: Container(
            ),
          ),
          Expanded(
                      child: Stack(
              alignment: Alignment.bottomLeft,
              children: <Widget>[
                WavyFooter(),
                CirclePink(),
                CircleYellow(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
