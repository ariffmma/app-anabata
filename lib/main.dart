import 'package:blogapp/chat/data/providers/chats_provider.dart';
import 'package:blogapp/Pages/WelcomePage.dart';
import 'package:blogapp/chat/screens/add_chat/add_chat_view.dart';
import 'package:blogapp/chat/screens/after_launch_screen/after_launch_screen_view.dart';
import 'package:blogapp/chat/screens/contact/contact_view.dart';
import 'package:blogapp/chat/screens/home/home_view.dart';
import 'package:blogapp/chat/screens/login/login_view.dart';
import 'package:blogapp/chat/screens/register/register_view.dart';
import 'package:blogapp/chat/screens/settings/settings_view.dart';
import 'package:blogapp/chat/widgets/custom_page_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:blogapp/Pages/HomePage.dart';
import 'package:upgrader/upgrader.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: App(),
    );
  }
}

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Upgrader().clearSavedSettings();

    // On Android, setup the Appcast.
    // On iOS, the default behavior will be to use the App Store version of
    // the app, so update the Bundle Identifier in example/ios/Runner with a
    // valid identifier already in the App Store.
    final appcastURL = 'http://upgrader.anabata.id/upgrader.xml';
    final cfg = AppcastConfiguration(url: appcastURL, supportedOS: ['android']);

    // FlutterStatusbarcolor.setStatusBarColor(Colors.white);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarBrightness: Brightness.light,
    ));
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ChatsProvider()),
      ],
      child: UpgradeAlert(
        appcastConfig: cfg,
        debugLogging: true,
        dialogStyle: UpgradeDialogStyle.cupertino,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Anabata',
          theme: ThemeData(
              primaryColor: Colors.blue,
              accentColor: Colors.white,
              scaffoldBackgroundColor: Colors.white,
              cursorColor: Colors.blue,
              appBarTheme: AppBarTheme().copyWith(
                  iconTheme: IconThemeData(color: Colors.black),
                  textTheme: TextTheme().copyWith(
                      title: Theme.of(context)
                          .primaryTextTheme
                          .title
                          .copyWith(color: Colors.black)))),
          initialRoute: '/',
          onGenerateRoute: (RouteSettings settings) {
            switch (settings.name) {
              case '/':
                return PageRouteBuilder(
                    pageBuilder: (_, a1, a2) => AfterLaunchScreen(),
                    settings: settings);
              case '/welcome':
                return PageRouteBuilder(
                    pageBuilder: (_, a1, a2) => WelcomePage(),
                    settings: settings);
              case '/login':
                return PageRouteBuilder(
                    pageBuilder: (_, a1, a2) => LoginScreen(),
                    settings: settings);
              case '/register':
                return CustomPageRoute.build(
                    builder: (_) => RegisterScreen(), settings: settings);
              case '/home':
                return PageRouteBuilder(
                    pageBuilder: (_, a1, a2) => HomeScreen(),
                    settings: settings);
              case '/contact':
                return CustomPageRoute.build(
                    builder: (_) => ContactScreen(), settings: settings);
              case '/add-chat':
                return CustomPageRoute.build(
                    builder: (_) => AddChatScreen(),
                    settings: settings,
                    fullscreenDialog: true);
              case '/settings':
                return CustomPageRoute.build(
                    builder: (_) => SettingsScreen(), settings: settings);
              default:
                return CustomPageRoute.build(
                    builder: (_) => AfterLaunchScreen(), settings: settings);
            }
          },
        ),
      ),
    );
  }
}
