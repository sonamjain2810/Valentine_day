import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'utils/pass_data_between_screens.dart';
import 'AdManager/ad_helper.dart';
import 'AdManager/ad_manager.dart';
import 'Enums/project_routes_enum.dart';
import 'Singleton/project_manager.dart';
import 'data/Quotes.dart';
import 'data/Strings.dart';
import 'utils/SizeConfig.dart';

class QuotesList extends StatefulWidget {
  @override
  _QuotesListState createState() => _QuotesListState();
}

class _QuotesListState extends State<QuotesList> {
  var data = Quotes.quotesData;
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

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Quotes List",
          style: theme.appBarTheme.titleTextStyle,
        ),
      ),
      body: SafeArea(
        child: data != null
            ? ListView.builder(
                itemCount: data.length,
                padding: EdgeInsets.symmetric(
                  vertical: 1.93 * SizeConfig.widthMultiplier,
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      ProjectManager.instance.clickOnButton(
                        ProjectRoutes.quotesDetailPage.toString(),
                        PassDataBetweenScreens("6", index.toString()),
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 1.2 * SizeConfig.heightMultiplier,
                          horizontal: 2.5 * SizeConfig.widthMultiplier),
                      child: Card(
                        elevation: theme.cardTheme.elevation,
                        shadowColor: theme.cardTheme.shadowColor,
                        color: theme.cardTheme.color,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              4.46 * SizeConfig.widthMultiplier),
                          side: BorderSide(
                            color: theme.colorScheme.primaryContainer,
                          ),
                        ),
                        child: ListTile(
                          leading: Icon(Icons.format_quote,
                              color: theme.iconTheme.color),
                          title: Text(
                            data[index],
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.labelLarge,
                          ),
                          trailing: Icon(Icons.arrow_forward_ios,
                              color: theme.iconTheme.color),
                        ),
                      ),
                    ),
                  );
                },
              )
            : const Center(child: CircularProgressIndicator()),
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
  }
}
