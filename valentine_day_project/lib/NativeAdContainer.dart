import 'package:flutter/material.dart';
import 'package:flutter_native_admob/flutter_native_admob.dart';
import 'package:flutter_native_admob/native_admob_controller.dart';

import 'utils/SizeConfig.dart';

class NativeAdContainer extends StatelessWidget {
  const NativeAdContainer({
    Key key,
    @required double height,
    @required String adUnitID,
    @required int numberAds,
    @required NativeAdmobController nativeAdController,

  }) : _numberAds = numberAds,_height = height, _adUnitID = adUnitID, _nativeAdController = nativeAdController, super(key: key);

  final double _height;
  final String _adUnitID;
  final NativeAdmobController _nativeAdController;
  final int _numberAds;


  @override
  Widget build(BuildContext context) {
    return Container(
      height: _height,
      padding: EdgeInsets.all(2.20 * SizeConfig.heightMultiplier),
      
      child: NativeAdmob(
        // Your ad unit id
        adUnitID: _adUnitID,
        controller: _nativeAdController,
        numberAds: _numberAds,


        // Don't show loading widget when in loading state
        loading: Container(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}