import 'package:flutter/material.dart';
import '../uiComponents/wavyHeader.dart';
import '../uiComponents/wavyFooter.dart';

class Background extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      body: 
               Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                  colors: [
                    Colors.white,
                    Colors.white24,
               
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight)
          ),
        
      )
    );
  }
}



class Background1 extends StatelessWidget {
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
