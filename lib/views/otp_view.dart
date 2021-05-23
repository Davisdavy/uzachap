import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:uzachap/shared/colors.dart';
import 'package:uzachap/views/towns_view.dart';
import 'package:uzachap/widgets/custom_btn.dart';
import 'package:uzachap/widgets/custom_input.dart';

class OTPView extends StatefulWidget {
  OTPView({Key key, this.verId, this.uid}): super(key: key);
  //update the constructor to include the uid
  final String uid, verId; //include this
  @override
  _OTPViewState createState() => _OTPViewState();
}

class _OTPViewState extends State<OTPView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/back.png"), fit: BoxFit.cover),
          ),
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  Image.asset("assets/car.png", width: MediaQuery.of(context).size.width,),
              SizedBox(height: 90,),
              Column(children: [
                Text("Enter the code here", style: TextStyle(color: darkText.withOpacity(0.5), fontSize: 18.0, wordSpacing: 3.0, fontWeight: FontWeight.w500),),
                SizedBox(height: 10.0),
                Align(
                  alignment: Alignment.center,
                    child: Image.asset("assets/arrow.png", height: 12,)),
                ],

              ),
                  SizedBox(height: 10.0),
                  CustomInput(
                    hintText: '70 000 000 00',
                    textInputAction: TextInputAction.done,
                  ),
                  SizedBox(height: 10.0),
                  Text("Only correct code will log you in!", style: TextStyle(color: darkText.withOpacity(0.5), fontSize: 16.0, wordSpacing: 2.0, fontWeight: FontWeight.w500),),
                  SizedBox(height: 20.0),
                  CustomBtn(
                    text: "Verify",
                    onPressed: () {
                      Navigator.push(
                          context,
                          PageTransition(
                              child: TownsView(),
                              type: PageTransitionType.fade));
                    },
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: Text("Uzachap", style: TextStyle(color: darkText.withOpacity(0.5), fontSize: 12.0, wordSpacing: 0.5, fontWeight: FontWeight.w300),)),
              ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
