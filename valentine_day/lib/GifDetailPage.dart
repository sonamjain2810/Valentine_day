import 'dart:async';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:share_plus/share_plus.dart';
import 'AdManager/ad_helper.dart';
import 'data/Gifs.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'data/Strings.dart';
import 'utils/SizeConfig.dart';
import 'utils/pass_data_between_screens.dart';

class GifDetailPage extends StatefulWidget {
  GifDetailPage();

  @override
  _GifDetailPageState createState() => _GifDetailPageState();
}

class _GifDetailPageState extends State<GifDetailPage> {
  String? type;
  int? defaultIndex;
  BannerAd? _bannerAd;
  bool visible = false;

  @override
  void initState() {
    super.initState();
    _requestPermission();
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

  void loadProgress() {
    setState(() {
      visible = !visible;
    });
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as PassDataBetweenScreens;
    type = args.title;
    defaultIndex = int.parse(args.message);

    return PageView.builder(
      controller: PageController(initialPage: defaultIndex!, keepPage: true),
      itemBuilder: (context, index) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "Gif No. ${index + 1}",
              style: Theme.of(context).appBarTheme.titleTextStyle,
            ),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding: EdgeInsets.all(1.93 * SizeConfig.widthMultiplier),
                  child: Card(
                    color: Theme.of(context).cardColor,
                    shadowColor: Theme.of(context).shadowColor,
                    elevation: 4.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Container(
                      padding: EdgeInsets.all(
                        1.93 * SizeConfig.widthMultiplier,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: CachedNetworkImage(
                              imageUrl: Gifs.gifsPath[index],
                              placeholder: (context, url) => Center(
                                child: CircularProgressIndicator(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                              fadeOutDuration: const Duration(seconds: 1),
                              fadeInDuration: const Duration(seconds: 3),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(
                              1.93 * SizeConfig.widthMultiplier,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Visibility(
                                  maintainSize: true,
                                  maintainAnimation: true,
                                  maintainState: true,
                                  visible: visible,
                                  child: Column(
                                    children: [
                                      Text(
                                        "We are downloading your image to share.. \nBe Paitence Thanks!!",
                                        style: Theme.of(
                                          context,
                                        ).textTheme.bodySmall,
                                      ),
                                      const SizedBox(height: 8),
                                      CircularProgressIndicator(
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.primary,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Builder(
                                  builder: (buttonContext) {
                                    return ElevatedButton(
                                      onPressed: () async {
                                        loadProgress();
                                        await shareGIFImageFromUrl(
                                          buttonContext,
                                          index,
                                        );
                                        loadProgress();
                                      },
                                      child: const Text('Share'),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
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
                : Container(),
          ),
        );
      },
    );
  }

  Future<void> shareGIFImageFromUrl(BuildContext context, int index) async {
    try {
      var request = await HttpClient().getUrl(Uri.parse(Gifs.gifsPath[index]));
      var response = await request.close();
      Uint8List bytes = await consolidateHttpClientResponseBytes(response);
      final tempDir = await getTemporaryDirectory();
      final path = '${tempDir.path}/image.gif';
      File(path).writeAsBytesSync(bytes);
      final files = <XFile>[XFile(path, name: "image")];

      final box = context.findRenderObject();
      if (box is RenderBox) {
        await Share.shareXFiles(
          [XFile(path, name: "image.gif")],
          text:
              "GIF Shared with ${Strings.appName}\nDownload App Now: ${Strings.appUrl}",
          sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size,
        );
      } else {
        await Share.shareXFiles(
          [XFile(path, name: "image.gif")],
          text:
              "GIF Shared with ${Strings.appName}\nDownload App Now: ${Strings.appUrl}",
        );
      }
    } catch (e) {
      debugPrint('error: $e');
    }
  }

  void _requestPermission() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
    ].request();

    final info = statuses[Permission.storage].toString();
    debugPrint(info);
  }
}
