import 'package:flutter/material.dart';
import 'package:tarvel_mate/pages/bus_info.dart';
import 'package:tarvel_mate/pages/home.dart';
import 'package:tarvel_mate/pages/map.dart';
import 'package:tarvel_mate/pages/profile.dart';
import 'package:tarvel_mate/pages/time_schedule.dart';
import 'package:tarvel_mate/utils/constants/colors.dart';
import 'package:tarvel_mate/userdata/userdataprovider.dart';
import 'package:tarvel_mate/userdata/userprofile.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
// --- Import the pages you want to navigate to ---
import 'package:tarvel_mate/pages/profile.dart'; // Already importing? Verify path/name
import 'package:tarvel_mate/pages/feedback.dart'; // Import feedback page// Import about us page (create this)
import 'package:tarvel_mate/pages/contactus.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:tarvel_mate/theme_provider.dart';

// AppBar Design
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
          //color: FColors.primarypurple,
          fontSize: 24,
          fontWeight: FontWeight.w600,
        ),
      ),
      centerTitle: true,
      //backgroundColor: FColors.primarypurple,
      actions: [
        IconButton(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          icon: const Icon(
            Icons.notifications_none_rounded,
            //color: FColors.primarypurple,
            size: 28,
          ),
          onPressed: () {},
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

// Drawer Design
class DrawerD extends StatelessWidget {
  const DrawerD({super.key});

  // Helper function to get initials (no changes needed here)
  String _getInitials(String? username) {
    if (username == null || username.trim().isEmpty) {
      return "?";
    }
    return username.trim()[0].toUpperCase();
  }



  @override
  Widget build(BuildContext context) {
    // Get Theme state and provider
    final themeProvider = Provider.of<ThemeProvider>(
      context,
    ); // Get ThemeProvider instance
    final isDarkMode = themeProvider.isDarkMode; // Use getter from provider

    // Get User data provider
    final userDataProvider = context.watch<UserDataProvider>();
    final UserProfile? userProfile = userDataProvider.userProfile;

    // Define colors based on actual theme brightness (optional if using themed widgets)
    final textColor =
        Theme.of(context).textTheme.bodyLarge?.color ??
        (isDarkMode ? Colors.white70 : Colors.black87);
    final iconColor =
        Theme.of(context).iconTheme.color ??
        (isDarkMode ? Colors.white : Colors.black54);

    return Drawer(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 35,
                  backgroundColor:
                      Theme.of(context).colorScheme.primaryContainer,
                  child: Text(
                    _getInitials(userProfile?.username),
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  userProfile?.username ?? 'User',
                  style: TextStyle(
                    fontFamily: 'DMSans',
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                    fontWeight: FontWeight.w400,
                    fontSize: 18,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),

          // --- Drawer Items ---
          _drawerItem(Iconsax.home_outline, 'Home', iconColor, textColor, () {
            Navigator.pop(context);
            Navigator.pushNamed(context, '/nav');
            // TODO: Navigate home
          }),

          _drawerItem(
            Iconsax.setting_outline,
            'Settings',
            iconColor,
            textColor,
            () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Settings page not implemented yet.'),
                ),
              );
            },
          ),
          _drawerItem(
            Iconsax.message_question_outline,
            'Feedback',
            iconColor,
            textColor,
            () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FeedbackPage()),
              );
            },
          ),
          _drawerItem(
            Iconsax.call_calling_outline,
            'Contact Us',
            iconColor,
            textColor,
            () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ContactUsSimplePage(),
                ),
              );
            },
          ),

          // --- Dark Mode Toggle ---
          Padding(
            // Add padding to align visually with ListTile content
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: Row(
              children: [
                Icon(
                  // Use the isDarkMode flag from the provider
                  isDarkMode
                      ? Iconsax.moon_outline
                      : Iconsax
                          .sun_1_outline, // Or regular Icons.dark_mode/light_mode
                  color: iconColor, // Use defined icon color
                  size: 24, // Standard ListTile leading icon size
                ),
                const SizedBox(
                  width: 32,
                ), // Standard spacing after leading icon in ListTile
                Text(
                  "Dark Mode",
                  style: TextStyle(
                    // Match ListTile text style if possible
                    // fontFamily: 'DMSans',
                    color: textColor, // Use defined text color
                    fontSize:
                        Theme.of(context).textTheme.titleMedium?.fontSize ?? 16,
                  ),
                ),
                const Spacer(), // Pushes switch to the right
                Switch(
                  value: isDarkMode, // Bind value to provider state
                  onChanged: (value) {
                    // Call the toggle method on the provider instance
                    // No need for context.read here as Provider.of was used above
                    themeProvider.toggleTheme(value);
                  },
                  activeColor:
                      Theme.of(context).colorScheme.primary, // Use theme color
                  // You might want to style inactive color too
                  // inactiveTrackColor: Colors.grey[300],
                  // inactiveThumbColor: Colors.grey[500],
                ),
              ],
            ),
          ),

          // ----------------------
          const Divider(), // Separator before logout
          // --- Logout Item ---
          // _drawerItem(
          //   Iconsax.logout_outline,
          //   'Logout',
          //   iconColor,
          //   textColor,
          //   () async {
          //     // ... (logout logic remains the same) ...
          //     Navigator.pop(context); // Close drawer first
          //     bool? confirmLogout = await showDialog<bool>(
          //       context: context, // Provide the BuildContext
          //       barrierDismissible:
          //           false, // Optional: Prevents closing by tapping outside
          //       builder: (BuildContext dialogContext) {
          //         // The builder function creates the dialog
          //         return AlertDialog(
          //           title: const Text('Confirm Logout'),
          //           content: const Text('Are you sure you want to log out?'),
          //           actions: <Widget>[
          //             TextButton(
          //               child: const Text('Cancel'),
          //               onPressed: () {
          //                 // Close the dialog and return 'false'
          //                 Navigator.of(dialogContext).pop(false);
          //               },
          //             ),
          //             TextButton(
          //               child: const Text('Logout'),
          //               onPressed: _confirmLogout,
          //             ),
          //           ],
          //         );
          //       }, // End of builder function
          //     );
          //     if (confirmLogout == true && context.mounted) {
          //       try {
          //         context.read<UserDataProvider>().clearUserData();
          //         await FirebaseAuth.instance.signOut();
          //         Navigator.pushNamedAndRemoveUntil(
          //           context,
          //           '/login',
          //           (route) => false,
          //         );
          //       } catch (e) {
          //         /* ... error handling ... */
          //       }
          //     }
          //   },
          // ),
        ],
      ),
    );
  }

  // Helper method for drawer items (no changes needed here)
  ListTile _drawerItem(
    IconData icon,
    String title,
    Color iconColor,
    Color textColor,
    VoidCallback onTap,
  ) {
    return ListTile(
      leading: Icon(icon, color: iconColor, size: 24), // Match icon size
      title: Text(title, style: TextStyle(color: textColor)),
      onTap: onTap,
    );
  }
}

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
    BusInfo(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppbarTop(),
      drawer: DrawerD(),
      body: IndexedStack(index: selectedIndex, children: widgetOptions),

      // Wrap BottomNavigationBar in a Theme to disable only click (ripple) effect
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          backgroundColor: isDark ? Colors.grey[900] : FColors.darkGrey,
          currentIndex: selectedIndex,
          onTap: _onItemTapped,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          elevation: 5,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.access_time_outlined),
              label: 'Schedule',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.location_on_outlined),
              label: 'Location',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.directions_bus_outlined),
              label: 'Bus',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}

// ObjectBox Schedule Model
