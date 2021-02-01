import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:blogapp/homepage/body.dart';
import 'package:blogapp/homepage/size_config.dart';

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
