import 'package:flutter/material.dart';

class Search extends StatefulWidget {

  final int index;
  // final String name;
  // Search({Key key, this.index,this.name}):super(key: key);
  Search({Key key, this.index}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {

  // Field
  int currentIndex;

  // Method
  @override
  void initState() {
    
    super.initState();
    currentIndex = widget.index;
    print('currentIndex = $currentIndex');
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
    );
  }
}
