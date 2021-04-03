import 'dart:async';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:facebook_app_events/facebook_app_events.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_admob/native_admob_controller.dart';

import 'data/Messages.dart';
import 'data/Strings.dart';
import 'utils/SizeConfig.dart';
import 'NativeAdContainer.dart';

/*
how to pass data into another screen watch this video
https://www.youtube.com/watch?v=d5PpeNb-dOY
 */

class MessageDetailPage extends StatefulWidget {
  String type;
  int defaultIndex;
  MessageDetailPage(this.type, this.defaultIndex);
  @override
  _MessageDetailPageState createState() =>
      _MessageDetailPageState(type, defaultIndex);
}

class _MessageDetailPageState extends State<MessageDetailPage> {
  String type;
  int defaultIndex;
  _MessageDetailPageState(this.type, this.defaultIndex);
  static final facebookAppEvents = FacebookAppEvents();

  // Native Ad Open
static String _adUnitID = Strings.iosAdmobNativeId;
  final _nativeAdController = NativeAdmobController();
  double _height = 0;

  StreamSubscription _subscription;

  var data = [];

//Native Ad Close

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


    return PageView.builder(
      controller: PageController(
          initialPage: defaultIndex, keepPage: true, viewportFraction: 1),
      itemBuilder: (context, index) {
        return Scaffold(
          appBar: AppBar(
              title: Text(
            "Message No. ${index + 1}",
            style: Theme.of(context).appBarTheme.textTheme.headline1,
          )),
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.all(1.93 * SizeConfig.widthMultiplier),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Card(
                  child: new Container(
                    padding:
                        new EdgeInsets.all(1.93 * SizeConfig.widthMultiplier),
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(data[index],
                            style: Theme.of(context).textTheme.bodyText1),
                        Padding(
                          padding: EdgeInsets.only(
                              top: 1.93 * SizeConfig.widthMultiplier),
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              RaisedButton(
                                  child: Text("Share"),
                                  onPressed: () {
                                    setState(() {});
                                    print("Share Button Clicked");
                                    shareText(data[index] +
                                        "\n" +
                                        "Share Via:" +
                                        "\n" +
                                        Strings.shareAppText);
                                  }),
                            ],
                          ),
                        ),
                        Divider(),
                        NativeAdContainer(
                            height: _height,
                            adUnitID: _adUnitID,
                            nativeAdController: _nativeAdController,
                            numberAds: 1,
                            ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> shareText(String message) async {
    try {
      Share.text('Share Message', message, 'text/plain');
    } catch (e) {
      print('error: $e');
    }

    facebookAppEvents.logEvent(
      name: "Message Share",
      parameters: {
        'message_shared': '$message',
      },
    );
  }
}
