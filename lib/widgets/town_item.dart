import 'package:flutter/material.dart';
import 'package:uzachap/models/town.dart';
import 'package:uzachap/shared/colors.dart';

class TownItem extends StatefulWidget {
  TownItem({this.item});
  final Town item;

  @override
  _TownItemState createState() => _TownItemState();
}

class _TownItemState extends State<TownItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(2),
        height: 140,
        child: Card(
          elevation: 5,
          child: Column(
            children: [
              Text("${this.widget.item.townName}", style: TextStyle(color: darkText,fontSize: 20.0),),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("${this.widget.item.townName}", style: TextStyle(color: darkText,fontSize: 15.0),),
                  CircleAvatar(
                    backgroundColor: bgColor,
                    child: Image.asset("assets/fly.png"),
                  )
                ],
              ),
              Text("${this.widget.item.townName}", style: TextStyle(color: darkText,fontSize: 15.0),),
            ],
          )
        ));
  }
}