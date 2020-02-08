import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:nhongshoppee/utility/my_constant.dart';

class MainHome extends StatefulWidget {
  @override
  _MainHomeState createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
  // Field

  // Method
  @override
  void initState(){
    super.initState();
    readBanner();
  }

  Future<void> readBanner()async{

    Response response = await Dio().get(MyConstant().urlBanner);
    print('response = $response');
  }

  Widget banner() {
    return Container(
      color: Colors.grey,
      height: 200.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        banner(),
      ],
    );
  }
}
