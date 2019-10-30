import 'dart:core';

import 'package:flutter/material.dart';

void main() => runApp(FlHomeApp());

class FlHomeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'flHome',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeStatus(title: 'ViaPiave controls'),
    );
  }
}

class HomeStatus extends StatefulWidget {
  // Constructor that sets title to the internal variable
  HomeStatus({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomeState createState() => _HomeState();
}


class _HomeState extends State<HomeStatus> {
  int _counter;

  Map _buildPlan() {
    Map<String, Map<String, bool>> plan = Map<String, Map<String, bool>>();
    plan['cucina'] = {'principale': false, 'tavolo': false, 'fornelli': false};
    plan['sala'] = {'principale': false};
    plan['bagno'] = {'principale': false};
    return plan;
  } 

  void _buttonPressed() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    Map<String, Map<String, bool>> plan = _buildPlan();
    var rows = List<Widget>();
    for (var amb in plan.keys) {
      var lights = plan[amb];
      var colsBulb = List<Widget>(); 
      for (var lig in lights.keys) {
        var l = Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(lig),
            IconButton(
              icon: Icon(Icons.lightbulb_outline),
              tooltip: lig,
              onPressed: _buttonPressed)
            ]
        );
        colsBulb.add(l);
      }
      var bulbsRow = Row(children: colsBulb);
      var row = Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Text(amb),
          bulbsRow
        ],
      );
      rows.add(row);
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: rows,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _buttonPressed,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
