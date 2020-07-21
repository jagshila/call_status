import 'package:flutter/material.dart';
import '../uiComponents/myColors.dart';
import '../handler/firebaseLoginHandler.dart';

class InputWidgetMobile extends StatefulWidget {
  @override
  _InputWidgetMobileState createState() => _InputWidgetMobileState();
}

class _InputWidgetMobileState extends State<InputWidgetMobile> {
  bool mobileNumberField;
  double topRight = 30.0;

  double bottomRight = 0.0;
  String _value;
  TextEditingController textEditingController = new TextEditingController();

  final firebaseLogin = new FirebaseLoginHandler();

  String fieldName;
  String fieldMessage;
  @override
  void initState() {
    super.initState();

    _value = "+91";
    mobileNumberField = true;
    setFieldForMobileNumber();
  }

  setFieldForMobileNumber() {
    fieldName = "Mobile No:";
    fieldMessage = "Please enter your mobile number to continue..";
  }

  setFieldForOTP() {
    fieldName = "One Time Password:";
    fieldMessage = "Please enter OTP to continue..";
    textEditingController.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return mobileNumberWidget();
  }

  String getMobileNumber() {
    return _value + textEditingController.text.toString();
  }

  String getOTP() {
    return textEditingController.text.toString();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    textEditingController.dispose();
    super.dispose();
  }

  mobileNumberWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 40, bottom: 10),
          child: Text(
            fieldName,
            style: TextStyle(fontSize: 16, color: Color(0xFF999A9A)),
          ),
        ),
        Stack(
          alignment: Alignment.bottomRight,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 40, bottom: 30),
              child: Container(
                width: MediaQuery.of(context).size.width - 40,
                child: Material(
                  elevation: 10,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(bottomRight),
                          topRight: Radius.circular(topRight))),
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: 40, right: 20, top: 10, bottom: 10),
                    child: mobileNumberField
                        ? mobileNumberInputField()
                        : otpInputField(),
                  ),
                ),
              ),
            ),
            Padding(
                padding: EdgeInsets.only(right: 50),
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: Padding(
                      padding: EdgeInsets.only(top: 40),
                      child: Text(
                        fieldMessage,
                        textAlign: TextAlign.end,
                        style:
                            TextStyle(color: Color(0xFFA0A0A0), fontSize: 12),
                      ),
                    )),
                    GestureDetector(
                        onTap: () {
                          FocusScope.of(context).requestFocus(FocusNode());

                          print(getMobileNumber());
                          if (mobileNumberField)
                            firebaseLogin.verifyPhoneNumber(
                                context, getMobileNumber());
                          else
                            firebaseLogin.signInWithPhoneNumber(
                                context, getOTP());
                          setState(() {
                            if (mobileNumberField) {
                              setFieldForOTP();
                              mobileNumberField = false;
                            } else {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      CircularProgressIndicator(
                                        backgroundColor: Colors.red,
                                      )
                                    ],
                                  );
                                },
                              );
                            }
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: ShapeDecoration(
                            shape: CircleBorder(),
                            gradient: LinearGradient(
                                colors: signInGradients,
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight),
                          ),
                          child: ImageIcon(
                            AssetImage("assets/images/ic_forward.png"),
                            size: 40,
                            color: Colors.white,
                          ),
                        )),
                  ],
                ))
          ],
        ),
      ],
    );
  }

  mobileNumberInputField() {
    return Row(children: [
      DropdownButtonHideUnderline(
          child: DropdownButton<String>(
        items: <String>['+91', '+1'].map((String value) {
          return new DropdownMenuItem<String>(
            value: value,
            child: new Text(value),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            _value = value;
          });
        },
        value: _value,
        elevation: 2,
        dropdownColor: Colors.white,
        style: TextStyle(
            color: Colors.deepOrange,
            fontSize: 20,
            fontWeight: FontWeight.bold),
        isDense: true,
      )),
      Expanded(
          child: TextField(
        keyboardType: TextInputType.number,
        style: TextStyle(
            color: Colors.deepOrange,
            fontSize: 20,
            fontWeight: FontWeight.bold),
        controller: textEditingController,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "Mobile Number",
            hintStyle: TextStyle(color: Color(0xFFE1E1E1), fontSize: 14)),
      ))
    ]);
  }

  otpInputField() {
    return TextField(
      keyboardType: TextInputType.number,
      style: TextStyle(
          color: Colors.deepOrange, fontSize: 20, fontWeight: FontWeight.bold),
      controller: textEditingController,
      decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "Enter OTP",
          hintStyle: TextStyle(color: Color(0xFFE1E1E1), fontSize: 14)),
    );
  }
}
