import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget{
  State<Dashboard> createState() => Dashboard_State();
}

class Dashboard_State extends State<Dashboard>{
  Widget build(BuildContext context){
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
        ),
        backgroundColor: Colors.black,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'LIE DETECTOR',
              style: TextStyle(
                fontFamily: 'AntoSC-Regular',
                fontSize: 30,
                fontWeight: FontWeight.w900,
                color: Colors.white,
              ),
            ),
            const Text(
              'Play with Friends',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
            Image.asset('assets/images/Home Screen.png'),
            SizedBox(
                height: 80,
                child: InkWell(
                    onTap: (){
                      print('Start Button Tapped');
                    },
                    child: Image.asset('assets/images/STARTSCANNER.png')
                )
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
                height: 80,
                child: InkWell(
                    onTap: (){
                      print('Sound Button Tapped');
                    },
                    child: Image.asset('assets/images/ENJOYSOUND.png')
                )
            )
          ],
        )
    );
  }
}