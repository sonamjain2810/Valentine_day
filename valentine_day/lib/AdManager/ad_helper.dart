// Copyright 2020 Google LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'dart:io';

import '../data/Strings.dart';

class AdHelper {

  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return Strings.androidAdmobBannerId;
    } else if (Platform.isIOS) {
      return Strings.iosAdmobBannerId;
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return Strings.androidAdmobInterstitialId;
    } else if (Platform.isIOS) {
      return Strings.iosAdmobInterstitialId;
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

  static String get rewardedAdUnitId {
    if (Platform.isAndroid) {
      return Strings.androidAdmobRewardedId;
    } else if (Platform.isIOS) {
      return Strings.iosAdmobRewardedId;
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }
}
