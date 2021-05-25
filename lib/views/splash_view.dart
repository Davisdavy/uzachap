
import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:uzachap/shared/colors.dart';
import 'package:uzachap/views/login_view.dart';

class SplashView extends StatefulWidget {
  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  /*
  Firebase init
   */
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();


  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        //error in the snapshot
        if (snapshot.connectionState == ConnectionState.done) {
          Timer(
              Duration(seconds: 3),
                  () => Navigator.pushReplacement(
                  context,
                  PageTransition(
                      child: LoginView(),
                      type: PageTransitionType.fade)));
          return Scaffold(
            backgroundColor: whiteColor,
            body: Center(
              child: Column(

                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset("assets/uz.png", height: 60.0,),
                ],
              ),
            ),
          );
        }else if(snapshot.hasError){
          return Scaffold(
            backgroundColor: whiteColor,
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset("assets/uz.png"),
                ],
              ),
            ),
          );
        }
        return Scaffold(
          backgroundColor: whiteColor,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset("assets/uz.png"),
              ],
            ),
          ),
        );
      }

    );
  }
}