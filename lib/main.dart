// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:tarvel_mate/pages/design_tm.dart';
// import 'package:tarvel_mate/pages/home.dart';
// import 'package:tarvel_mate/pages/login.dart';
// import 'package:tarvel_mate/pages/map.dart';
// import 'package:tarvel_mate/pages/profile.dart';
// import 'package:tarvel_mate/pages/signup.dart';
// import 'package:tarvel_mate/pages/test.dart';
// import 'package:tarvel_mate/pages/time_schedule.dart';
// import 'package:tarvel_mate/pages/welcome.dart';
// import 'package:tarvel_mate/wrapper.dart';
// import 'firebase_options.dart';
// import 'package:tarvel_mate/pages/bus_info.dart';
// import 'package:tarvel_mate/theme_provider.dart';
// import 'package:provider/provider.dart';
// import 'package:tarvel_mate/userdata/userdataprovider.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// Future<void> main() async {
//   // --- Add this line ---
//   WidgetsFlutterBinding.ensureInitialized();
//   // --------------------

//   try {
//     // Initialize Firebase
//     await Firebase.initializeApp(
//       options: DefaultFirebaseOptions.currentPlatform,
//     );
//     print("Firebase initialized successfully!"); // Add for confirmation
//   } catch (e) {
//     // Catch and print any errors during initialization
//     print("Error initializing Firebase: $e");
//     // You might want to show an error screen here instead of just running the app
//   }

//   runApp(
//     ChangeNotifierProvider(
//       create: (_) => ThemeProvider(),
//       child: const MyApp(),
//     ),
//   );
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//   @override
//   Widget build(BuildContext context) {
//     final themeProvider = Provider.of<ThemeProvider>(context);
//     return ChangeNotifierProvider(
//       create: (context) => UserDataProvider(),
//       child: MaterialApp(
//         debugShowCheckedModeBanner: false,

//         themeMode: themeProvider.currentTheme,
//         theme: ThemeData(
//           brightness: Brightness.light,
//           scaffoldBackgroundColor: Colors.white,
//           cardColor: Colors.white,
//           appBarTheme: AppBarTheme(
//             backgroundColor: Colors.white,
//             iconTheme: IconThemeData(color: Colors.black),
//             titleTextStyle: TextStyle(
//               color: Colors.black,
//               fontSize: 18,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//         ),
//         darkTheme: ThemeData(
//           brightness: Brightness.dark,
//           scaffoldBackgroundColor: Colors.black,
//           cardColor: Color(0xFF1E1E1E),
//           appBarTheme: AppBarTheme(
//             backgroundColor: Color(0xFF1E1E1E),
//             iconTheme: IconThemeData(color: Colors.white),
//             titleTextStyle: TextStyle(
//               color: Colors.white,
//               fontSize: 18,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//         ),

//         initialRoute:
//             FirebaseAuth.instance.currentUser == null
//                 ? '/welcome'
//                 : '/nav', // Start at login or nav based on auth state,
//         routes: {
//           '/home': (context) => Home(),
//           '/login': (context) => Login(),
//           '/signup': (context) => Signup(),
//           '/map': (context) => MapLoca(),
//           '/nav': (context) => NavBottom(),
//           '/welcome': (context) => Welcome(),
//           '/timeschedule': (context) => TimeSchedule(),
//           '/stuprofile': (context) => ProfilePage(),
//           '/businfo': (context) => BusInfo(),

//           //'/map1': (context) => LiveTrackingPage(),
//           //'/timeschedule1': (context) => TimeSchedule1(),
//         },
//         // home: Wrapper(),
//       ),
//     );
//   }
// }

// main.dart
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tarvel_mate/pages/design_tm.dart';
import 'package:tarvel_mate/pages/home.dart';
import 'package:tarvel_mate/pages/login.dart';
import 'package:tarvel_mate/pages/map.dart';
import 'package:tarvel_mate/pages/profile.dart'; // Corrected import name assuming it's profile_page.dart
import 'package:tarvel_mate/pages/signup.dart';
import 'package:tarvel_mate/pages/test.dart';
import 'package:tarvel_mate/pages/time_schedule.dart';
import 'package:tarvel_mate/pages/welcome.dart';
// REMOVE import 'package:tarvel_mate/wrapper.dart'; if AuthWrapper replaces it
import 'firebase_options.dart';
import 'package:tarvel_mate/pages/bus_info.dart';
import 'package:tarvel_mate/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:tarvel_mate/userdata/userdataprovider.dart'; // Correct path?
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tarvel_mate/userdata/authwrapper.dart'; // <-- Import the new wrapper
import 'package:tarvel_mate/pages/design_tm.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print("Firebase initialized successfully!");
  } catch (e) {
    print("Error initializing Firebase: $e");
  }

  // Use MultiProvider for cleaner setup
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(
          create: (context) => UserDataProvider(),
        ), // Provide UserDataProvider here
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // ThemeProvider is already available via MultiProvider, no need for Provider.of here generally
    // unless you need it specifically in THIS build method for some reason.
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: themeProvider.currentTheme,
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.white,
        cardColor: Colors.white,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          titleTextStyle: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500),
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
        cardColor: Color(0xFF1E1E1E),
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFF1E1E1E),
          iconTheme: IconThemeData(color: Colors.white),
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
        ),
      ),

      // --- Use home instead of initialRoute ---
      home: const AuthWrapper(),
      // ----------------------------------------

      // Keep your routes defined for named navigation from within the app
      routes: {
        // '/home': (context) => Home(), // Might not be needed if NavBottom handles it
        '/login': (context) => Login(),
        '/signup': (context) => Signup(),
        '/map': (context) => MapLoca(),
        '/nav':
            (context) => NavBottom(), // Keep for potential explicit navigation
        '/welcome':
            (context) => Welcome(), // Keep for potential explicit navigation
        '/timeschedule': (context) => TimeSchedule(),
        '/stuprofile':
            (context) => ProfilePage(), // Ensure ProfilePage is imported
        '/businfo': (context) => BusInfo(),
        // Add other routes...
      },
    );
  }
}
