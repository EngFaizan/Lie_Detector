import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:lie_detector/Animal.dart';
import 'package:lie_detector/Baby_Sounds.dart';
import 'package:lie_detector/Gun_Sounds.dart';
import 'package:lie_detector/Trimmer.dart';

class Sounds extends StatefulWidget {
  @override
  State<Sounds> createState() => _SoundsState();
}

class _SoundsState extends State<Sounds> {
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
            'Sounds',
            style: TextStyle(
              fontFamily: 'AntoSC-Regular',
              fontSize: 30,
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 50),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 80,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Animal()
                        )
                      );
                    },
                    child: Image.asset('assets/images/Animal Sound.png'),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 80,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Baby_Sounds()
                          )
                      );
                    },
                    child: Image.asset('assets/images/Baby Sound.png'),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 80,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Gun_Sounds()
                          )
                      );
                    },
                    child: Image.asset('assets/images/Gun Sound.png'),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 80,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Trimmer()
                          )
                      );
                    },
                    child: Image.asset('assets/images/Trimmer Sound.png'),
                  ),
                ),
              ],
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
