import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class Player extends StatefulWidget {
  final String imagePath;
  final String audioPath;

  const Player({Key? key, required this.imagePath, required this.audioPath}) : super(key: key);

  @override
  _PlayerState createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  late AudioPlayer _audioPlayer;
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  late BannerAd _bannerAd;
  bool isAdLoaded = false;
  final String adUnitId = "ca-app-pub-3940256099942544/6300978111"; // Test adUnit ID

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _audioPlayer.onDurationChanged.listen((d) {
      setState(() {
        duration = d;
      });
    });
    _audioPlayer.onPositionChanged.listen((p) {
      setState(() {
        position = p;
      });
    });

    // Initialize and load the banner ad
    _bannerAd = BannerAd(
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
            _bannerAd.load();
          });
        },
      ),
      request: const AdRequest(),
    );
    _bannerAd.load();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    _bannerAd.dispose();
    super.dispose();
  }

  void playPause() async {
    if (isPlaying) {
      await _audioPlayer.pause();
    } else {
      await _audioPlayer.play(AssetSource(widget.audioPath));
    }
    setState(() {
      isPlaying = !isPlaying;
    });
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
          SizedBox(
              height: 300,
              width: 300,
              child: Image.asset(widget.imagePath)
          ),
          const SizedBox(height: 20),
          IconButton(
            icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
            color: Colors.white,
            iconSize: 64,
            onPressed: playPause,
          ),
          Slider(
            min: 0,
            max: duration.inSeconds.toDouble(),
            value: position.inSeconds.toDouble(),
            onChanged: (value) {
              _audioPlayer.seek(Duration(seconds: value.toInt()));
            },
          ),
          const Spacer(),
          if (isAdLoaded)
            Container(
              alignment: Alignment.center,
              width: _bannerAd.size.width.toDouble(),
              height: _bannerAd.size.height.toDouble(),
              color: Colors.white,
              child: AdWidget(ad: _bannerAd),
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
