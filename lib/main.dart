import 'dart:core';

import 'package:flutter/material.dart';

void main() => runApp(FlHomeApp());

class FlHomeApp extends StatelessWidget {
  final Plan plan = Plan();
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'flHome',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home('ViaPiave controls', plan),
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
        turnedON = svVal;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(widget.amb + "." + widget.pl),
        Switch(onChanged: _onChanged, value: turnedON)
      ],
    );
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
    var lightGrids = GridView.count(children: switches, crossAxisCount: 3);
    var card = Card(child: lightGrids);
    return card;
  }
  
}


class Home extends StatefulWidget {
  final Plan plan;
  final String title;
  Map<String, Set<String>> lightsState;

  // Constructor that sets title to the internal variable
  //TODO Maybe read default can be moved before constructor
  Home(this.title, this.plan) {
    lightsState = this.plan.readDefault();
  }


  @override
  State<Home> createState() {
    return HomeState();
  }
}

class HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {
    var cards = List<Widget>();
    for (var amb in widget.lightsState.keys) {
      var lights = widget.lightsState[amb];
      cards.add(AmbientCard(amb, lights));
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: cards,
        ),
      )
    );
  }

}

class Plan {
  
  Map<String, Set<String>> readDefault() {
    Map<String, Set<String>> plan = Map<String, Set<String>>();
    plan['cucina'] = {'principale', 'tavolo', 'fornelli'};
    plan['sala'] = {'principale'};
    plan['bagno'] = {'principale'};
    return plan;
  }
}

