import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:nhongshoppee/models/user_model.dart';

class AboutUser extends StatefulWidget {
  @override
  _AboutUserState createState() => _AboutUserState();
}

class _AboutUserState extends State<AboutUser> {
  // Field
  String name, user, password;
  bool status = true;

  // Method

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
            print('Have Space');
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
      print('Register Success');
      setState(() {
        status = false;
      });
    } else {
      print('Cannot Register');
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

  Widget loginButton() {
    return Container(
      width: 250.0,
      child: RaisedButton(
        child: Text('Login'),
        onPressed: () {

          if (user.isEmpty || password.isEmpty) {
            print('Have Space');
          } else {
            checkAuthen();
          }


        },
      ),
    );
  }

  Future<void> checkAuthen()async{
    String url = 'http://www.androidthai.in.th/ong/getUserWhereUser.php?isAdd=true&User=$user';
    Response response = await Dio().get(url);

    if (response.toString() == 'null') {
      print('User False');
    } else {
      var result = json.decode(response.data);

      for (var map in result) {
        UserModel userModel = UserModel.fromJson(map);
        
      }

    }
  }

  Widget authenForm() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          userForm(),
          passwordForm(),
          loginButton(),
        ],
      ),
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
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // return registerForm();
    return status ? registerForm() : authenForm();
  }
}
