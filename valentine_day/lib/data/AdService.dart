import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../AboutUs.dart';
import '../GifsImages.dart';
import '../ImagesList.dart';
import '../MemeGenerator.dart';
import '../MessagesList.dart';
import '../QuotesList.dart';
import '../ShayariList.dart';
import '../StatusList.dart';
import 'Strings.dart';

class AdService {
  static String get admobBannerAdUnitId => Platform.isAndroid
      ? Strings.androidAdmobBannerId
      : Strings.iosAdmobBannerId;
  static String get admobInterstitialAdUnitId => Platform.isAndroid
      ? Strings.androidAdmobInterstitialId
      : Strings.iosAdmobInterstitialId;
  static String get fbBannerAdUnitId =>
      Platform.isAndroid ? "" : Strings.iosFBBannerId;

  static String get fbInterstitialAdUnitId =>
      Platform.isAndroid ? "" : Strings.iosFBInterstitialId;

  static BannerAd? admobBannerAd;
  static bool isAdmobBannerLoaded = false;
  static bool isfbInterstitialAdLoaded = false;

  BannerAd? banner;

  static InterstitialAd? admobInterstitialAd;
  static bool isAdmobInterstitialAdLoaded = false;
  static bool isAdmobInterstitialAdReady = false;
  static int _numInterstitialLoadAttempts = 0;
  static int maxFailedLoadAttempts = 3;

  static String interstitialTag = "";

  static BuildContext? context;

  // testDevices: [Strings.testDevice],

  static initialize() {
    if (MobileAds.instance == null) {
      MobileAds.instance.initialize();
      MobileAds.instance.updateRequestConfiguration(RequestConfiguration(
          testDeviceIds: ['23ccae42061824b847f52b392287252f']));
      //23ccae42061824b847f52b392287252f
    }

    AdService.createBannerAd().load();

    //admobInterstitialAd = AdService.createInterstialAd()..load();
    AdService.createInterstialAd();
  }

  static BannerAd createBannerAd() {
    admobBannerAd = BannerAd(
        size: AdSize.largeBanner,
        adUnitId: Strings.iosAdmobBannerId,
        listener: BannerAdListener(
          onAdLoaded: (_) {
            isAdmobBannerLoaded = true;
            print("Admob Banner Ad Loaded");
            checkForAd();
          },
          onAdFailedToLoad: (_, LoadAdError error) {
            print("Admob Banner Ad Error: " + error.toString());
            _.dispose();
            isAdmobBannerLoaded = false;
          },
        ),
        request: const AdRequest());
    return admobBannerAd!;
  }

  static Widget checkForAd() {
    if (isAdmobBannerLoaded == true) {
      return AdWidget(ad: admobBannerAd!, key: UniqueKey());
    } else {
      return Container();
    }
  }

  static createInterstialAd() {
    InterstitialAd.load(
      adUnitId: Strings.iosAdmobInterstitialId,
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          print('$ad loaded');
          admobInterstitialAd = ad;
          _numInterstitialLoadAttempts = 0;
          admobInterstitialAd!.setImmersiveMode(true);
        },
        onAdFailedToLoad: (LoadAdError error) {
          print('InterstitialAd failed to load: $error.');
          _numInterstitialLoadAttempts += 1;
          admobInterstitialAd = null;
          isAdmobInterstitialAdReady = false;

          if (_numInterstitialLoadAttempts <= maxFailedLoadAttempts) {
            createInterstialAd();
          }
        },

        /*onAdClosed: (InterstitialAd ad) {
          print("Admob InterstitialAd Closed");
          admobInterstitialAd?.dispose();
          isAdmobInterstitialAdReady = false;
          goTo(context, interstitialTag);
          admobInterstitialAd = ad as InterstitialAd?;
        },
        onApplicationExit: (Ad ad) {
          admobInterstitialAd?.dispose();
          isAdmobInterstitialAdReady = false;
        },*/
        /*onAdOpened: (Ad ad) {
          print("Admob InterstitialAd Opened");
          isAdmobInterstitialAdReady = false;
        },
        onAdFailedToLoad: (LoadAdError error) {
          print("Admob InterstitialAd Error: " + error.toString());
          createInterstialAd();
        },*/
      ),
    );
  }

  static void showInterstitialAd() {
    //admobInterstitialAd?.dispose();
    //admobInterstitialAd = null;
    if (admobInterstitialAd == null) {
      admobInterstitialAd = createInterstialAd();
      return;
    } else {
      if (isAdmobInterstitialAdReady == true) {
        admobInterstitialAd?.show();
      }
    }

    admobInterstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad) =>
          print('ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        print('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        isAdmobInterstitialAdReady = false;
        goTo(context, interstitialTag);
        createInterstialAd();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        createInterstialAd();
      },
    );
    admobInterstitialAd!.show();
    admobInterstitialAd = null;
  }

  static void goTo(BuildContext? context, String interstitialTag) {
    switch (interstitialTag) {
      case "message":
        Navigator.of(context!).push(MaterialPageRoute(
            builder: (BuildContext context) => MessagesList()));
        break;
      case "lang_english":
        Navigator.of(context!).push(MaterialPageRoute(
            builder: (BuildContext context) => MessagesList(type: "1")));
        break;

      case "lang_french":
        Navigator.of(context!).push(MaterialPageRoute(
            builder: (BuildContext context) => MessagesList(type: "2")));
        break;

      case "lang_german":
        Navigator.of(context!).push(MaterialPageRoute(
            builder: (BuildContext context) => MessagesList(type: "3")));
        break;

      case "lang_hindi":
        Navigator.of(context!).push(MaterialPageRoute(
            builder: (BuildContext context) => MessagesList(type: "4")));
        break;

      case "lang_italian":
        Navigator.of(context!).push(MaterialPageRoute(
            builder: (BuildContext context) => MessagesList(type: "5")));
        break;

      case "lang_portuguese":
        Navigator.of(context!).push(MaterialPageRoute(
            builder: (BuildContext context) => MessagesList(type: "6")));
        break;

      case "lang_spanish":
        Navigator.of(context!).push(MaterialPageRoute(
            builder: (BuildContext context) => MessagesList(type: "7")));
        break;
      case "gif":
        Navigator.of(context!).push(
            MaterialPageRoute(builder: (BuildContext context) => GifsImages()));
        break;

      case "image":
        Navigator.of(context!).push(
            MaterialPageRoute(builder: (BuildContext context) => ImagesList()));
        break;

      case "shayari":
        Navigator.of(context!).push(MaterialPageRoute(
            builder: (BuildContext context) => ShayariList()));
        break;

      case "meme":
        Navigator.of(context!).push(MaterialPageRoute(
            builder: (BuildContext context) => MemeGenerator()));
        break;

      case "about":
        Navigator.of(context!).push(
            MaterialPageRoute(builder: (BuildContext context) => AboutUs()));
        break;

      case "status":
        Navigator.of(context!).push(
            MaterialPageRoute(builder: (BuildContext context) => StatusList()));
        break;

      case "quotes":
        Navigator.of(context!).push(
            MaterialPageRoute(builder: (BuildContext context) => QuotesList()));
        break;
      default:
    }
  }
}
