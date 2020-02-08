import 'package:flutter/material.dart';
import 'package:nhongshoppee/utility/my_style.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Field

  // Method
  Widget searchButton(){
    return IconButton(icon: Icon(Icons.search), onPressed: (){},);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: <Widget>[searchButton()],
        title: Text(MyStyle().appName),
      ),
    );
  }
}
