import 'package:flutter/material.dart';
import 'dart:async';

import 'package:lie_detector/main.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      // Navigate to the next screen after 3 seconds
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const MyHomePage(title: "Lie Detector"),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Image.asset('assets/images/background.png', fit: BoxFit.cover),
          ),
          const Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: 50.0), // Adjust padding as needed
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    'LIE DETECTOR',
                    style: TextStyle(
                      fontFamily: 'AntoSC-Regular',
                      fontSize: 30,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Play with Friends',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 20), // Space between text and loading animation
                  CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
