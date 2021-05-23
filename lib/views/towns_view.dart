import 'package:flutter/material.dart';
import 'package:uzachap/shared/colors.dart';

class TownsView extends StatefulWidget {
  @override
  _TownsViewState createState() => _TownsViewState();
}

class _TownsViewState extends State<TownsView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: bgColor,
          title: Text("Hello Driver! Where to?"),
          automaticallyImplyLeading: false,
          elevation: 0,
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset("assets/logout.png", width: 25,),
            ),
          ],
        ),
        body: Container(
    height: MediaQuery.of(context).size.height,
    width: MediaQuery.of(context).size.width,
    decoration: BoxDecoration(
    image: DecorationImage(
    image: AssetImage("assets/wh.png"), fit: BoxFit.cover),
    ),
        )
      ),
    );
  }
}
