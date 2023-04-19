import 'dart:async';
import 'package:facebook_app_events/facebook_app_events.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:share_plus/share_plus.dart';
import 'data/AdService.dart';
import 'data/Shayari.dart';
import 'data/Strings.dart';
import 'utils/SizeConfig.dart';

/*
how to pass data into another screen watch this video
https://www.youtube.com/watch?v=d5PpeNb-dOY
 */

class ShayariDetailPage extends StatefulWidget {
  int index;
  ShayariDetailPage(this.index);
  @override
  _ShayariDetailPageState createState() => _ShayariDetailPageState(index);
}

class _ShayariDetailPageState extends State<ShayariDetailPage> {
  int index;
  _ShayariDetailPageState(this.index);
  static final facebookAppEvents = FacebookAppEvents();

  late BannerAd bannerAd1;
  bool isBannerAdLoaded = false;
  @override
  void initState() {
    super.initState();
    bannerAd1 = GetBannerAd();
  }

  BannerAd GetBannerAd() {
    return BannerAd(
        size: AdSize.mediumRectangle,
        adUnitId: Strings.iosAdmobBannerId,
        listener: BannerAdListener(onAdLoaded: (_) {
          setState(() {
            isBannerAdLoaded = true;
          });
        }, onAdFailedToLoad: (ad, error) {
          isBannerAdLoaded = true;
          ad.dispose();
        }),
        request: AdRequest())
      ..load();
  }

  @override
  void dispose() {
    super.dispose();
    bannerAd1.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return PageView.builder(
        controller: PageController(
            initialPage: index, keepPage: true, viewportFraction: 1),
        itemBuilder: (context, index) {
          return Scaffold(
            appBar: AppBar(
                title: Text(
              "Shayari No. ${index + 1}",
              style: Theme.of(context).appBarTheme.toolbarTextStyle,
            )),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(1.93 * SizeConfig.widthMultiplier),
                  child: Card(
                    child: Container(
                        padding:
                            EdgeInsets.all(1.93 * SizeConfig.widthMultiplier),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(Shayari.shayari_data[index],
                                style: Theme.of(context).textTheme.bodyText1),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: 1.93 * SizeConfig.widthMultiplier),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  ElevatedButton(
                                      child: const Text("Share"),
                                      onPressed: () {
                                        setState(() {});
                                        print("Share Button Clicked");
                                        shareText(
                                            "${Shayari.shayari_data[index]}\nShare Via:\n${Strings.shareAppText}");
                                      }),
                                ],
                              ),
                            ),
                            Divider(),
                            Center(
                              child: Container(
                                height: bannerAd1.size.height.toDouble(),
                                width: bannerAd1.size.width.toDouble(),
                                child: AdWidget(ad: bannerAd1),
                              ),
                            ),
                          ],
                        )),
                  ),
                ),
              ),
            ),
            bottomNavigationBar: Container(
                alignment: Alignment.center, height: 50, child: Container()),
          );
        });
  }

  Future<void> shareText(String message) async {
    try {
      Share.share(message);
    } catch (e) {
      print('error: $e');
    }

    facebookAppEvents.logEvent(
      name: "Quotes Share",
      parameters: {
        'quotes_shared': '$message',
      },
    );
  }
}
