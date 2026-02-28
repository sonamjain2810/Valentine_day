import 'package:flutter/material.dart';
import 'AboutUs.dart';
import 'App_Theme.dart';
import 'Enums/project_routes_enum.dart';
import 'GifDetailPage.dart';
import 'GifsImages.dart';
import 'HomePage.dart';
import 'ImageDetailPage.dart';
import 'ImagesList.dart';
import 'MemeGenerator.dart';
import 'MessageDetailPage.dart';
import 'MessagesList.dart';
import 'QuotesDetailPage.dart';
import 'QuotesList.dart';
import 'ShayariDetailPage.dart';
import 'ShayariList.dart';
import 'StatusDetailPage.dart';
import 'StatusList.dart';
import 'utils/SizeConfig.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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

            routes: <String, WidgetBuilder>{
        //'${ProjectRoutes.home}': (BuildContext context) => const MyHomePage(title: "Home Page"),
        '${ProjectRoutes.aboutUs}': (BuildContext context) => AboutUs(),
        '${ProjectRoutes.messagesList}': (BuildContext context) => const MessagesList(),
        '${ProjectRoutes.messagesDetailPage}': (BuildContext context) => MessageDetailPage(),
        '${ProjectRoutes.quotesList}': (BuildContext context) => QuotesList(),
        '${ProjectRoutes.quotesDetailPage}': (BuildContext context) => QuotesDetailPage(),
        '${ProjectRoutes.shayariList}': (BuildContext context) => ShayariList(),
        '${ProjectRoutes.shayariDetailPage}': (BuildContext context) => ShayariDetailPage(),
        '${ProjectRoutes.statusList}': (BuildContext context) => StatusList(),
        '${ProjectRoutes.statusDetailPage}': (BuildContext context) => const StatusDetailPage(),
        '${ProjectRoutes.imagesList}': (BuildContext context) => ImagesList(),
        '${ProjectRoutes.imagesDetailPage}': (BuildContext context) => ImageDetailPage(),
        '${ProjectRoutes.gifsList}': (BuildContext context) => GifsImages(),
        '${ProjectRoutes.gifDetailPage}': (BuildContext context) => GifDetailPage(),
        '${ProjectRoutes.memeGenerator}': (BuildContext context) => MemeGenerator(),
      },

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
