import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:share_plus/share_plus.dart';
import 'data/Quotes.dart';
import 'data/Strings.dart';
import 'utils/SizeConfig.dart';

/*
how to pass data into another screen watch this video
https://www.youtube.com/watch?v=d5PpeNb-dOY
 */

class QuotesDetailPage extends StatefulWidget {
  int? index;
  QuotesDetailPage(this.index);
  @override
  _QuotesDetailPageState createState() => _QuotesDetailPageState(index!);
}

class _QuotesDetailPageState extends State<QuotesDetailPage> {
  int? index;
  _QuotesDetailPageState(this.index);

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
            initialPage: index!, keepPage: true, viewportFraction: 1),
        itemBuilder: (context, index) {
          return Scaffold(
            appBar: AppBar(
                title: Text(
              "Quotes No. ${index + 1}",
              style: Theme.of(context).appBarTheme.textTheme!.headline1,
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
                            Text(Quotes.quotes_data[index],
                                style: Theme.of(context).textTheme.bodyText1),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: 1.93 * SizeConfig.widthMultiplier),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Builder(builder: (BuildContext context) {
                                    return ElevatedButton(
                                        child: Text("Share"),
                                        onPressed: () {
                                          print("Share Button Clicked");
                                          _onShare(
                                              context,
                                              Quotes.quotes_data[index] +
                                                  "\n" +
                                                  "Share Via:" +
                                                  "\n" +
                                                  Strings.shareAppText);
                                        });
                                  })
                                ],
                              ),
                            ),
                            Divider(),

                            //banner
                            Center(
                              child: Container(
                                height: bannerAd1.size.height.toDouble(),
                                width: bannerAd1.size.width.toDouble(),
                                child: AdWidget(ad: bannerAd1),
                              ),
                            ),
                            //banner
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

  void _onShare(BuildContext context, String text) async {
    // A builder is used to retrieve the context immediately
    // surrounding the ElevatedButton.
    //
    // The context's `findRenderObject` returns the first
    // RenderObject in its descendent tree when it's not
    // a RenderObjectWidget. The ElevatedButton's RenderObject
    // has its position and size after it's built.
    final box = context.findRenderObject() as RenderBox?;

    /*if (imagePaths.isNotEmpty) {
      final files = <XFile>[];
      for (var i = 0; i < imagePaths.length; i++) {
        files.add(XFile(imagePaths[i], name: imageNames[i]));
      }
      await Share.shareXFiles(files,
          text: text,
          subject: subject,
          sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
    } else {*/
    await Share.share(text,
        subject: "Share",
        sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
    //}
  }

  Future<void> shareText(String message) async {
    try {
      Share.share(message);
    } catch (e) {
      print('error: $e');
    }
  }
}
