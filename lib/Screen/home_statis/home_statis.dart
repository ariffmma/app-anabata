import 'package:flutter/material.dart';
import 'package:blogapp/screen/home_statis/first.dart';
import 'package:blogapp/screen/home_statis/textLogin.dart';
import 'package:blogapp/screen/home_statis/button.dart';
import 'package:blogapp/screen/home_statis/verticalText.dart';

import 'package:blogapp/homepage/home-screen.dart';
import 'package:blogapp/homepage/title_text.dart';
import 'package:blogapp/homepage/service/fetchCategories.dart';
import 'package:blogapp/homepage/service/fetchProducts.dart';

import 'package:blogapp/homepage/categories.dart';
import 'package:blogapp/homepage/recommond_products.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Colors.grey, Colors.black87]),
        ),
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                Row(children: <Widget>[
                  VerticalText(),
                  TextLogin(),
                ]),
                ButtonLogin(),
                FirstTime(),

                //HomeSscreen(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
