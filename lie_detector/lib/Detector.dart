import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'Result.dart';

class Detector extends StatefulWidget {
  @override
  State<Detector> createState() => DetectorState();
}

class DetectorState extends State<Detector> {
  bool _isButtonPressed = false;
  bool _longPressCompleted = false;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'DETECTOR',
            style: TextStyle(
              fontFamily: 'AntoSC-Regular',
              fontSize: 30,
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
          ),
          SizedBox(
              height: 200,
              child: Image.asset('assets/images/BANNER.png')
          ),
          const SizedBox(height: 20),
          SizedBox(
              height: 50,
              child: Image.asset('assets/images/Lights.png')
          ),
          GestureDetector(
            onLongPressStart: (_) => _startLongPress(),
            onLongPressEnd: (_) => _endLongPress(),
            child: SizedBox(
              child: Image.asset('assets/images/Home Screen.png'),
            ),
          ),
        ],
      ),
    );
  }

  void _startLongPress() {
    setState(() {
      _isButtonPressed = true;
    });
    _longPressCompleted = false;

    _timer = Timer(const Duration(seconds: 5), () {
      if (_isButtonPressed) {
        setState(() {
          _longPressCompleted = true;
        });
        _navigateToResult();
      }
    });
  }

  void _endLongPress() {
    _isButtonPressed = false;

    if (!_longPressCompleted) {
      _timer.cancel();
      _showMessage('Please press the button until the result is displayed.');
    }
  }

  void _showMessage(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _navigateToResult() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Result()),
    );
  }
}
