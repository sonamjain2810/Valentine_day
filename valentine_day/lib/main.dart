import 'package:flutter/material.dart';
import 'package:facebook_app_events/facebook_app_events.dart';

import 'App_Theme.dart';
import 'HomePage.dart';
import 'utils/SizeConfig.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static final facebookAppEvents = FacebookAppEvents();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
      return OrientationBuilder(
        builder: (context, orientation) {
          SizeConfig().init(constraints, orientation);
          return MaterialApp(
            title: 'App Name', // Replace your app name here
            /*theme: ThemeData(
              primarySwatch: Colors.blue,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),*/
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme ,
            debugShowCheckedModeBanner: false,
            home: HomePage(),
          );
        },
      );
    });
  }
}
