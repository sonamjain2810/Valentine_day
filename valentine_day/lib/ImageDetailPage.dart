import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'data/Images.dart';
import 'package:facebook_app_events/facebook_app_events.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'data/Strings.dart';
import 'utils/SizeConfig.dart';

/*
how to pass data into another screen watch this video
https://www.youtube.com/watch?v=d5PpeNb-dOY
 */

// ignore: must_be_immutable
// ignore: late
class ImageDetailPage extends StatefulWidget {
  int? index;
  ImageDetailPage(this.index);
  @override
  _ImageDetailPageState createState() => _ImageDetailPageState(index!);
}

class _ImageDetailPageState extends State<ImageDetailPage> {
  int index;

  _ImageDetailPageState(this.index);

  static final facebookAppEvents = FacebookAppEvents();

  StreamSubscription? _subscription;

  var filePath;
  var BASE64_IMAGE;

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
    _subscription?.cancel();
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
    return PageView.builder(
      controller: PageController(
          initialPage: index, keepPage: true, viewportFraction: 1),
      itemBuilder: (context, index) {
        return Scaffold(
          appBar: AppBar(
              title: Text(
            "Image No. ${index + 1}",
            style: Theme.of(context).appBarTheme.textTheme!.headline1,
          )),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.symmetric(
                    vertical: 1.93 * SizeConfig.widthMultiplier,
                    horizontal: 1.93 * SizeConfig.widthMultiplier),
                child: Card(
                  child: Container(
                      padding:
                          EdgeInsets.all(1.93 * SizeConfig.widthMultiplier),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          CachedNetworkImage(
                            imageUrl: Images.images_path[index],
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
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                          "We are downloading your image to share.. \nKeep Patience Thanks!!",
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
                                      await shareJPGImageFromUrl(
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
                      )),
                ),
              ),
            ),
          ),
          bottomNavigationBar: Container(
              alignment: Alignment.center, height: 50, child: Container()),
        );
      },
    );
  }

  Future<void> shareJPGImageFromUrl(BuildContext context, int index) async {
    try {
      facebookAppEvents.logEvent(
        name: "JPG Share",
        parameters: {
          'jpg_image_url': '$Images.images_path[index]',
        },
      );

      var request =
          await HttpClient().getUrl(Uri.parse(Images.images_path[index]));
      var response = await request.close();
      Uint8List bytes = await consolidateHttpClientResponseBytes(response);
      final tempDir = await getTemporaryDirectory();
      final path = '${tempDir.path}/image.jpg';
      File(path).writeAsBytesSync(bytes);
      final files = <XFile>[];
      final box = context.findRenderObject() as RenderBox?;
      files.add(XFile(path, name: "image"));

      await Share.shareXFiles([files[0]],
          text: "Share Image",
          subject: "subject",
          sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
      //await Share.shareFiles([path]);
    } catch (e) {
      print('error: $e');
    }
  }

  void onImageDowloadButtonPressed() async {
    var response = await http.get(Images.images_path[index] as Uri);
    //filePath = await ImagePickerSaver.saveFile(fileData: response.bodyBytes);
  }

  void onImageShareButtonPressed() async {
    var response = await http.get(Images.images_path[index] as Uri);
    //filePath = await ImagePickerSaver.saveFile(fileData: response.bodyBytes);
    print(filePath);

    BASE64_IMAGE = filePath;

    final ByteData bytes = await rootBundle.load(BASE64_IMAGE);
    //await Share.file('test.png', bytes, 'my image title');
  }
}
