import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'AdManager/ad_helper.dart';
import 'Enums/project_routes_enum.dart';
import 'Singleton/project_manager.dart';
import 'data/Messages.dart';
import 'utils/SizeConfig.dart';
import 'utils/pass_data_between_screens.dart';

class MessagesList extends StatefulWidget {
  const MessagesList({super.key});

  @override
  State<MessagesList> createState() => _MessagesListState();
}

class _MessagesListState extends State<MessagesList> {
  late String type;
  var data;
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
          debugPrint('Ad load failed: ${error.message}');
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
    final args = ModalRoute.of(context)!.settings.arguments as PassDataBetweenScreens;
    type = args.title;

    debugPrint('Message List Build Method: Message type is $type');

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
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Message List", style: Theme.of(context).appBarTheme.titleTextStyle),
      ),
      body: SafeArea(
        child: data != null
            ? ListView.builder(
                itemCount: data.length,
                padding: EdgeInsets.symmetric(
                  vertical: SizeConfig.height(12),
                  horizontal: SizeConfig.width(12),
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      ProjectManager.instance.clickOnButton(
                        ProjectRoutes.messagesDetailPage.toString(),
                        PassDataBetweenScreens(type, index.toString()),
                      );
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(
                          color: Theme.of(context).colorScheme.secondary.withOpacity(0.3),
                          width: 1.0,
                        ),
                      ),
                      elevation: Theme.of(context).cardTheme.elevation,
                      color: Theme.of(context).cardTheme.color,
                      margin: EdgeInsets.symmetric(vertical: SizeConfig.height(8)),
                      child: ListTile(
                        leading: Icon(Icons.message, color: Theme.of(context).iconTheme.color),
                        title: Text(
                          data[index],
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                        trailing: Icon(Icons.arrow_forward_ios,
                            size: 16, color: Theme.of(context).iconTheme.color),
                      ),
                    ),
                  );
                },
              )
            : const Center(child: CircularProgressIndicator()),
      ),
      bottomNavigationBar: _bannerAd != null
          ? SizedBox(
              height: _bannerAd!.size.height.toDouble(),
              width: _bannerAd!.size.width.toDouble(),
              child: AdWidget(ad: _bannerAd!),
            )
          : const SizedBox.shrink(),
    );
  }
}
