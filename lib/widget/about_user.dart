// import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:nhongshoppee/utility/normal_dialog.dart';
// import 'package:nhongshoppee/models/user_model.dart';
import 'package:nhongshoppee/widget/authen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AboutUser extends StatefulWidget {
  @override
  _AboutUserState createState() => _AboutUserState();
}

class _AboutUserState extends State<AboutUser> {
  // Field
  String name, user, password;
  // bool status = true;
  bool statusFlat = true, statusCheck = true;
  Widget currentWidget;
  String nameLogin;

  // Method

  @override
  void initState() {
    super.initState();
    currentWidget = Authen();
    checkRemember();
  }

  Future<void> checkRemember() async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      bool remember = sharedPreferences.getBool('Remember');
      if (remember) {
        setState(() {
          nameLogin = sharedPreferences.getString('Name');
        });
      }
    } catch (e) {}
  }

  Widget registerButton() {
    return Container(
      width: 250.0,
      child: OutlineButton(
        child: Text('Register'),
        onPressed: () {
          if (name == null ||
              name.isEmpty ||
              user == null ||
              user.isEmpty ||
              password == null ||
              password.isEmpty) {
            // print('Have Space');
            normalDialog(context, 'Have Space', 'Please Fill Every Blank');
          } else {
            registerThread();
          }
        },
      ),
    );
  }

  Future<void> registerThread() async {
    String url =
        'http://www.androidthai.in.th/ong/addUserNhong.php?isAdd=true&Name=$name&User=$user&Password=$password';

    Response response = await Dio().get(url);
    if (response.toString() == 'true') {
      // print('Register Success');
      // setState(() {
      //   status = false;
      // });
      normalDialog(context, 'Congratulation', 'Welcome $name Please Login');
      setState(() {
        currentWidget = Authen();
        statusFlat = !statusFlat;
      });
    } else {
      // print('Cannot Register');
      normalDialog(context, 'Register False', 'Please Try Agains');
    }
  }

  Widget nameForm() {
    return Container(
      child: TextField(
        onChanged: (String string) {
          name = string.trim();
        },
        decoration: InputDecoration(
          hintText: 'Display Name:',
          prefixIcon: Icon(Icons.face),
        ),
      ),
      width: 250.0,
    );
  }

  Widget passwordForm() {
    return Container(
      child: TextField(
        onChanged: (String string) {
          password = string.trim();
        },
        decoration: InputDecoration(
          hintText: 'Password:',
          prefixIcon: Icon(Icons.lock),
        ),
      ),
      width: 250.0,
    );
  }

  Widget userForm() {
    return Container(
      child: TextField(
        onChanged: (String string) {
          user = string.trim();
        },
        decoration: InputDecoration(
          hintText: 'User:',
          prefixIcon: Icon(Icons.account_box),
        ),
      ),
      width: 250.0,
    );
  }

  Widget registerForm() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          nameForm(),
          userForm(),
          passwordForm(),
          registerButton(),
          // loginFlatButton(),
        ],
      ),
    );
  }

  Widget loginFlatButton() {
    return FlatButton(
      onPressed: () {
        setState(() {
          currentWidget = Authen();
        });
      },
      child: Text(
        'Back to Login',
        style: TextStyle(color: Colors.pink),
      ),
    );
  }

  Widget showContent() {
    return currentWidget == null
        ? Center(
            child: CircularProgressIndicator(),
          )
        : currentWidget;
  }

  Widget flatButton() {
    List<String> label = ['New Register', 'Back to Login'];

    return FlatButton(
      onPressed: () {
        setState(() {
          // currentWidget = registerForm();
          if (statusFlat) {
            currentWidget = registerForm();
            statusFlat = !statusFlat;
          } else {
            currentWidget = Authen();
            statusFlat = !statusFlat;
          }
        });
      },
      child: Text(
        statusFlat ? label[0] : label[1],
        style: TextStyle(
          color: Colors.pink,
          fontStyle: FontStyle.italic,
        ),
      ),
    );
  }

  Widget showInfo() {
    var flatButton = FlatButton(
      onPressed: () {},
      child: Text('Sign Out'),
    );
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text('Welcome $nameLogin'),
          FlatButton(
            onPressed: () {
              clearPreference();
            },
            child: Text(
              'Sign Out',
              style: TextStyle(color: Colors.pink),
            ),
          )
        ],
      ),
    );
  }

  Future<void> clearPreference()async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();

    setState(() {
      nameLogin = null;

    });

  }

  @override
  Widget build(BuildContext context) {
    // return registerForm();
    // return status ? registerForm() : showContent();
    return Center(
      child: nameLogin == null ? nonLogin() : showInfo(),
    );
  }

  Column nonLogin() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        showContent(),
        flatButton(),
      ],
    );
  }
}
