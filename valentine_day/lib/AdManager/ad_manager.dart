import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../utils/pass_data_between_screens.dart';
import 'ad_helper.dart';

class AdManager {
  AdManager._();

  static final AdManager _instance = AdManager._();

  static AdManager get instance => _instance;

  AdListener? adListener;

  int adCounter = 0;

  // COMPLETE: Add _interstitialAd
  InterstitialAd? _interstitialAd;

  late String screenName;
  late PassDataBetweenScreens? object;

  void loadAdsInAdManager() async {
    debugPrint("AdManager is Started Loading Ads...");

    await MobileAds.instance.updateRequestConfiguration(
      RequestConfiguration(testDeviceIds: ['23ccae42061824b847f52b392287252f']),
    );

    loadInterstitialAd();
  }

  void showInterstitialAd(s, [PassDataBetweenScreens? object]) {
    debugPrint("Show Interstitial Ads");
    screenName = s;
    this.object = object;
    if (_interstitialAd != null) {
      _interstitialAd?.show();
    } else {
      adListener?.moveToScreenAfterAd(screenName, object);
      loadInterstitialAd();
    }
  }

  // COMPLETE: Implement _loadInterstitialAd()
  void loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: AdHelper.interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _interstitialAd = ad;
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              adListener?.moveToScreenAfterAd(screenName, object);
              loadInterstitialAd();
            },
          );
        },
        onAdFailedToLoad: (err) {
          debugPrint('Failed to load an interstitial ad: ${err.message}');
          adListener?.moveToScreenAfterAd(screenName, object);
          loadInterstitialAd();
        },
      ),
    );
  }

  void loadBannerAd(BannerAdListener bannerAdListener) {
    // COMPLETE: Load a banner ad
    BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: bannerAdListener,
    ).load();
  }
}

abstract class AdListener {
  void moveToScreenAfterAd(String s, [PassDataBetweenScreens? object]);
}
