import 'package:flutter/material.dart';
import 'package:nhongshoppee/models/product_model.dart';
import 'package:nhongshoppee/utility/my_style.dart';

class Detail extends StatefulWidget {
  final ProductModel productModel;

  Detail({Key key, this.productModel}) : super(key: key);

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  // Field
  ProductModel currentProductModel;

  // Method
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentProductModel = widget.productModel;
  }

  Widget orderButton() {
    return FloatingActionButton(
      // backgroundColor: Colors.blue,
      child: Icon(Icons.add),
      onPressed: () {},
    );
  }

  @override
  Widget build(BuildContext context) {
    var text = Text('Price = ${currentProductModel.price}');
    return Scaffold(
      floatingActionButton: orderButton(),
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Text(
              currentProductModel.nameFood,
              style: MyStyle().headTextStyle,
            ),
            Text(
              currentProductModel.detail,
              style: MyStyle().bodyTextStyle,
            ),
            Text(
              'Price = ${currentProductModel.price}',
              style: MyStyle().headColorTextStyle,
            ),
          ],
        ),
      ),
    );
  }
}
