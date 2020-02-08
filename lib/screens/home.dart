import 'package:flutter/material.dart';
import 'package:nhongshoppee/utility/my_style.dart';
import 'package:nhongshoppee/widget/about_user.dart';
import 'package:nhongshoppee/widget/basket.dart';
import 'package:nhongshoppee/widget/main_home.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Field
  int index = 0;
  List<Widget> currentWidgets = [
    MainHome(),
    Basket(),
    AboutUser(),
  ];

  // Method
  Widget myBottomNavigator() {
    return BottomNavigationBar(onTap: (int i){
      setState(() {
        index = i;
      });
    },
      currentIndex: index,
      items: <BottomNavigationBarItem>[
      mainHomeNav(),
      basketNav(),
      aboutUserNav(),
    ]);
  }

  BottomNavigationBarItem mainHomeNav() {
    return BottomNavigationBarItem(
      icon: Icon(Icons.home),
      title: Text('หน้าหลัก (Home)'),
    );
  }

  BottomNavigationBarItem basketNav() {
    return BottomNavigationBarItem(
      icon: Icon(Icons.shopping_cart),
      title: Text('ตะกร้า (Basket)'),
    );
  }

  BottomNavigationBarItem aboutUserNav() {
    return BottomNavigationBarItem(
      icon: Icon(Icons.account_box),
      title: Text('User'),
    );
  }

  Widget searchButton() {
    return IconButton(
      icon: Icon(Icons.search),
      onPressed: () {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[searchButton()],
        title: Text(MyStyle().appName),
      ),
      body: currentWidgets[index],
      bottomNavigationBar: myBottomNavigator(),
    );
  }
}
