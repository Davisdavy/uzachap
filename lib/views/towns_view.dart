
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uzachap/models/town.dart';
import 'package:uzachap/shared/colors.dart';
import 'package:uzachap/views/login_view.dart';
import 'package:uzachap/widgets/town_list.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TownsView extends StatefulWidget {
  final String townName;
  final Future<List<Town>> towns;

  TownsView({Key key, this.townName, this.towns}) : super(key: key);

  @override
  _TownsViewState createState() => _TownsViewState();
}

class _TownsViewState extends State<TownsView> {
  final _auth = FirebaseAuth.instance;
  List<Town> decodeFruit(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Town>((json) => Town.fromMap(json)).toList();
  }
  getData()async{
    final response = await http.get(Uri.parse("https://uzachap.000webhostapp.com/uzachapApis/townsAPI.php"));
    if (response.statusCode == 200) {
      //display UI
      return decodeFruit(response.body);
    }
    else {
      //Show Error Message
      throw Exception('Unable to fetch products from the REST API');
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }
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
                child: InkWell(
                    onTap: () async {
                      await _auth.signOut();
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => LoginView()));
                    },
                    child: Image.asset(
                      "assets/logout.png",
                      width: 25,
                    )),
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
            child: Center(
              child: FutureBuilder<List<Town>>(
                  future: widget.towns,
                  builder: (context, snapshot){
                    if(snapshot.hasError) print(snapshot.error);
                    return snapshot.hasData
                        ? TownList(items: snapshot.data,)
                        : Center(child: CircularProgressIndicator(),);
                  }),
            ),
          ),
      ),
    );
  }
}
