import 'package:flutter/material.dart';
import 'package:nhongshoppee/screens/home.dart';
import 'package:nhongshoppee/utility/my_style.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.deepOrange),
      title: MyStyle().appName,
      home: Home(),
    );
  }
}
