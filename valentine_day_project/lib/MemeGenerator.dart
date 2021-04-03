import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:facebook_app_events/facebook_app_events.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_native_admob/native_admob_controller.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import 'data/Strings.dart';
import 'utils/SizeConfig.dart';
import 'NativeAdContainer.dart';

class MemeGenerator extends StatefulWidget {
  @override
  _MemeGeneratorState createState() => _MemeGeneratorState();
}

class _MemeGeneratorState extends State<MemeGenerator> {
// Native Ad Open
static String _adUnitID = Strings.iosAdmobNativeId;
  final _nativeAdController = NativeAdmobController();
  double _height = 0;

  StreamSubscription _subscription;

  static final facebookAppEvents = FacebookAppEvents();


//Native Ad Close

  final GlobalKey globalKey = new GlobalKey();

  String headerText = "";
  String footerText = "";

  PickedFile _image;
  File _imageFile;

  bool imageSelected = false;

  Random rng = new Random();
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();

    //Native Ad
    _subscription = _nativeAdController.stateChanged.listen(_onStateChanged);
    //
  }

  @override
  void dispose() {
    //Native Ad
    _subscription.cancel();
    _nativeAdController.dispose();
    super.dispose();
  }

  void _onStateChanged(AdLoadState state) {
    switch (state) {
      case AdLoadState.loading:
        setState(() {
          _height = 0;
        });
        break;

      case AdLoadState.loadCompleted:
        setState(() {
          _height = 36.83 * SizeConfig.heightMultiplier;
        });
        break;

      default:
        break;
    }
  }

  Future getImage() async {
    try {
      final pickedFile = await _picker.getImage(
        source: ImageSource.gallery,
      );

      setState(() {
        if (pickedFile != null) {
          imageSelected = true;
        } else {}
        _image = pickedFile;
      });
    } catch (platformException) {
      print("not allowing " + platformException);
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
    new Directory('storage/emulated/0/' + 'MemeGenerator')
        .create(recursive: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Wish Creator",
          style: Theme.of(context).appBarTheme.textTheme.headline1,
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
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
                              File(_image.path),
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
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1),
                                ),
                              ],
                            ),
                      Container(
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
                                  shadows: <Shadow>[
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
                            Spacer(),
                            Container(
                                padding: EdgeInsets.symmetric(
                                    vertical:
                                        0.90 * SizeConfig.heightMultiplier),
                                child: Text(
                                  footerText.toUpperCase(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    // 26/4.14 = 6.28
                                    fontSize: 6.28 * SizeConfig.textMultiplier,
                                    shadows: <Shadow>[
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
                              decoration:
                                
                                  InputDecoration(
                                    
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
                              decoration:
                                  InputDecoration(hintText: "Enter Footer Text"),
                            ),
                            SizedBox(
                              //20
                              height: 2.23 * SizeConfig.heightMultiplier,
                            ),
                            RaisedButton(
                              onPressed: () {
                                //ToDo
                                takeScreenshot();
                              },
                              child: Text("Save"),
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
                _imageFile != null ? Image.file(_imageFile) : Container(),
                Divider(),
                NativeAdContainer(
                    height: _height,
                    adUnitID: _adUnitID,
                    nativeAdController: _nativeAdController,
                    numberAds: 1,
                    ),
                Divider(),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          getImage();
        },
        child: Icon(Icons.photo_library),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  takeScreenshot() async {
    RenderRepaintBoundary boundary =
        globalKey.currentContext.findRenderObject();
    ui.Image image = await boundary.toImage();
    final directory = (await getApplicationDocumentsDirectory()).path;
    ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List pngBytes = byteData.buffer.asUint8List();
    print(pngBytes);
    File imgFile = new File('$directory/screenshot${rng.nextInt(200)}.png');
    setState(() {
      _imageFile = imgFile;
    });
    _savefile(_imageFile);
    //saveFileLocal();
    imgFile.writeAsBytes(pngBytes);
  }

  _savefile(File file) async {
    await _askPermission();
    final result = await ImageGallerySaver.saveImage(
        Uint8List.fromList(await file.readAsBytes()));
    print(result);
    facebookAppEvents.logEvent(
                        name: "Save Meme",
                        parameters: {
                          'Meme Saved': 'Yes',
                        },
                      );
  }

  _askPermission() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.photos,
      Permission.storage,
    ].request();
    print(statuses[Permission.photos]);
    print(statuses[Permission.storage]);
  }
}
