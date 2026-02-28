import 'package:flutter/material.dart';

import '../utils/pass_data_between_screens.dart';

class ProjectManager {
  ProjectManager._();

  static final ProjectManager _instance = ProjectManager._();

  static ProjectManager get instance => _instance;

  ProjectListener? listener;

  int adCounter = 0;

  void startApp() {
    debugPrint("1. App is Started");
  }

  void clickOnButton(String s, [PassDataBetweenScreens? object]) {
    adCounter++;

    debugPrint("2. Click on Elevated Button with adCounter = $adCounter");

    if (adCounter % 3 == 0) {
      listener?.showAd(s, object);
    } else {
      listener?.moveToScreen(s, object);
    }
  }
}

abstract class ProjectListener 
{
  void moveToScreen(String s, [PassDataBetweenScreens? object]);
  void showAd(String s, [PassDataBetweenScreens? object]);
}
