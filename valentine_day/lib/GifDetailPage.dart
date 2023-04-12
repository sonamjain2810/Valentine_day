import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:share_plus/share_plus.dart';
import 'data/Gifs.dart';
import 'package:dio/dio.dart';
import 'package:facebook_app_events/facebook_app_events.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'data/Strings.dart';
import 'utils/SizeConfig.dart';
/*
how to pass data into another screen watch this video
https://www.youtube.com/watch?v=d5PpeNb-dOY
 */

class GifDetailPage extends StatefulWidget {
  int? index;
  GifDetailPage(this.index);

  @override
  _GifDetailPageState createState() => _GifDetailPageState(index!);
}

// Height = 8.96
// Width = 4.14
class _GifDetailPageState extends State<GifDetailPage> {
  int index;
  _GifDetailPageState(this.index);

  static final facebookAppEvents = FacebookAppEvents();

  late BannerAd bannerAd1;
  bool isBannerAdLoaded = false;
  @override
  void initState() {
    super.initState();
    _requestPermission();
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

  bool visible = false;

  loadProgress() {
    if (visible == true) {
      setState(() {
        visible = false;
      });
    } else {
      setState(() {
        visible = true;
      });
    }
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
              "Gif No. ${index + 1}",
              //20 & 2
              style: Theme.of(context).appBarTheme.textTheme?.headline1,
            )),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.all(1.93 * SizeConfig.widthMultiplier),
                    child: Card(
                      child: Container(
                        padding:
                            EdgeInsets.all(1.93 * SizeConfig.widthMultiplier),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            CachedNetworkImage(
                              imageUrl: Gifs.gifs_path[index],
                              placeholder: (context, url) =>
                                  const CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                              fadeOutDuration: const Duration(seconds: 1),
                              fadeInDuration: const Duration(seconds: 3),
                            ),

                            Padding(
                              padding: EdgeInsets.all(
                                  1.93 * SizeConfig.widthMultiplier),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Visibility(
                                      maintainSize: true,
                                      maintainAnimation: true,
                                      maintainState: true,
                                      visible: visible,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(
                                            "We are downloading your image to share.. \nBe Paitence Thanks!!",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1,
                                          ),
                                          CircularProgressIndicator(),
                                        ],
                                      )),
                                  Builder(builder: (BuildContext context) {
                                    return ElevatedButton(
                                      onPressed: () async {
                                        setState(() {});
                                        loadProgress();
                                        await shareGIFImageFromUrl(
                                            context, index);
                                        loadProgress();
                                      },
                                      child: Text('Share'),
                                    );
                                  })
                                ],
                              ),
                            ),
                            Divider(),
                            //banner
                            Container(
                              height: bannerAd1.size.height.toDouble(),
                              width: bannerAd1.size.width.toDouble(),
                              child: AdWidget(ad: bannerAd1),
                            ),
                            //banner
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }

  Future<void> shareGIFImageFromUrl(BuildContext context, int index) async {
    try {
      var request = await HttpClient().getUrl(Uri.parse(Gifs.gifs_path[index]));
      var response = await request.close();
      Uint8List bytes = await consolidateHttpClientResponseBytes(response);
      final tempDir = await getTemporaryDirectory();
      final path = '${tempDir.path}/image.gif';
      File(path).writeAsBytesSync(bytes);
      final files = <XFile>[];
      final box = context.findRenderObject() as RenderBox?;

      files.add(XFile(path, name: "image"));

      await Share.shareXFiles([files[0]],
          text: "Share GIF",
          subject: "subject",
          sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
      //await Share.shareFiles([path]);
    } catch (e) {
      print('error: $e');
    }

    facebookAppEvents.logEvent(
      name: "GIF Share",
      parameters: {
        'gif_image_url': '$Gifs.gifs_path[index]',
      },
    );
  }

  _requestPermission() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
    ].request();

    final info = statuses[Permission.storage].toString();
    print(info);
    //_toastInfo(info);
  }
}
