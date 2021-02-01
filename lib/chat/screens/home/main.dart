import 'package:flutter/material.dart';
import 'package:blogapp/chat/screens/home/main_page.dart';
import 'package:blogapp/chat/screens/home/styles.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: MainPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
