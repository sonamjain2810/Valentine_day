import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:share_plus/share_plus.dart';
import 'package:valentine_day/data/Strings.dart';
import 'AdManager/ad_helper.dart';
import 'data/Messages.dart';
import 'utils/SizeConfig.dart';
import 'utils/pass_data_between_screens.dart';

class MessageDetailPage extends StatefulWidget {
  const MessageDetailPage({super.key});

  @override
  State<MessageDetailPage> createState() => _MessageDetailPageState();
}

class _MessageDetailPageState extends State<MessageDetailPage> {
  late String type;
  late int defaultIndex;
  var data = [];

  BannerAd? _bannerAd;

  @override
  void initState() {
    super.initState();
    _loadBannerAd();
  }

  void _loadBannerAd() {
    final ad = BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (ad) => setState(() => _bannerAd = ad as BannerAd),
        onAdFailedToLoad: (ad, error) {
          debugPrint('Ad load failed: \${error.message}');
          ad.dispose();
        },
      ),
    );
    ad.load();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as PassDataBetweenScreens;
    type = args.title;
    defaultIndex = int.parse(args.message);

    if (type == '1') {
      // English
      data = Messages.englishData;
    } else if (type == '4') {
      // Hindi
      data = Messages.hindiData;
    } else if (type == '3') {
      // German
      data = Messages.germanData;
    } else if (type == '2') {
      // french
      data = Messages.frenchData;
    } else if (type == '5') {
      // Italian
      data = Messages.italyData;
    } else if (type == '6') {
      // Portuguese
      data = Messages.portugalData;
    } else {
      // Spanish:
      data = Messages.spanishData;
    } // Adjust logic if multiple types are needed

    return PageView.builder(
      controller: PageController(initialPage: defaultIndex),
      itemCount: data.length,
      itemBuilder: (context, index) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "Message No. ${index + 1}",
              style: Theme.of(context).appBarTheme.titleTextStyle,
            ),
          ),
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.all(SizeConfig.width(12)),
              child: SingleChildScrollView(
                child: Card(
                  elevation: Theme.of(context).cardTheme.elevation,
                  color: Theme.of(context).cardTheme.color,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(
                      color: Theme.of(
                        context,
                      ).colorScheme.secondary.withOpacity(0.3),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(SizeConfig.width(12)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          data[index],
                          style: Theme.of(context).textTheme.bodyLarge,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        Center(
                          child: ElevatedButton(
                            onPressed: () => _onShare(context, "${data[index]}\n\nShare Via:\n${Strings.shareAppText}"),

                            child: const Text("Share"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          bottomNavigationBar: _bannerAd != null
              ? SizedBox(
                  height: _bannerAd!.size.height.toDouble(),
                  width: _bannerAd!.size.width.toDouble(),
                  child: AdWidget(ad: _bannerAd!),
                )
              : const SizedBox.shrink(),
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

    await Share.share(
      text,
      subject: "Share",
      sharePositionOrigin: origin,
    );
  } catch (e) {
    debugPrint("Share failed: $e");
  }
}


}
