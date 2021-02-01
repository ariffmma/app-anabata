import 'package:blogapp/chat/screens/home/home_controller.dart';
import 'package:blogapp/chat/screens/settings/settings_view.dart';
import 'package:blogapp/chat/widgets/chat_card.dart';
import 'package:blogapp/chat/widgets/custom_app_bar.dart';
import 'package:blogapp/chat/widgets/custom_cupertino_sliver_navigation_bar.dart';
import 'package:blogapp/chat/widgets/user_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

import 'package:blogapp/chat/screens/settings/settings_controller.dart';
import 'package:blogapp/chat/widgets/custom_app_bar.dart';
import 'package:blogapp/chat/widgets/custom_cupertino_sliver_navigation_bar.dart';
import 'package:blogapp/chat/widgets/settings_container.dart';
import 'package:blogapp/chat/widgets/settings_item.dart';
import 'package:blogapp/chat/widgets/user_info_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class Chat extends StatefulWidget {
  static final String routeName = '/settings';
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  SettingsController _settingsController;

  _showModalBottomSheet(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Scaffold(
          backgroundColor: Color(0xFFEEEEEE),
          appBar: AppBar(
            backgroundColor: Colors.white,
            leading: IconButton(
              icon: Icon(MaterialIcons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: Text('Profile', style: TextStyle(color: Colors.black)),
          ),
          body: SafeArea(
            child: Container(
              child: ListView(
                padding: EdgeInsets.all(0),
                children: <Widget>[
                  renderMyUserCard(),
                  SizedBox(
                    height: 30,
                  ),
                  SettingsContainer(
                    children: [
                      SettingsItem(
                        icon: MaterialIcons.delete,
                        iconBackgroundColor: Colors.grey,
                        title: 'Delete conversations',
                        onTap: _settingsController.openModalDeleteChats,
                      ),
                      SettingsItem(
                        icon: MaterialIcons.exit_to_app,
                        iconBackgroundColor: Colors.red,
                        title: 'Log Out',
                        onTap: _settingsController.openModalExitApp,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  int currentState = 0;

  HomeController _homeController;

  @override
  void initState() {
    _settingsController = SettingsController(context: context);
    super.initState();
    _homeController = HomeController(context: context);
  }

  @override
  void dispose() {
    _homeController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    _homeController.initProvider();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
      stream: _homeController.streamController.stream,
      builder: (context, snapshot) {
        return Scaffold(
          body: Stack(children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 35, horizontal: 24),
              child: Row(
                children: <Widget>[
                  Text(
                    'anabata',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Spacer(),
                  IconButton(
                    icon: Icon(MaterialIcons.menu),
                    onPressed: () {
                      _showModalBottomSheet(context);
                      // Navigator.of(context).pushNamed(SettingsScreen.routeName);
                    },
                  ),
                  Divider(
                    color: Colors.black,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 50),
              child: SafeArea(
                child: usersList(context),
              ),
            ),
          ]),
        );
      },
    );
  }

  Widget usersList(BuildContext context) {
    // if (_homeController.loading) {
    //   return SliverFillRemaining(
    //     child: Center(
    //       child: CupertinoActivityIndicator(),
    //     ),
    //   );
    // }
    // if (_homeController.error) {
    //   return SliverFillRemaining(
    //     child: Center(
    //       child: Text('Ocorreu um erro ao buscar suas conversas.'),
    //     ),
    //   );
    // }
    if (_homeController.chats.length == 0) {
      return Center(
        child: Text('You have no conversations.'),
      );
    }
    bool theresChatsWithMessages = _homeController.chats.where((chat) {
          return chat.messages.length > 0;
        }).length >
        0;
    if (!theresChatsWithMessages) {
      return Center(
        child: Text('You dont have conversations.'),
      );
    }
    return ListView.builder(
      itemCount: 1,
      itemBuilder: (BuildContext context, int index) {
        return Column(
          children: _homeController.chats.map((chat) {
            if (chat.messages.length == 0) {
              return Container(height: 0, width: 0);
            }
            return Column(
              children: <Widget>[
                ChatCard(
                  chat: chat,
                ),
              ],
            );
          }).toList(),
        );
      },
    );
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
