import 'package:blogapp/chat/screens/settings/settings_controller.dart';
import 'package:blogapp/chat/widgets/custom_app_bar.dart';
import 'package:blogapp/chat/widgets/custom_cupertino_sliver_navigation_bar.dart';
import 'package:blogapp/chat/widgets/settings_container.dart';
import 'package:blogapp/chat/widgets/settings_item.dart';
import 'package:blogapp/chat/widgets/user_info_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class Collabs extends StatefulWidget {
  static final String routeName = '/settings';
  @override
  _CollabsState createState() => _CollabsState();
}

class _CollabsState extends State<Collabs> {
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
              title:
                  Text('Collaboration', style: TextStyle(color: Colors.white)),
            ),
            body: Container(
              color: Colors.black87,
              child: SafeArea(
                child: Container(
                  child: ListView(
                    padding: EdgeInsets.all(0),
                    children: <Widget>[
                      //  renderMyUserCard(),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  Widget renderMyUserCard() {
    if (_settingsController.myUser != null) {
      return UserInfoItem(
        name: _settingsController.myUser.name,
        subtitle: "@${_settingsController.myUser.username}",
      );
    }
    return Container();
  }
}
