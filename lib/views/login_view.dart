import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:uzachap/shared/colors.dart';
import 'package:uzachap/views/otp_view.dart';
import 'package:uzachap/widgets/custom_btn.dart';
import 'package:uzachap/widgets/custom_input.dart';

import 'towns_view.dart';

enum MobileVerificationState {
  SHOW_MOBILE_FORM_STATE,
  SHOW_OTP_FORM_STATE,
}
class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  MobileVerificationState currentState =
      MobileVerificationState.SHOW_MOBILE_FORM_STATE;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  FirebaseAuth _auth  =FirebaseAuth.instance;



  // Default Form Loading State
  bool _loginFormLoading = false;

  String _verificationId;

  // Form Input Field Values
  String _phoneNumEditingController = "";
  String otpController = "";
  // Focus Node for input fields
  FocusNode _phoneFocusNode;

  void signInWithPhoneAuthCredential(
      PhoneAuthCredential phoneAuthCredential) async {
    setState(() {
      _loginFormLoading = true;
    });

    try {
      final authCredential =
      await _auth.signInWithCredential(phoneAuthCredential);

      setState(() {
        _loginFormLoading = false;
      });

      if(authCredential?.user != null){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> TownsView()));
      }

    } on FirebaseAuthException catch (e) {
      setState(() {
        _loginFormLoading = false;
      });

      _scaffoldKey.currentState
          .showSnackBar(SnackBar(content: Text(e.message)));
    }
  }
  @override
  void initState() {
    _phoneFocusNode = FocusNode();
    super.initState();

  }
  @override
  void dispose() {
    _phoneFocusNode.dispose();
    super.dispose();
  }

  getMobileFormWidget(context){
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
                  SizedBox(
                    height: 50,
                  ),
                  Image.asset("assets/logo-white.png",),
                  Text("Uzachap", style: TextStyle(color: whiteColor.withOpacity(0.4),fontSize: 30.0, fontWeight: FontWeight.bold),),
                  SizedBox(height: 90,),
                  Column(children: [
                    Text("Enter your mobile phone", style: TextStyle(color: darkText.withOpacity(0.5), fontSize: 18.0, wordSpacing: 3.0, fontWeight: FontWeight.w500),),
                    SizedBox(
                      height: 5,
                    ),
                    Text("number to login", style: TextStyle(color: darkText.withOpacity(0.5), fontSize: 18.0,  wordSpacing: 3.0, fontWeight: FontWeight.w500)),
                  ],
                  ),
                  Row(

                    children: [
                      Container(
                        width: 95.0,
                        margin: EdgeInsets.symmetric(
                          vertical: 8.0,
                          horizontal: 24.0,
                        ),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade400, width: 1.6),
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(8.0)
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "+254",
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 24.0,
                                vertical: 18.0,
                              )
                          ),
                        ),
                      ),
                      Flexible(
                        child: CustomInput(
                          onChanged: (value) {
                            _phoneNumEditingController = value;
                          },
                          onSubmitted: (value) {
                            _phoneFocusNode.requestFocus();
                          },
                          hintText: '70 000 000 00',
                          textInputAction: TextInputAction.done,
                        ),
                      ),

                    ],
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  CustomBtn(
                    text: "Get OTP",
                    onPressed: () async {
                      setState(() {
                        _loginFormLoading = true;
                      });
                      await _auth.verifyPhoneNumber(
                          phoneNumber: "+254"+_phoneNumEditingController,
                          verificationCompleted: (phoneAuthCredential) async{
                            setState(() {
                              _loginFormLoading = false;
                            });
                          },
                          verificationFailed: (verificationFailed) async{
                            setState(() {
                              _loginFormLoading = false;
                            });
                            _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(verificationFailed.message),));
                          },
                          codeSent: (_verificationId, resendingToken) async{
                            setState(() {
                              _loginFormLoading = false;
                              currentState = MobileVerificationState.SHOW_OTP_FORM_STATE;
                              this._verificationId = _verificationId;
                            });
                          },
                        codeAutoRetrievalTimeout: (verificationId) async{

                        }
                      );
                    },
                    isLoading: _loginFormLoading,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text("A six digit code will be sent to you", style: TextStyle(color: darkText.withOpacity(0.5), fontSize: 16.0, wordSpacing: 0.5, fontWeight: FontWeight.w500),),
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

  getOtpFormWidget(context){
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
                    hintText: '  000 000  ',
                    textInputAction: TextInputAction.done,
                    onChanged: (value){
                      otpController = value;
                    },
                    focusNode: _phoneFocusNode,
                    onSubmitted: (value){
                      _phoneFocusNode.requestFocus();
                    },

                  ),
                  SizedBox(height: 10.0),
                  Text("Only correct code will log you in!", style: TextStyle(color: darkText.withOpacity(0.5), fontSize: 16.0, wordSpacing: 2.0, fontWeight: FontWeight.w500),),
                  SizedBox(height: 20.0),
                  CustomBtn(
                    text: "Verify",
                    onPressed: () async {
                      PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(verificationId: _verificationId, smsCode: otpController);
                      signInWithPhoneAuthCredential(phoneAuthCredential);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        child: _loginFormLoading ? Center(
          child: CircularProgressIndicator(),
        ) : currentState == MobileVerificationState.SHOW_MOBILE_FORM_STATE
        ? getMobileFormWidget(context)
        : getOtpFormWidget(context),
      ),
    );

  }
}
