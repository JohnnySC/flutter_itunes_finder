import 'package:flutter/material.dart';
import 'package:itunes_finder/presentation/SearchTracksWidget.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Itunes Finder',
        theme: ThemeData(
          primarySwatch: Colors.purple,
        ),
        home: Scaffold(
            appBar: AppBar(
              title: Text('Itunes Finder'),
            ),
            body: new SearchTracksWidget()));
  }
}
