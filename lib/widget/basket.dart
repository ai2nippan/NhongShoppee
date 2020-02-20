import 'package:flutter/material.dart';
import 'package:nhongshoppee/models/order_model.dart';
import 'package:nhongshoppee/utility/my_style.dart';

class Basket extends StatefulWidget {
  @override
  _BasketState createState() => _BasketState();
}

class _BasketState extends State<Basket> {
  // Field

  List<OrderModel> orderModels = List();

  // Method

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readAllFromSQLite();
  }

  Future<void> readAllFromSQLite() async {
    try {
      OrderHelper orderHelper = OrderHelper();

      var object = await orderHelper.getAllSQLite();

      setState(() {
        orderModels = object;
        print('orderModels.length ==> ${orderModels.length}');
      });
    } catch (e) {}
  }

  Widget showOrder(int index) {
    return Text(
      orderModels[index].order,
      style: MyStyle().paragraphTextStyle,
    );
  }

  Widget showPrice(int index) {
    return Text(orderModels[index].price);
  }

  Widget showVolumn(int index) {
    // return Text(orderModels[index].price);

    int volumn = calculateVolumn(orderModels[index].idOrder);

    return Text('$volumn');
  }

  int calculateVolumn(String idOrder) {
    return 1;
  }

  Widget showListView() {
    return ListView.builder(
      itemCount: orderModels.length,
      itemBuilder: (BuildContext context, int index) {
        // return Text(orderModels[index].order);
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            showOrder(index),
            showPrice(index),
            showVolumn(index),
          ],
        );
      },
    );
  }

  Widget showProgress() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return orderModels.length == 0 ? showProgress() : showListView();
  }
}
