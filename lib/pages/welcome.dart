import 'package:flutter/material.dart';
import 'package:tarvel_mate/utils/constants/colors.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: FColors.primarypurple, // Background color
          // Uncomment this if you want a background image
          // image: DecorationImage(
          //   image: NetworkImage(
          //     'https://images.unsplash.com/photo-1508349937151-22b68b72d5b1?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTZ8fG5hdHVyZSUyMGJhY2tncm91bmR8ZW58MHx8MHx8fDA%3D',
          //   ),
          //   fit: BoxFit.cover,
          // ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(0, 250, 0, 0),
              child: Image.asset("assets/image/logo/logo2.png",
              width: 150,
              height: 120,
            ),
            ),
            Text(
              "TravelMate",
              style: TextStyle(
                fontFamily: 'DNSans',
                color: Colors.white,
                fontSize: 28,
              ),
            ),
            Text(
              "Glide effortlessly to the gates of knowledge!",
              style: TextStyle(
                fontFamily: 'DNSans',
                color: Colors.white,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 150),
            Padding(
              padding: EdgeInsets.all(45), // ✅ Added missing comma
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 55),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  backgroundColor: Colors.white, // Button background color
                  foregroundColor: FColors.primarypurple, // Button text color
                ),
                child: Text(
                  "Get Explore Now",
                  style: TextStyle(
                    fontSize: 18,
                    color: FColors.primarypurple, // Button text color
                    fontFamily: 'DNSans',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
