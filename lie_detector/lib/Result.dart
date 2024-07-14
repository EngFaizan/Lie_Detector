import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class Result extends StatefulWidget {
  @override
  State<Result> createState() => Result_State();
}

class Result_State extends State<Result> {
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
          Future.delayed(Duration(seconds: 30), () {
            bannerAd.load();
          });
        },
      ),
      request: AdRequest(),
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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 40),
          const Text(
            'DETECTOR',
            style: TextStyle(
              fontFamily: 'AntoSC-Regular',
              fontSize: 30,
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 20),
          Stack(
            alignment: Alignment.center,
            children: [
              Image.asset('assets/images/BANNER.png'),
              const Text(
                'TRUE',
                style: TextStyle(
                  fontFamily: 'AntoSC-Regular',
                  fontSize: 30,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Image.asset('assets/images/Lights.png'),
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
