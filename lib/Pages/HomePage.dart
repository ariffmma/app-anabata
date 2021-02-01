import 'package:blogapp/Blog/addBlog.dart';
import 'package:blogapp/Pages/WelcomePage.dart';
//import 'package:blogapp/Screen/HomeScreen.dart';
import 'package:blogapp/homepage/home-screen.dart';
import 'package:blogapp/Screen/Search.dart';
import 'package:blogapp/YT/home_screen.dart';
import 'package:blogapp/Profile/ProfileScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:blogapp/NetworkHandler.dart';
import 'package:flutter_icons/flutter_icons.dart';

class HomePage extends StatefulWidget {
  static final String routeName = "/home";
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentState = 0;
  List<Widget> widgets = [
    HomeSscreen(),
    Search(),
    HomeScreen1(),
    ProfileScreen()
  ];
  List<String> titleString = ["Home Page", "Timeline", "Media", "Profile Page"];
  final storage = FlutterSecureStorage();
  NetworkHandler networkHandler = NetworkHandler();
  String username = "";
  Widget profilePhoto = Container(
    height: 100,
    width: 100,
    decoration: BoxDecoration(
      color: Colors.black,
      borderRadius: BorderRadius.circular(50),
    ),
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkProfile();
  }

  void checkProfile() async {
    var response = await networkHandler.get("/profile/checkProfile");
    setState(() {
      username = response['username'];
    });
    if (response["status"] == true) {
      setState(() {
        profilePhoto = CircleAvatar(
          radius: 50,
          backgroundImage: NetworkHandler().getImage(response['username']),
        );
      });
    } else {
      setState(() {
        profilePhoto = Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(50),
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              child: Column(
                children: <Widget>[
                  profilePhoto,
                  SizedBox(
                    height: 10,
                  ),
                  Text("@$username"),
                ],
              ),
            ),
            ListTile(
              title: Text("All Post"),
              trailing: Icon(MaterialIcons.launch),
              onTap: () {},
            ),
            ListTile(
              title: Text("New Post"),
              trailing: Icon(Ionicons.ios_add),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => AddBlog()));
              },
            ),
            ListTile(
              title: Text("Settings"),
              trailing: Icon(Ionicons.ios_settings),
              onTap: () {},
            ),
            ListTile(
              title: Text("Logout"),
              trailing: Icon(Ionicons.ios_power),
              onTap: logout,
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(titleString[currentState]),
        centerTitle: true,
        actions: <Widget>[
          IconButton(icon: Icon(Ionicons.ios_notifications), onPressed: () {}),
        ],
      ),
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
                  color: currentState == 0 ? Colors.white : Colors.white54,
                  onPressed: () {
                    setState(() {
                      currentState = 0;
                    });
                  },
                  iconSize: 25,
                ),
                IconButton(
                  icon: Icon(FontAwesome5.calendar_alt),
                  color: currentState == 1 ? Colors.white : Colors.white54,
                  onPressed: () {
                    setState(() {
                      currentState = 1;
                    });
                  },
                  iconSize: 25,
                ),
                IconButton(
                  icon: Icon(Ionicons.logo_youtube),
                  color: currentState == 2 ? Colors.white : Colors.white54,
                  onPressed: () {
                    setState(() {
                      currentState = 2;
                    });
                  },
                  iconSize: 25,
                ),
                IconButton(
                  icon: Icon(Ionicons.ios_person),
                  color: currentState == 3 ? Colors.white : Colors.white54,
                  onPressed: () {
                    setState(() {
                      currentState = 3;
                    });
                  },
                  iconSize: 25,
                )
              ],
            ),
          ),
        ),
      ),
      body: widgets[currentState],
    );
  }

  void logout() async {
    await storage.delete(key: "token");
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => WelcomePage()),
        (route) => false);
  }
}
