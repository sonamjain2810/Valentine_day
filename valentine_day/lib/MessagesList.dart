import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'data/Messages.dart';
import 'package:facebook_app_events/facebook_app_events.dart';
import 'package:flutter/material.dart';

import 'data/Strings.dart';
import 'utils/SizeConfig.dart';
import 'MessageDetailPage.dart';

// ignore: must_be_immutable
class MessagesList extends StatefulWidget {
  String? type;
  MessagesList({this.type});
  @override
  _MessagesListState createState() => _MessagesListState(type!);
}

class _MessagesListState extends State<MessagesList> {
  String type;
  _MessagesListState(this.type);

  static final facebookAppEvents = FacebookAppEvents();

  var data;

  late BannerAd bannerAd1;
  bool isBannerAdLoaded = false;
  @override
  void initState() {
    super.initState();
    bannerAd1 = GetBannerAd();
  }

  BannerAd GetBannerAd() {
    return BannerAd(
        size: AdSize.largeBanner,
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
    if (type == '1') {
      // English
      data = Messages.english_data;
    } else if (type == '4') {
      // Hindi
      data = Messages.hindi_data;
    } else if (type == '3') {
      // German
      data = Messages.german_data;
    } else if (type == '2') {
      // french
      data = Messages.french_data;
    } else if (type == '5') {
      // Italian
      data = Messages.italy_data;
    } else if (type == '6') {
      // Portuguese
      data = Messages.portugal_data;
    } else {
      // Spanish:
      data = Messages.spanish_data;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Message List",
          style: Theme.of(context).appBarTheme.textTheme?.headline1,
        ),
      ),
      body: SafeArea(
        child: data != null
            ? ListView.builder(
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  MessageDetailPage(type, index)));

                      facebookAppEvents.logEvent(
                        name: "Message List",
                        parameters: {
                          'clicked_on_message_index': '$index',
                        },
                      );
                    },
                    child: Padding(
                      padding:
                          EdgeInsets.all(1.93 * SizeConfig.widthMultiplier),
                      child: Column(
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primaryVariant,
                                ),
                                borderRadius:
                                    // 40 /8.98 = 4.46
                                    BorderRadius.all(Radius.circular(
                                        4.46 * SizeConfig.widthMultiplier))),
                            child: ListTile(
                              leading: Icon(Icons.brightness_1,
                                  color:
                                      Theme.of(context).primaryIconTheme.color),
                              title: Text(
                                data[index],
                                maxLines: 2,
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              trailing: Icon(Icons.arrow_forward_ios,
                                  color:
                                      Theme.of(context).primaryIconTheme.color),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                itemCount: data.length,
              )
            : Center(
                child: CircularProgressIndicator(),
              ),
      ),
      bottomNavigationBar: Container(
        alignment: Alignment.center,
        height: bannerAd1.size.height.toDouble(),
        width: bannerAd1.size.width.toDouble(),
        child: AdWidget(ad: bannerAd1),
      ),
    );
  }
}
