import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:nhongshoppee/models/product_model.dart';
import 'package:nhongshoppee/screens/detail.dart';
import 'package:nhongshoppee/utility/my_constant.dart';
import 'package:nhongshoppee/utility/my_style.dart';

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
  List<ProductModel> productModels = List();
  // List<ProductModel> productModels = []; same above

  // Method
  @override
  void initState() {
    super.initState();
    currentIndex = widget.index;
    print('currentIndex = $currentIndex');
    readData();
  }

  Future<void> readData() async {
    try {
      Response response =
          await Dio().get(MyConstant().groupProducts[currentIndex]);
      // print('response = $response');

      var result = json.decode(response.data);

      // print('result = $result');

      for (var map in result) {
        print('map = $map');
        ProductModel productModel = ProductModel.fromJSON(map);
        setState(() {
          productModels.add(productModel);
        });
      }
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      // body: showListView(),
      body: productModels.length == 0
          ? Center(
              child: CircularProgressIndicator(),
            )
          : showListView(),
    );
  }

  Widget showName(int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Text(
          productModels[index].nameFood,
          style: MyStyle().headTextStyle,
        ),
      ],
    );
  }

  Widget showDetail(int index) {
    String string = productModels[index].detail;
    if (string.length > 50) {
      string = string.substring(0, 49);
      string = '$string ...';
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
            width: MediaQuery.of(context).size.width - 30,
            child: Text(
              string,
              style: MyStyle().bodyTextStyle,
            )),
      ],
    );
  }

  ListView showListView() {
    return ListView.builder(
        itemCount: productModels.length,
        itemBuilder: (BuildContext buildContext, int index) {
          // return Text(productModels[index].nameFood);
          return Container(
            width: MediaQuery.of(context).size.width,
            height: 150.0,
            child: GestureDetector(
              onTap: () {
                // MaterialPageRoute materialPageRoute = MaterialPageRoute(builder: (BuildContext buildContext) {return Detail();});
                MaterialPageRoute materialPageRoute = MaterialPageRoute(
                    builder: (BuildContext buildContext) => Detail(productModel: productModels[index],));
                    Navigator.of(context).push(materialPageRoute);
              },
              child: Card(
                color: index % 2 == 0
                    ? Colors.yellow.shade100
                    : Colors.yellow.shade400,
                child: Container(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      showName(index),
                      showDetail(index),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
