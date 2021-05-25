import 'package:flutter/material.dart';
import 'package:uzachap/models/town.dart';
import 'package:uzachap/widgets/town_item.dart';

class TownList extends StatelessWidget {
  final List<Town> items;

  TownList({Key key, this.items});
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return TownItem(item: items[index]);
      },
    );
  }
}