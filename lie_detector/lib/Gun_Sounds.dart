import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'Player.dart';

class Gun_Sounds extends StatefulWidget{
  State<Gun_Sounds> createState() => Gun_Sounds_State();
}

class Gun_Sounds_State extends State<Gun_Sounds>{
  late final BannerAd bannerAd;
  bool isAdLoaded = false;
  final String adUnitId = "ca-app-pub-3940256099942544/6300978111"; // Test adUnit ID

  @override
  void initState() {
    super.initState();
    bannerAd = BannerAd(
      size: AdSize.banner,
      adUnitId: adUnitId,
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          setState(() {
            isAdLoaded = true;
          });
          print("Ad Loaded");
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          ad.dispose();
          print("Ad Failed to load: $error");
          // Retry loading the ad after some time
          Future.delayed(const Duration(seconds: 30), () {
            bannerAd.load();
          });
        },
      ),
      request: const AdRequest(),
    );
    bannerAd.load();
  }

  @override
  void dispose() {
    bannerAd.dispose();
    super.dispose();
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
        children: [
          const Text(
            'Gun Sounds',
            style: TextStyle(
              fontFamily: 'AntoSC-Regular',
              fontSize: 30,
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 50),
          Center(
            child: Container(
              padding: const EdgeInsets.all(2.0),
              height: 400,
              child: GridView.count(crossAxisCount: 2,
                mainAxisSpacing: 10,
                children: [
                  InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Player(
                                    imagePath: 'assets/images/Gun Sound One.png',
                                    audioPath: 'assets/audios/Gun Sound 1.mp3'
                                )
                            )
                        );
                      },
                      child: Image.asset('assets/images/Gun Sound One.png')
                  ),
                  InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Player(
                                    imagePath: 'assets/images/Gun Sound Two.png',
                                    audioPath: 'assets/audios/Gun Sound 2.mp3'
                                )
                            )
                        );
                      },
                      child: Image.asset('assets/images/Gun Sound Two.png')
                  ),
                  InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Player(
                                    imagePath: 'assets/images/Gun Sound Three.png',
                                    audioPath: 'assets/audios/Gun Sound 3.mp3'
                                )
                            )
                        );
                      },
                      child: Image.asset('assets/images/Gun Sound Three.png')
                  ),
                  InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Player(
                                    imagePath: 'assets/images/Gun Sound Four.png',
                                    audioPath: 'assets/audios/Gun Sound 4.mp3'
                                )
                            )
                        );
                      },
                      child: Image.asset('assets/images/Gun Sound Four.png')
                  ),
                ],
              ),
            ),
          ),
          const Spacer(),
          if (isAdLoaded)
            Container(
              alignment: Alignment.center,
              width: bannerAd.size.width.toDouble(),
              height: bannerAd.size.height.toDouble(),
              color: Colors.white,
              child: AdWidget(ad: bannerAd),
            ),
          if (!isAdLoaded)
            Container(
              alignment: Alignment.center,
              color: Colors.white,
              height: 50,
              child: const Text(
                'Ad is loading...',
              ),
            ),
        ],
      ),
    );
  }
}