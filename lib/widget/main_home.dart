import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:nhongshoppee/screens/search.dart';
import 'package:nhongshoppee/utility/my_constant.dart';

class MainHome extends StatefulWidget {
  @override
  _MainHomeState createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
  // Field
  List<Widget> listBanner = List();

  // Method
  @override
  void initState() {
    super.initState();
    readBanner();
  }

  Widget group1() {
    return Container(
      width: 80.0,
      height: 100.0,
      child: GestureDetector(
        onTap: () {
          // print('อาหารจานด่วน');
          routhToSearch(1);
        },
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
          color: Colors.yellow,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(
                  Icons.fastfood,
                  size: 48.0,
                  color: Colors.green.shade800,
                ),
                Text('อาหารจานด่วน'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void routhToSearch(int index) {
    MaterialPageRoute materialPageRoute =
        MaterialPageRoute(builder: (BuildContext buildContext) {
      return Search(
        index: index,
      );
    });
    Navigator.of(context).push(materialPageRoute);
  }

  Widget group2() {
    return Container(
      width: 80.0,
      height: 100.0,
      child: GestureDetector(onTap: (){
        routhToSearch(2);
      },
              child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
          color: Colors.lime,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(
                  Icons.group_work,
                  size: 48.0,
                  color: Colors.purple,
                ),
                Text('แกง'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget group3() {
    return Container(
      width: 80.0,
      height: 100.0,
      child: GestureDetector(onTap: (){
        routhToSearch(3);
      },
              child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
          color: Colors.blue,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  child: Image.asset('images/group3.png'),
                  width: 48.0,
                  height: 48.0,
                ),
                Text('ปิ้ง/ย่าง/ทอด'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget group4() {
    return Container(
      width: 80.0,
      height: 100.0,
      child: GestureDetector(onTap: (){
        routhToSearch(4);
      },
              child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
          color: Colors.lightBlue,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(
                  Icons.airline_seat_flat,
                  size: 48.0,
                  color: Colors.green.shade800,
                ),
                Text('Group 1'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget group5() {
    return Container(
      width: 80.0,
      height: 100.0,
      child: GestureDetector(onTap: (){
        routhToSearch(5);
      },
              child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
          color: Colors.indigo,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(
                  Icons.airplay,
                  size: 48.0,
                  color: Colors.green.shade800,
                ),
                Text('Group 1'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget group6() {
    return Container(
      width: 80.0,
      height: 100.0,
      child: GestureDetector(onTap: (){
        routhToSearch(6);
      },
              child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
          color: Colors.pink,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(
                  Icons.brightness_3,
                  size: 48.0,
                  color: Colors.green.shade800,
                ),
                Text('Group 1'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget row1Group() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        group1(),
        group2(),
        group3(),
      ],
    );
  }

  Widget row2Group() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        group4(),
        group5(),
        group6(),
      ],
    );
  }

  Widget groupProduct() {
    return Column(
      children: <Widget>[
        row1Group(),
        row2Group(),
      ],
    );
  }

  Future<void> readBanner() async {
    Response response = await Dio().get(MyConstant().urlBanner);
    // print('response = $response');
    // var result = response.data;
    var result = json.decode(response.data);
    for (var map in result) {
      // for (var map in response) {
      // print('url = ${map['Url]}');
      // print('$map');
      Widget myWidget = Container(
        child: Image.network(map['Url']),
      );
      setState(() {
        listBanner.add(myWidget);
      });
    }
  }

  Widget banner() {
    return Container(
      // color: Colors.grey,
      height: 200.0,
      child: listBanner.length == 0
          ? Center(
              child: CircularProgressIndicator(),
            )
          : CarouselSlider(
              items: listBanner,
              aspectRatio: 16 / 9,
              enlargeCenterPage: true,
              pauseAutoPlayOnTouch: Duration(seconds: 3),
              autoPlay: true,
              autoPlayAnimationDuration: Duration(seconds: 3),
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        banner(),
        groupProduct(),
      ],
    );
  }
}
