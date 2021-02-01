import 'package:blogapp/chat/screens/settings/settings_controller.dart';
import 'package:blogapp/chat/widgets/custom_app_bar.dart';
import 'package:blogapp/chat/widgets/custom_cupertino_sliver_navigation_bar.dart';
import 'package:blogapp/chat/widgets/settings_container.dart';
import 'package:blogapp/chat/widgets/settings_item.dart';
import 'package:blogapp/chat/widgets/user_info_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:blogapp/chat/screens/home/child/otes/home-screen.dart';

import 'package:blogapp/chat/screens/home/child/otes/models/Product.dart';

class OTeS extends StatefulWidget {
  static final String routeName = '/settings';
  @override
  _OTeSState createState() => _OTeSState();
}

class _OTeSState extends State<OTeS> {
  SettingsController _settingsController;

  @override
  void initState() {
    _settingsController = SettingsController(context: context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
        stream: _settingsController.streamController.stream,
        builder: (context, snapshot) {
          return Scaffold(
            backgroundColor: Color(0xFFEEEEEE),
            appBar: AppBar(
              backgroundColor: Colors.black,
              leading: IconButton(
                icon: Icon(MaterialIcons.close, color: Colors.grey),
                onPressed: () => Navigator.of(context).pop(),
              ),
              title: Text('Open Talk e-Series 2021',
                  style: TextStyle(color: Colors.white)),
            ),
            body: Stack(
              children: <Widget>[
                SafeArea(
                  child: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      HomeSscreen(),
                      // Positioned(
                      //   right: 20,
                      //   bottom: 170,
                      //   child: Text(
                      //     "sdsdsd",
                      //     style: TextStyle(
                      //       fontSize: 20.0,
                      //       fontWeight: FontWeight.w700,
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
