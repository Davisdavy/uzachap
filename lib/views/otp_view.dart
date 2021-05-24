import 'package:firebase_auth/firebase_auth.dart';
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

  FirebaseAuth _auth  =FirebaseAuth.instance;

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  void showSnackbar(String message) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(message)));
  }
  void signInWithPhoneNumber() async {
    try {
      final AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: widget.verId,
        smsCode: widget.uid,
      );

      final User user = (await _auth.signInWithCredential(credential)).user;

      showSnackbar("Successfully signed in UID: ${user.uid}");
    } catch (e) {
      showSnackbar("Failed to sign in: " + e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {

  }
}
