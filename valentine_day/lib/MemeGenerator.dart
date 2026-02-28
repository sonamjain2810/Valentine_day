import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import 'data/Strings.dart';
import 'utils/SizeConfig.dart';

class MemeGenerator extends StatefulWidget {
  @override
  _MemeGeneratorState createState() => _MemeGeneratorState();
}

class _MemeGeneratorState extends State<MemeGenerator> {
  final GlobalKey globalKey = GlobalKey();

  String headerText = "";
  String footerText = "";

  XFile? _image;
  File? _imageFile;

  bool imageSelected = false;

  Random rng = Random();
  final ImagePicker _picker = ImagePicker();

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
        adUnitId: Platform.isAndroid
            ? Strings.androidAdmobBannerId
            : Strings.iosAdmobBannerId,
        listener: BannerAdListener(onAdLoaded: (_) {
          setState(() {
            isBannerAdLoaded = true;
          });
        }, onAdFailedToLoad: (ad, error) {
          isBannerAdLoaded = true;
          ad.dispose();
        }),
        request: const AdRequest())
      ..load();
  }

  @override
  void dispose() {
    super.dispose();
    bannerAd1.dispose();
  }

  Future getImage() async {
    try {
      final pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 100,
      );

      setState(() {
        if (pickedFile != null) {
          imageSelected = true;
        } else {}
        _image = pickedFile;
      });
    } catch (platformException) {
      debugPrint("not allowing $platformException");
    }

    /* try { 
      image = await ImagePicker.pickImage(source: ImageSource.gallery);
    } catch (platformException) {
      print("not allowing " + platformException);
    }
    setState(() {
      if (image != null) {
        imageSelected = true;
      } else {}
      _image = image;
    });*/
    Directory('storage/emulated/0/MemeGenerator').create(recursive: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Invitation & Card Creator",
          style: Theme.of(context).appBarTheme.toolbarTextStyle,
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: <Widget>[
              SizedBox(
                //15
                height: 1.67 * SizeConfig.heightMultiplier,
              ),
              RepaintBoundary(
                key: globalKey,
                child: Stack(
                  children: <Widget>[
                    _image != null
                        ? Image.file(
                            File(_image!.path),
                            //300
                            height: 33.48 * SizeConfig.heightMultiplier,
                            fit: BoxFit.fill,
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Center(
                                child: Text("Select Image to Get Started",
                                    style:
                                        Theme.of(context).textTheme.bodyLarge),
                              ),
                            ],
                          ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      //300
                      height: 33.48 * SizeConfig.heightMultiplier,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            //8 / 8.96 = 0.90
                            padding: EdgeInsets.symmetric(
                                vertical: 0.90 * SizeConfig.heightMultiplier),
                            child: Text(
                              headerText.toUpperCase(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 6.28 * SizeConfig.textMultiplier,
                                shadows: const <Shadow>[
                                  Shadow(
                                    offset: Offset(2.0, 2.0),
                                    blurRadius: 3.0,
                                    color: Colors.black87,
                                  ),
                                  Shadow(
                                    offset: Offset(2.0, 2.0),
                                    blurRadius: 8.0,
                                    color: Colors.black87,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const Spacer(),
                          Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 0.90 * SizeConfig.heightMultiplier),
                              child: Text(
                                footerText.toUpperCase(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  // 26/4.14 = 6.28
                                  fontSize: 6.28 * SizeConfig.textMultiplier,
                                  shadows: const <Shadow>[
                                    Shadow(
                                      offset: Offset(2.0, 2.0),
                                      blurRadius: 3.0,
                                      color: Colors.black87,
                                    ),
                                    Shadow(
                                      offset: Offset(2.0, 2.0),
                                      blurRadius: 8.0,
                                      color: Colors.black87,
                                    ),
                                  ],
                                ),
                              ))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 2.23 * SizeConfig.heightMultiplier,
              ),
              imageSelected
                  ? Container(
                      // 20
                      padding: EdgeInsets.symmetric(
                          horizontal: 4.83 * SizeConfig.widthMultiplier),
                      child: Column(
                        children: <Widget>[
                          TextField(
                            onChanged: (val) {
                              setState(() {
                                headerText = val;
                              });
                            },
                            decoration: const InputDecoration(
                                hintText: "Enter Header Text"),
                          ),
                          SizedBox(
                            //10
                            height: 1.12 * SizeConfig.heightMultiplier,
                          ),
                          TextField(
                            onChanged: (val) {
                              setState(() {
                                footerText = val;
                              });
                            },
                            decoration: const InputDecoration(
                                hintText: "Enter Footer Text"),
                          ),
                          SizedBox(
                            //20
                            height: 2.23 * SizeConfig.heightMultiplier,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              //ToDo
                              takeScreenshot();
                            },
                            child: const Text("Save"),
                          )
                        ],
                      ),
                    )
                  : Container(
                      // child: Center(
                      //   child: Text("Select image to get started",
                      //       style: Theme.of(context).textTheme.bodyText1),
                      // ),
                      ),
              _imageFile != null ? Image.file(_imageFile!) : Container(),
              const Divider(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          getImage();
        },
        child: const Icon(Icons.photo_library),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      bottomNavigationBar: Container(
        alignment: Alignment.center,
        height: bannerAd1.size.height.toDouble(),
        width: bannerAd1.size.width.toDouble(),
        child: AdWidget(ad: bannerAd1),
      ),
    );
  }

  takeScreenshot() async {
    RenderRepaintBoundary boundary =
        globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage();
    final directory = (await getApplicationDocumentsDirectory()).path;
    ByteData byteData =
        await image.toByteData(format: ui.ImageByteFormat.png) as ByteData;
    Uint8List pngBytes = byteData.buffer.asUint8List();
    debugPrint(pngBytes.toString());
    File imgFile = File('$directory/screenshot${rng.nextInt(200)}.png');
    setState(() {
      _imageFile = imgFile;
    });
    _savefile(_imageFile!);
    //saveFileLocal();
    imgFile.writeAsBytes(pngBytes);
  }

  _savefile(File file) async {
    await _askPermission();
    final result = await ImageGallerySaver.saveImage(
        Uint8List.fromList(await file.readAsBytes()));
    debugPrint(result);
  }

  _askPermission() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.photos,
      Permission.storage,
    ].request();
    debugPrint(statuses[Permission.photos].toString());
    debugPrint(statuses[Permission.storage].toString());
  }
}
