import 'package:flutter/material.dart';
import 'dart:async';

class MyTimerDisplay extends StatefulWidget {
  final int timeToDisplay;
  final TextStyle style;
  MyTimerDisplay({Key key,this.timeToDisplay,this.style}) : super(key: key);

  @override
  _MyTimerDisplayState createState() => _MyTimerDisplayState();
}

class _MyTimerDisplayState extends State<MyTimerDisplay> {
  int timeLeft;
String timeString="Time";
  @override
  void initState() {
    timeLeft=widget.timeToDisplay;
    Timer.periodic(Duration(seconds: 1), (Timer t) => _getTime());
    super.initState();
  }

     @override
   void setState(fn) {
    if(mounted){
      super.setState(fn);
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
       child: Text(timeString,
       style: widget.style,
       ),
    );
  }


  _getTime() {
    if(timeLeft!=null)
    if(timeLeft>0)
{timeLeft--;
Duration duration= Duration(seconds: timeLeft);
  String twoDigits(int n) => n.toString().padLeft(2, "0");
  String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
  String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));

  setState(() {
      timeString= "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";

  });
}
else if(timeLeft==0)
setState(() {
  timeString="Ready";
});
}
}


/*
main() {
  runApp(MaterialApp(
    home:Scaffold(
      body:Center(child: MyTimerDisplay(timeToDisplay:380000))
    )
  ));
}*/