import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:tarvel_mate/pages/home.dart';
import 'package:tarvel_mate/pages/login.dart';
import 'package:tarvel_mate/pages/map.dart';
import 'package:tarvel_mate/pages/profile.dart';
import 'package:tarvel_mate/pages/time_schedule.dart';
import 'package:tarvel_mate/utils/constants/colors.dart';

//AppBar Design

class AppbarTop extends StatelessWidget implements PreferredSizeWidget {
  const AppbarTop({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actionsPadding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
      title: const Text(
        "TravelMate",
        style: TextStyle(
          fontFamily: 'DMSans',
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.w600,
        ),
      ),
      centerTitle: true,
      backgroundColor: FColors.primarypurple,
      actions: [
        IconButton(
          icon: const Icon(
            Iconsax.notification_bing_bold,
            color: Colors.white,
            size: 28,
            shadows: [Shadow(color: Colors.grey, offset: Offset(1, 1))],
          ),
          onPressed: () {},
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

//Drawer Design

class DrawerD extends StatelessWidget {
  const DrawerD({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(color: FColors.primarypurple),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage('assets/profile_image.png'),
                ),
                SizedBox(height: 10),
                Text(
                  'Student Name',
                  style: TextStyle(
                    fontFamily: 'DMSans',
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              // Handle the tap
            },
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Profile'),
            onTap: () {
              // Handle the tap
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () {
              // Handle the tap
            },
          ),
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text('Notifications'),
            onTap: () {
              // Handle the tap
            },
          ),
          ListTile(
            leading: Icon(Icons.help),
            title: Text('Help'),
            onTap: () {
              // Handle the tap
            },
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text('About'),
            onTap: () {
              // Handle the tap
            },
          ),
          ListTile(
            leading: Icon(Icons.contact_mail),
            title: Text('Contact Us'),
            onTap: () {
              // Handle the tap
            },
          ),
          ListTile(
            leading: Icon(Icons.feedback),
            title: Text('Feedback'),
            onTap: () {
              // Handle the tap
            },
          ),
          ListTile(
            leading: Icon(Icons.share),
            title: Text('Share'),
            onTap: () {
              // Handle the tap
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () {
              Navigator.pushNamed(context, '/login');
            },
          ),
        ],
      ),
    );
  }
}

//BottomNavigationBar

class NavBottom extends StatefulWidget {
  const NavBottom({super.key});

  @override
  State<NavBottom> createState() => _NavBottomState();
}

class _NavBottomState extends State<NavBottom> {
  int selectedIndex = 0;

  final List<Widget> widgetOptions = <Widget>[
    Home(),
    TimeSchedule(),
    MapLoca(),
    Login(),
    StuProfile(),
  ];

  // Method to handle bottom navigation bar item tap
  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });

    // Navigate to the selected page
    // switch (index) {
    //   case 0:
    //     Navigator.pushNamed(context, '/home');
    //     break;
    //   case 1:
    //     Navigator.pushNamed(context, '/signup');
    //     break;
    //   case 2:
    //     Navigator.pushNamed(context, '/login');
    //     break;
    //   case 3:
    //     Navigator.pushNamed(context, '/map');
    //     break;
    //   case 4:
    //     Navigator.pushNamed(context, '/home');
    //     break;
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: selectedIndex, children: widgetOptions),

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: FColors.darkGrey,
        currentIndex: selectedIndex,
        onTap: _onItemTapped, // Method to update the selected item
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        elevation: 5,

        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.access_time_outlined),
            label: 'Schedule',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.location_on_outlined), label: 'Location'),
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_bus_outlined),
            label: 'Bus',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_2_outlined),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

//ObjectBox  For Time Schedule

class Schedule {
  String? busname;
  String? from;
  String? to;
  String? time;
  Schedule({this.busname, this.from, this.to, this.time});
}
