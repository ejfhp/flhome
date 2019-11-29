import 'dart:core';
import 'dart:convert';

import 'package:flhome/pubsub.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


Plan planConfig;

void main() async {
 print("main");
 planConfig = Plan(rootBundle);
 bool ok = await planConfig.init();
 print("main, ok is $ok");
 if (ok) {
  runApp(FlHomeApp());
 }
}

class FlHomeApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'flHome',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home('ViaPiave controls', planConfig),
    );
  }
}

class Home extends StatefulWidget {
  String title;
  Plan plan;

  Home(this.title, this.plan);
  
  @override
  State<Home> createState() {
    return HomeState();
  }
}

class HomeState extends State<Home> {
  Plan plan;

  @override
  Widget build(BuildContext context) {
    var cards = List<Widget>();
    var mapPlan = widget.plan.mapPlan;
    for (var amb in mapPlan.keys) {
      var lights = mapPlan[amb];
      cards.add(AmbientCard(amb, lights));
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: ListView( 
          children: cards,
        ),
      )
    );
  }
}

class HomeSwitch extends StatefulWidget {
  final String amb;
  final String pl;

  HomeSwitch(this.amb, this.pl);

  @override
  State<HomeSwitch> createState() {
    return HomeSwitchState();
  }
}

class HomeSwitchState extends State<HomeSwitch> {
  bool turnedON = false;

  void _onChanged(bool svVal) {
    setState(() {
    print("_onChanged($svVal)");
    String command;
      turnedON = !turnedON;
      if (turnedON) {
        command = "TURN_ON";
       } else {
         command = "TURN_OFF";
       }
    String message = buildLightCommandMessage(ambient: widget.amb, light: widget.pl, command: command);
    sendMessage(message);
    });
  }

  @override
  Widget build(BuildContext context) {
    var col = Column(
      children: <Widget>[
        Text(widget.pl),
        Switch(onChanged: _onChanged, value: turnedON)
      ],
    );
    var pad = Padding(
      child: col,
      padding: EdgeInsets.all(8.0),
    );
    // return Container(child: col, height: 15,);
    return pad;
  }
}

class AmbientCard extends StatelessWidget {
  final String ambient;
  final Set<String> lights;

  AmbientCard(this.ambient, this.lights) {
    print("Ambient is $ambient");
  }
  
  @override
  Widget build(BuildContext context) {
    List<Widget> switches = List<Widget>();
    for (var pl in lights) {
      switches.add(HomeSwitch(ambient, pl));
    }
    // var lightGrids = GridView.count(children: switches, crossAxisCount: 3, shrinkWrap: true,);
    // var card = Card(child: lightGrids);
    var title = Text(ambient);
    var swrap = Wrap(children: switches,);
    var room = Column(
      children: <Widget>[
        title,
        swrap,
      ],
    );
    return room;
  }
  
}



class Plan {
  Map<String, Set<String>> mapPlan;
  AssetBundle assetBundle;

  Plan(this.assetBundle);

  Future<bool> init() async {
    print("Init");
    String planJson = await this.assetBundle.loadString('conf/gohome.json');
    Map<String, dynamic> home = jsonDecode(planJson);
    Map<String, dynamic> ambients = home["ambients"];
    this.mapPlan = Map<String, Set<String>>();
    for (String a in ambients.keys) {
      print("Reding ambient $a");
      Map<String, dynamic> ambient = ambients[a];
      Map<String, dynamic> points = ambient["lights"];
      Set<String> pls = Set<String>();
      points.forEach((k, v) {
        pls.add(k);
      });
      mapPlan[a] = pls;
    }
    return true;
  }
}

