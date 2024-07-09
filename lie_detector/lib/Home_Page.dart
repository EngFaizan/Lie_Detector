import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home_Page extends StatefulWidget {

  State<Home_Page> createState() => Home_Page_State();

}

class Home_Page_State extends State<Home_Page>{
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
              height: 100,
              child: InkWell(
                onTap: (){
                  print('Start Button Tapped');
                },
                  child: Image.asset('assets/images/start btn.png')
              )
          ),
          const SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                height: 90,
                width: 90,
                child: Image.asset('assets/images/PRIVACY.png'),
              ),
              SizedBox(
                height: 90,
                width: 90,
                child: Image.asset('assets/images/SHARE.png'),
              ),
              SizedBox(
                height: 90,
                width: 90,
                child: Image.asset('assets/images/RATE US.png'),
              ),
            ],
          )
        ],
      )
    );
  }
}