import 'package:blogapp/chat/screens/home/home_controller.dart';
import 'package:blogapp/chat/screens/settings/settings_view.dart';
import 'package:blogapp/chat/widgets/chat_card.dart';
import 'package:blogapp/chat/widgets/custom_app_bar.dart';
import 'package:blogapp/chat/widgets/custom_cupertino_sliver_navigation_bar.dart';
import 'package:blogapp/chat/widgets/user_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:blogapp/homepage/home-screen.dart';
import 'package:blogapp/Screen/live.dart';
import 'package:blogapp/YT/home_screen.dart';
import 'package:blogapp/chat/screens/home/chat.dart';
import 'package:blogapp/Profile/ProfileScreen.dart';
import 'package:flutter_icons/flutter_icons.dart';

import 'package:blogapp/chat/screens/settings/settings_controller.dart';
import 'package:blogapp/chat/widgets/custom_app_bar.dart';
import 'package:blogapp/chat/widgets/custom_cupertino_sliver_navigation_bar.dart';
import 'package:blogapp/chat/widgets/settings_container.dart';
import 'package:blogapp/chat/widgets/settings_item.dart';
import 'package:blogapp/chat/widgets/user_info_item.dart';
import 'package:blogapp/screen/home_statis/home_statis.dart';
import 'package:blogapp/chat/screens/home/main.dart';
import 'package:blogapp/chat/screens/home/profile.dart';

class HomeScreen extends StatefulWidget {
  static final String routeName = "/home";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //pop premium

  SettingsController _settingsController;
  int currentState = 0;
  List<Widget> widgets = [
    //HomeSscreen(),
    //LoginPage(),
    MyApp(),
    Chat(),
    Search(),
    HomeScreen1(),
    //Premium(),
    //ProfileScreen()
  ];
  List<String> titleString = [
    "",
    "Chat",
    "Live",
    "Media",
    "Premium"
    //"Profile Page"
  ];

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
        return StreamBuilder(
          stream: _settingsController.streamController.stream,
          builder: (context, snapshot2) {
            return Scaffold(
              //drawer: Drawer(
              //  child: ListView(
              //    children: <Widget>[
              //      renderMyUserCard(),
              //      SizedBox(
              //        height: 10,
              //      ),
              //      SettingsContainer(
              //       children: [
              //         SettingsItem(
              //           icon: MaterialIcons.delete,
              //           iconBackgroundColor: Colors.grey,
              //           title: 'Delete conversations',
              //           onTap: _settingsController.openModalDeleteChats,
              //          ),
              //          SettingsItem(
              //            icon: MaterialIcons.exit_to_app,
              //           iconBackgroundColor: Colors.red,
              //           title: 'Log Out',
              //           onTap: _settingsController.openModalExitApp,
              //         ),
              //       ],
              //     ),
              //   ],
              // ),
              //),

              bottomNavigationBar: BottomAppBar(
                color: Colors.black,
                shape: CircularNotchedRectangle(),
                notchMargin: 12,
                child: Container(
                  height: 60,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Ionicons.ios_home),
                          color:
                              currentState == 0 ? Colors.white : Colors.white54,
                          onPressed: () {
                            setState(() {
                              currentState = 0;
                            });
                          },
                          iconSize: 25,
                        ),
                        IconButton(
                          icon: Icon(MaterialCommunityIcons.android_messages),
                          color:
                              currentState == 1 ? Colors.white : Colors.white54,
                          onPressed: () {
                            setState(() {
                              currentState = 1;
                            });
                          },
                          iconSize: 25,
                        ),
                        IconButton(
                          icon: Icon(MaterialIcons.live_tv),
                          color:
                              currentState == 2 ? Colors.white : Colors.white54,
                          onPressed: () {
                            setState(() {
                              currentState = 2;
                            });
                          },
                          iconSize: 25,
                        ),
                        IconButton(
                          icon: Icon(Ionicons.logo_youtube),
                          color:
                              currentState == 3 ? Colors.white : Colors.white54,
                          onPressed: () {
                            setState(() {
                              currentState = 3;
                            });
                          },
                          iconSize: 25,
                        ),
                        IconButton(
                          icon: Icon(Icons.settings),
                          color:
                              currentState == 4 ? Colors.white : Colors.white54,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Profil()),
                            );
                          },
                          iconSize: 25,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              body: widgets[currentState],
              //   floatingActionButton: FloatingActionButton(
              //     onPressed: _homeController.openAddChatScreen,
              //     backgroundColor: Colors.grey,
              //    child: Icon(
              //      MaterialIcons.message,
              //      color: Theme.of(context).accentColor,
              //     ),
              //   ),
            );
          },
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
