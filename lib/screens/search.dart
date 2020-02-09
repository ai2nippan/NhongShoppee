import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:nhongshoppee/models/product_model.dart';
import 'package:nhongshoppee/utility/my_constant.dart';

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

  ListView showListView() {
    return ListView.builder(
        itemCount: productModels.length,
        itemBuilder: (BuildContext buildContext, int index) {
          return Text(productModels[index].nameFood);
        });
  }
}
