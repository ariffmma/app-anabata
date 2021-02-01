import 'package:flutter/material.dart';
import 'package:blogapp/chat/screens/home/child/otes/body.dart';
import 'package:blogapp/chat/screens/home/child/otes/size_config.dart';

class HomeSscreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // It help us to  make our UI responsive
    SizeConfig().init(context);
    return Scaffold(
      body: Body(),
    );
  }
}
