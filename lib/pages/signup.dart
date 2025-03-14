import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:tarvel_mate/utils/constants/colors.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  bool _obscurePass = true;
  bool _obscureComPass = true;
  bool _acceptTrams = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Sign Up",
                style: TextStyle(
                  fontSize: 30,
                  fontFamily: 'DMSans',
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 40),

              TextField(
                decoration: InputDecoration(
                  labelText: "Username",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Iconsax.user_outline),
                ),
              ),

              SizedBox(height: 30),

              TextField(
                decoration: InputDecoration(
                  labelText: "Student Email",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email_outlined),
                ),
              ),

              SizedBox(height: 30),

              TextField(
                decoration: InputDecoration(
                  labelText: "Student Id",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.badge_outlined),
                ),
              ),

              SizedBox(height: 30),

              TextField(
                decoration: InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock_outlined),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _obscurePass = !_obscurePass;
                      });
                    },
                    icon: Icon(
                      _obscurePass
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 30),

              TextField(
                decoration: InputDecoration(
                  labelText: "Confirm Password",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock_outlined),
                  suffixIcon: IconButton(
                    icon:Icon(_obscureComPass? Icons.visibility_outlined : Icons.visibility_off_outlined),
                    onPressed: (){
                      setState(() {
                        _obscureComPass=!_obscureComPass;
                      });
                    }
                  )
                ),
              ),

              SizedBox(height: 10),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Checkbox(
                    value: _acceptTrams,
                    onChanged: (value) {
                      setState(() {
                        _acceptTrams = value!;
                      });
                    },
                    shape: CircleBorder(),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 12, 0, 10),
                    child: Text(
                      "Accept the terms and condition.",
                      style: TextStyle(fontFamily: 'DNSans', fontSize: 16),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 15),

              ElevatedButton(
                onPressed: () {
                  if (_acceptTrams){
                    Navigator.pushNamed(context, '/login');
                  }
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: FColors.primarypurple,
                ),
                child: Text(
                  "Sign Up",
                  style: TextStyle(
                    fontSize: 18, 
                    color: Colors.white,
                    fontFamily: 'DNSans'
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
