import 'dart:convert';

import 'package:blogapp/Pages/HomePage.dart';
import 'package:blogapp/Pages/SignUpPage.dart';
import "package:flutter/material.dart";

import '../NetworkHandler.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:blogapp/zoom/zoom.dart';
import 'package:blogapp/daftar/form/name.dart';

class SignInZoom extends StatefulWidget {
  SignInZoom({Key key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInZoom> {
  bool vis = true;
  final _globalkey = GlobalKey<FormState>();
  NetworkHandler networkHandler = NetworkHandler();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController()
    ..text = 'anabata';
  String errorText;
  bool validate = false;
  bool circular = false;
  final storage = new FlutterSecureStorage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: SafeArea(
        child: Container(
          child: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  key: _globalkey,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    SizedBox(
                      height: 40,
                    ),
                    Text(
                      'Please enter valid email',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      '',
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                    TextFormField(
                      cursorColor: Theme.of(context).primaryColor,
                      controller: _usernameController,
                      decoration: InputDecoration(labelText: 'Username'),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    InkWell(
                      onTap: () async {
                        setState(() {
                          circular = true;
                        });

                        //Login Logic start here
                        Map<String, String> data = {
                          "username": _usernameController.text,
                          "password": _passwordController.text,
                        };
                        var response =
                            await networkHandler.post("/user/login", data);

                        if (response.statusCode == 200 ||
                            response.statusCode == 201) {
                          Map<String, dynamic> output =
                              json.decode(response.body);
                          print(output["token"]);
                          await storage.write(
                              key: "token", value: output["token"]);
                          setState(() {
                            validate = true;
                            circular = false;
                          });
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => JoinWidget(),
                              ),
                              (route) => false);
                        } else {
                          String output = json.decode(response.body);
                          setState(() {
                            validate = false;
                            errorText = output;
                            circular = false;
                          });
                        }

                        // login logic End here
                      },
                      child: Container(
                        width: 150,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xff00A86B),
                        ),
                        child: Center(
                          child: circular
                              ? CircularProgressIndicator()
                              : Text(
                                  "Sign In",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: false,
                      child: TextFormField(
                        cursorColor: Theme.of(context).primaryColor,
                        controller: _passwordController,
                        decoration: InputDecoration(labelText: 'Password'),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MyHomePage()),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            'Has not registered for the Open Talk e-Series? Register.',
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
