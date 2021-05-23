import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:uzachap/shared/colors.dart';
import 'package:uzachap/views/otp_view.dart';
import 'package:uzachap/widgets/custom_btn.dart';
import 'package:uzachap/widgets/custom_input.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  FirebaseAuth auth = FirebaseAuth.instance;

  SmsAutoFill smsAutoFill = SmsAutoFill();

  // Default Form Loading State
  bool _loginFormLoading = false;

  String _verificationId;

  // Form Input Field Values
  String _phoneNumEditingController = "";
  // Focus Node for input fields
  FocusNode _phoneFocusNode;
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

  void verifyPhoneNumber() async{
    print("*************************************+254$_phoneNumEditingController");

    //Callback for when the user has already previously signed in with this phone number on this device
    PhoneVerificationCompleted verificationCompleted =
        (PhoneAuthCredential phoneAuthCredential) async {

      await auth.signInWithCredential(phoneAuthCredential);
      showSnackbar("Phone number automatically verified");
    };

    //Listens for errors with verification, such as too many attempts
    PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException authException) {
      showSnackbar('Phone number verification failed.');
    };

    //Callback for when the code is sent
    PhoneCodeSent codeSent =
        (String verificationId, [int forceResendingToken]) async {
      showSnackbar('Please check your phone for the verification code.');
      _verificationId = verificationId;
    };

    PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      showSnackbar("verification code: " + verificationId);
      _verificationId = verificationId;
    };

    try {
      await auth.verifyPhoneNumber(
          phoneNumber: "+254"+_phoneNumEditingController,
          timeout: const Duration(seconds: 5),
          verificationCompleted: verificationCompleted,
          verificationFailed: verificationFailed,
          codeSent: codeSent,
          codeAutoRetrievalTimeout: codeAutoRetrievalTimeout).then((value){
        Navigator.push(
            context,
            PageTransition(
                child: OTPView(
                  verId: _verificationId,
                  uid: FirebaseAuth.instance
                      .currentUser.uid,
                ),
                type: PageTransitionType.rightToLeft));
      });
    } catch (e) {
      showSnackbar("Failed to Verify Phone Number");
    }
  }

  void showSnackbar(String message) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(message)));
  }

void signInWithPhoneNumber(){

}

  @override
  Widget build(BuildContext context) {


    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
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
                      verifyPhoneNumber();

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
}
