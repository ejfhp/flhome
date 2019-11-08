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
  String ambient;
  List<String> lights;

  AmbientCard(this.ambient, this.lights) {
  }
  
  @override
  Widget build(BuildContext context) {
    List<Widget> switches = List<Widget>()
    for (var pl in lights) {
      switches.add(HomeSwitch(ambient, pl));
    }
    var lightGrids = GridView.count(children: switches, crossAxisCount: 3);
    var card = Card(child: lightGrids);
    return card;
  }
  
}


class Home extends StatelessWidget {
  final Plan plan;
  final String title;
  Map<String, Map<String, bool>> lightsState;

  // Constructor that sets title to the internal variable
  Home(this.title, this.plan) {
    lightsState = this.plan.readDefault();
  }

  @override
  Widget build(BuildContext context) {
    var cards = List<Widget>();
    for (var amb in this.lightsState.keys) {
      var lights = this.lightsState[amb];
      cards.add(AmbientCard(amb, lights.keys));
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(this.title),
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
  
  Map<String, Map<String, bool>> readDefault() {
    Map<String, Map<String, bool>> plan = Map<String, Map<String, bool>>();
    plan['cucina'] = {'principale': false, 'tavolo': false, 'fornelli': false};
    plan['sala'] = {'principale': false};
    plan['bagno'] = {'principale': false};
    return plan;
  }
}

