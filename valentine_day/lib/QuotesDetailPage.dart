import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:share_plus/share_plus.dart';
import 'AdManager/ad_helper.dart';
import 'data/Quotes.dart';
import 'data/Strings.dart';
import 'utils/SizeConfig.dart';
import 'utils/pass_data_between_screens.dart';

class QuotesDetailPage extends StatefulWidget {
  QuotesDetailPage({super.key});
  @override
  _QuotesDetailPageState createState() => _QuotesDetailPageState();
}

class _QuotesDetailPageState extends State<QuotesDetailPage> {
  late String type;
  late int defaultIndex;
  BannerAd? _bannerAd;

  @override
  void initState() {
    super.initState();
    loadBannerAd().load();
  }

  BannerAd loadBannerAd() {
    return BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            _bannerAd = ad as BannerAd;
          });
        },
        onAdFailedToLoad: (ad, err) {
          debugPrint('Failed to load a banner ad: ${err.message}');
          ad.dispose();
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _bannerAd?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final args =
        ModalRoute.of(context)!.settings.arguments as PassDataBetweenScreens;

    type = args.title;
    defaultIndex = int.parse(args.message);

    return PageView.builder(
      controller: PageController(
        initialPage: defaultIndex,
        keepPage: true,
        viewportFraction: 1,
      ),
      itemBuilder: (context, index) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "Quote No. ${index + 1}",
              style: theme.appBarTheme.titleTextStyle,
            ),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(2.5 * SizeConfig.widthMultiplier),
              child: Card(
                color: theme.cardTheme.color,
                elevation: theme.cardTheme.elevation,
                shadowColor: theme.cardTheme.shadowColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    4.46 * SizeConfig.widthMultiplier,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(2.5 * SizeConfig.widthMultiplier),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        Quotes.quotesData[index],
                        style: theme.textTheme.bodyLarge,
                      ),
                      SizedBox(height: 3 * SizeConfig.heightMultiplier),
                      Center(
                        child: ElevatedButton(
                            onPressed: () => _onShare(context, "${Quotes.quotesData[index]}\n\nShare Via:\n${Strings.shareAppText}"),

                            child: const Text("Share"),
                          ),),
                    ],
                  ),
                ),
              ),
            ),
          ),
          bottomNavigationBar: BottomAppBar(
            child: _bannerAd != null
                ? SizedBox(
                    width: _bannerAd!.size.width.toDouble(),
                    height: _bannerAd!.size.height.toDouble(),
                    child: AdWidget(ad: _bannerAd!),
                  )
                : const SizedBox.shrink(),
          ),
        );
      },
    );
  }

  void _onShare(BuildContext context, String text) async {
    try {
      final size = MediaQuery.of(context).size;

      final Rect origin = Rect.fromCenter(
        center: Offset(size.width / 2, size.height / 2),
        width: 1,
        height: 1,
      );

      await Share.share(text, subject: "Share", sharePositionOrigin: origin);
    } catch (e) {
      debugPrint("Share failed: $e");
    }
  }
}
