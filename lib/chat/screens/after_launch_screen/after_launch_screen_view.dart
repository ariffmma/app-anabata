import 'dart:async';

import 'package:blogapp/chat/data/local_database/db_provider.dart';
import 'package:blogapp/chat/data/providers/chats_provider.dart';
import 'package:blogapp/chat/screens/home/home_view.dart';
import 'package:blogapp/Pages/WelcomePage.dart';
import 'package:blogapp/Pages/HomePage.dart';
import 'package:blogapp/chat/utils/custom_shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:native_updater/native_updater.dart';

class AfterLaunchScreen extends StatefulWidget {
  @override
  _AfterLaunchScreenState createState() => _AfterLaunchScreenState();
}

class _AfterLaunchScreenState extends State<AfterLaunchScreen> {
  void verifyUserLoggedInAndRedirect() async {
    String routeName = HomePage.routeName;
    String token = await CustomSharedPreferences.get('token');
    if (token == null) {
      routeName = WelcomePage.routeName;
    }
    Timer.run(() {
      // In case user is already logged in, go to home_screen
      // otherwise, go to login_screen
      Navigator.of(context).pushReplacementNamed(routeName);
    });
  }

  @override
  void initState() {
    super.initState();
    DBProvider.db.database;
    verifyUserLoggedInAndRedirect();
    checkVersion();
  }

  Future<void> checkVersion() async {
    /// For example: You got status code of 412 from the
    /// response of HTTP request.
    /// Let's say the statusCode 412 requires you to force update
    int statusCode = 412;

    /// This could be kept in our local
    int localVersion = 9;

    /// This could get from the API
    int serverLatestVersion = 10;

    Future.delayed(Duration.zero, () {
      if (statusCode == 412) {
        NativeUpdater.displayUpdateAlert(
          context,
          forceUpdate: true,
          //appStoreUrl: '<Your App Store URL>',
          playStoreUrl:
              'https://play.google.com/store/apps/details?id=com.anabata.app',
          // iOSDescription: '<Your iOS description>',
          //  iOSUpdateButtonLabel: 'Upgrade',
          // iOSCloseButtonLabel: 'Exit',
        );
      } else if (serverLatestVersion > localVersion) {
        NativeUpdater.displayUpdateAlert(
          context,
          forceUpdate: false,
          //  appStoreUrl: '<Your App Store URL>',
          playStoreUrl:
              'https://play.google.com/store/apps/details?id=com.anabata.app',
          //  iOSDescription: '<Your description>',
          //  iOSUpdateButtonLabel: 'Upgrade',
          //   iOSIgnoreButtonLabel: 'Next Time',
        );
      }
    });
  }

  @override
  void didChangeDependencies() {
    Provider.of<ChatsProvider>(context).updateChats();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
    );
  }
}
