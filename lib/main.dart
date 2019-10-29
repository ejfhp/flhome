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
    plan['cucina'] = {'principale': false, 'tavolo': false};
    plan['sala'] = {'principale': false};
    return plan;
  } 

  void _incrementCounter() {
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
    Widget plantColumn = Column(mainAxisAlignment: MainAxisAlignment.center);
    for amb in plan {

    }
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text('Cucina'),
                Icon(Icons.lightbulb_outline)
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text('Sala'),
                Icon(Icons.lightbulb_outline)
              ],
            ),
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
