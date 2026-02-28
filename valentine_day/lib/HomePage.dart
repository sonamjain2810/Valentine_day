import 'dart:async';
import 'dart:io';
import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:valentine_day/data/Messages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:valentine_day/widgets/CustomFBTextWidget.dart';
import 'package:valentine_day/widgets/CustomFeatureCard.dart';
import 'package:valentine_day/widgets/CustomFullCard.dart';
import 'package:valentine_day/widgets/MessageWidget3.dart';
import 'package:url_launcher/url_launcher.dart';
import 'AdManager/ad_helper.dart';
import 'AdManager/ad_manager.dart';
import 'Enums/project_routes_enum.dart';
import 'Singleton/project_manager.dart';
import 'data/Gifs.dart';
import 'data/Images.dart';
import 'data/Quotes.dart';
import 'data/Shayari.dart';
import 'data/Status.dart';
import 'data/Strings.dart';
import 'utils/SizeConfig.dart';
import 'MyDrawer.dart';
import 'utils/pass_data_between_screens.dart';
import 'widgets/AppStoreAppsItemWidget1.dart';
import 'widgets/AppStoreItemWidget2.dart';
import 'widgets/CustomBannerWidget.dart';
import 'widgets/MessageWidget1.dart';

// Height = 8.96
// Width = 4.14

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    implements ProjectListener, AdListener {
  String _authStatus = 'Unknown';

  BannerAd? _bannerAd;
  ProjectManager projectManager = ProjectManager.instance;
  AdManager adManager = AdManager.instance;
  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback(
      (_) => initPlugin(),
    );

    projectManager.listener = this;

    adManager.adListener = this;

    projectManager.startApp();

    adManager.loadAdsInAdManager();
  }

  BannerAd loadBannerAd() {
    return BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            _bannerAd = ad as BannerAd;
          });
        },
        onAdFailedToLoad: (ad, err) {
          debugPrint('Failed to load a banner ad: ${err.message}');
          ad.dispose();
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    debugPrint("Home Page: Dispose Called");
    projectManager.listener = null;
    adManager.adListener = null;
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlugin() async {
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      final TrackingStatus status =
          await AppTrackingTransparency.requestTrackingAuthorization();

      switch (status) {
        case TrackingStatus.authorized:
          print("Tracking Status Authorized");
          break;
        case TrackingStatus.denied:
          print("Tracking Status Denied");
          break;
        case TrackingStatus.notDetermined:
          print("Tracking Status not Determined");
          break;
        case TrackingStatus.notSupported:
          print("Tracking Status not Supported");
          break;
        case TrackingStatus.restricted:
          print("Tracking Status Restricted");
          break;
        default:
      }
    } on PlatformException {
      setState(() => _authStatus = 'PlatformException was thrown');
    }

    final uuid = await AppTrackingTransparency.getAdvertisingIdentifier();
    print("UUID: $uuid");
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Home",
          //style: Theme.of(context).appBarTheme.textTheme!.headline1,
          style: Theme.of(context).appBarTheme.toolbarTextStyle,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              DesignerContainer(
                isLeft: false,
                child: Padding(
                  padding: EdgeInsets.all(SizeConfig.width(8)),
                  child: Center(
                    child: Text(
                      "Choose Wishes From Below",
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ),
                ),
              ),
              const Divider(),
              // Wishes Start
              DesignerContainer(
                isLeft: true,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(SizeConfig.width(8)),
                      child: Center(
                        child: Text(
                          "Choose Language For Valentine Day",
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ),
                    ),
                    // Honey
                    Padding(
                      padding: EdgeInsets.all(SizeConfig.width(8)),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Padding(
                          padding: EdgeInsets.only(
                            bottom: SizeConfig.height(6.0),
                          ),
                          child: Row(
                            children: [
                              //English
                              MessageWidget3(
                                headLine: "English",
                                subTitle: Messages.englishData[2],
                                imagePath: Gifs.gifsPath[25],
                                color: Colors.orange,
                                callback: () {
                                  debugPrint("English Message Clicked");
                                  ProjectManager.instance.clickOnButton(
                                    ProjectRoutes.messagesList.toString(),
                                    PassDataBetweenScreens("1", "1"),
                                  );
                                },
                              ),

                              Column(
                                children: [
                                  MessageWidget1(
                                    headLine: "हिंदी",
                                    subTitle: Messages.hindiData[0],
                                    imagePath: Gifs.gifsPath[23],

                                    color: Colors.brown,
                                    callback: () {
                                      debugPrint("Hindi Message Clicked");
                                      ProjectManager.instance.clickOnButton(
                                        ProjectRoutes.messagesList.toString(),
                                        PassDataBetweenScreens("4", "4"),
                                      );
                                    },
                                  ),

                                  SizedBox(height: SizeConfig.height(8.0)),

                                  //Spainsh
                                  MessageWidget1(
                                    headLine: "Español",
                                    subTitle: Messages.spanishData[1],
                                    imagePath: Gifs.gifsPath[20],
                                    color: Colors.deepOrangeAccent,
                                    callback: () {
                                      debugPrint("Spanish Message Clicked");
                                      ProjectManager.instance.clickOnButton(
                                        ProjectRoutes.messagesList.toString(),
                                        PassDataBetweenScreens("7", "7"),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // rikhil

                    // Abdul
                    Padding(
                      padding: EdgeInsets.all(SizeConfig.width(8)),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Padding(
                          padding: EdgeInsets.only(
                            bottom: SizeConfig.height(6.0),
                          ),
                          child: Row(
                            children: [
                              Column(
                                children: [
                                  // German
                                  MessageWidget1(
                                    headLine: "Deutsche",
                                    subTitle: Messages.germanData[0],
                                    imagePath: Gifs.gifsPath[19],

                                    color: Colors.redAccent,
                                    callback: () {
                                      debugPrint("German Message Clicked");
                                      ProjectManager.instance.clickOnButton(
                                        ProjectRoutes.messagesList.toString(),
                                        PassDataBetweenScreens("3", "3"),
                                      );
                                    },
                                  ),

                                  SizedBox(height: SizeConfig.height(8.0)),

                                  // French
                                  MessageWidget1(
                                    headLine: "français",
                                    subTitle: Messages.frenchData[0],
                                    imagePath: Gifs.gifsPath[18],

                                    color: Colors.blueGrey,
                                    callback: () {
                                      debugPrint("French Message Clicked");
                                      ProjectManager.instance.clickOnButton(
                                        ProjectRoutes.messagesList.toString(),
                                        PassDataBetweenScreens("2", "2"),
                                      );
                                    },
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  // Italy
                                  MessageWidget1(
                                    headLine: "Italiano",
                                    subTitle: Messages.italyData[5],
                                    imagePath: Gifs.gifsPath[15],

                                    color: Colors.green.shade400,
                                    callback: () {
                                      debugPrint("Italian Message Clicked");
                                      ProjectManager.instance.clickOnButton(
                                        ProjectRoutes.messagesList.toString(),
                                        PassDataBetweenScreens("5", "5"),
                                      );
                                    },
                                  ),

                                  SizedBox(height: SizeConfig.height(8.0)),

                                  //Portugal
                                  MessageWidget1(
                                    headLine: "Português",
                                    subTitle: Messages.portugalData[3],
                                    imagePath: Gifs.gifsPath[27],

                                    color: Colors.deepPurpleAccent,
                                    callback: () {
                                      debugPrint("Portugal Message Clicked");
                                      ProjectManager.instance.clickOnButton(
                                        ProjectRoutes.messagesList.toString(),
                                        PassDataBetweenScreens("6", "6"),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    //Kalam
                  ],
                ),
              ),

              // Wishes end
              const Divider(),
              DesignerContainer(
                isLeft: false,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(SizeConfig.width(8)),
                      child: Text(
                        "👋,Games For You | 👗 🆙 | 🫣 🔍 | 🧩🤔",
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(SizeConfig.width(8)),
                      child: const SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            AppStoreItemWidget2(
                              appTitle: "",
                              imageUrl:
                                  "https://is5-ssl.mzstatic.com/image/thumb/Purple112/v4/4a/8c/62/4a8c6201-b787-d4fa-e1d0-4b585454c47c/AppIcon-0-0-1x_U007emarketing-0-0-0-7-0-0-sRGB-0-0-0-GLES2_U002c0-512MB-85-220-0-0.png/460x0w.png",
                              appUrl:
                                  "https://apps.apple.com/us/app/puzzle-games-jigsaw-puzzles/id1660034531",
                            ),
                            AppStoreItemWidget2(
                              appTitle: "",
                              imageUrl:
                                  "https://is3-ssl.mzstatic.com/image/thumb/Purple112/v4/88/77/c6/8877c63f-7403-9b49-d575-578d80075271/AppIcon-0-0-1x_U007emarketing-0-0-0-7-0-0-sRGB-0-0-0-GLES2_U002c0-512MB-85-220-0-0.png/460x0w.png",
                              appUrl:
                                  "https://apps.apple.com/us/app/christmas-game-dressup-girl-hd/id6443515715",
                            ),
                            AppStoreItemWidget2(
                              appTitle: "",
                              imageUrl:
                                  "https://is1-ssl.mzstatic.com/image/thumb/Purple112/v4/a2/4c/bf/a24cbfec-774f-8ef4-7901-95857d34e6a1/AppIcon-0-0-1x_U007emarketing-0-0-0-7-0-0-sRGB-0-0-0-GLES2_U002c0-512MB-85-220-0-0.png/460x0w.png",
                              appUrl:
                                  "https://apps.apple.com/us/app/christmas-hidden-objects-brain/id1542868606",
                            ),
                            AppStoreItemWidget2(
                              appTitle: "",
                              imageUrl:
                                  "https://is1-ssl.mzstatic.com/image/thumb/Purple122/v4/ff/3b/6e/ff3b6e42-cd15-99ef-e566-18250123f049/AppIcon-0-0-1x_U007emarketing-0-0-0-7-0-0-sRGB-0-0-0-GLES2_U002c0-512MB-85-220-0-0.png/460x0w.png",
                              appUrl:
                                  "https://apps.apple.com/us/app/christmas-decoration-makeover/id1660383621",
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                //banner
              ),
              const Divider(),
              // Wish Creator Start
              DesignerContainer(
                isLeft: false,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(SizeConfig.width(8)),
                      child: Text(
                        "Generate Valentine's Day E-Cards",
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(SizeConfig.width(8)),
                      child: InkWell(
                        child: IgnorePointer(
                          child: CustomBannerWidget(
                            size: MediaQuery.of(context).size,
                            imagePath: Gifs.gifsPath[8],
                            buttonText: "Generate Greeting",
                            topText: "Send Valentine's",
                            middleText: "Wishes & E-Cards",
                            bottomText: "Share it With Your Loved Ones",
                          ),
                        ),
                        onTap: () {
                          debugPrint("Quotes Clicked");
                          ProjectManager.instance.clickOnButton(
                            ProjectRoutes.memeGenerator.toString(),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),

              // Wish Creator End
              const Divider(),

              // Quotes Start
              DesignerContainer(
                isLeft: true,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(SizeConfig.width(8)),
                      child: Text(
                        "Valentine's Day Quotes",
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(SizeConfig.width(8)),
                      child: InkWell(
                        child: Container(
                          width: size.width - SizeConfig.width(16),
                          height: size.width / 2,
                          decoration: BoxDecoration(
                            color:
                                MediaQuery.of(context).platformBrightness ==
                                    Brightness.dark
                                ? Theme.of(context).primaryColorDark
                                : Colors.yellow[900],
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(
                                SizeConfig.height(20),
                              ),
                              topRight: Radius.circular(SizeConfig.height(20)),
                            ),
                            boxShadow: const [
                              BoxShadow(
                                offset: Offset(0, 0),
                                blurRadius: 4,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                          child: Stack(
                            children: [
                              Icon(
                                Icons.format_quote,
                                color: Theme.of(context).primaryIconTheme.color,
                              ),
                              Positioned(
                                top: 20,
                                width: size.width - SizeConfig.width(16),
                                child: Center(
                                  child: Padding(
                                    padding: EdgeInsets.all(
                                      SizeConfig.width(8),
                                    ),
                                    child: Text(
                                      Quotes.quotesData[7],
                                      style: Theme.of(
                                        context,
                                      ).textTheme.bodyMedium,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 0,
                                bottom: 0,
                                right: 0,
                                child: Center(
                                  child: Padding(
                                    padding: EdgeInsets.all(
                                      SizeConfig.width(8),
                                    ),
                                    child: Text(
                                      "Tap Here to Continue",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                            color: Colors.purpleAccent[700]!,
                                          ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        onTap: () {
                          debugPrint("Quotes Clicked");
                          ProjectManager.instance.clickOnButton(
                            ProjectRoutes.quotesList.toString(),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),

              // Quotes End
              const Divider(),

              //Gifs Start
              DesignerContainer(
                isLeft: true,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(SizeConfig.width(8)),
                      child: Text(
                        "Valentine's Day Gifs",
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(SizeConfig.width(8)),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            CustomFeatureCard(
                              size: size,
                              imageUrl: Gifs.gifsPath[5],
                              onTap: () {
                                debugPrint("Gifs Clicked");
                                ProjectManager.instance.clickOnButton(
                                  ProjectRoutes.gifsList.toString(),
                                );
                              },
                            ),
                            CustomFeatureCard(
                              size: size,
                              imageUrl: Gifs.gifsPath[3],
                              onTap: () {
                                debugPrint("Gifs Clicked");
                                ProjectManager.instance.clickOnButton(
                                  ProjectRoutes.gifsList.toString(),
                                );
                              },
                            ),
                            CustomFeatureCard(
                              size: size,
                              imageUrl: Gifs.gifsPath[21],
                              onTap: () {
                                debugPrint("Gifs Clicked");
                                ProjectManager.instance.clickOnButton(
                                  ProjectRoutes.gifsList.toString(),
                                );
                              },
                            ),
                            CustomFeatureCard(
                              size: size,
                              imageUrl: Gifs.gifsPath[22],
                              onTap: () {
                                debugPrint("Gifs Clicked");
                                ProjectManager.instance.clickOnButton(
                                  ProjectRoutes.gifsList.toString(),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Gifs End
              const Divider(),

              // Shayari start
              DesignerContainer(
                isLeft: false,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(SizeConfig.width(8)),
                      child: Text(
                        "Valentine's Day Shayari",
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(SizeConfig.width(8)),
                      child: InkWell(
                        child: Container(
                          width: size.width - SizeConfig.width(16),
                          height: size.width / 2,
                          decoration: BoxDecoration(
                            color:
                                MediaQuery.of(context).platformBrightness ==
                                    Brightness.dark
                                ? Theme.of(context).primaryColorDark
                                : Colors.pink[900],
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(
                                SizeConfig.height(20),
                              ),
                              topRight: Radius.circular(SizeConfig.height(20)),
                            ),
                            boxShadow: const [
                              BoxShadow(
                                offset: Offset(0, 0),
                                blurRadius: 4,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                          child: Stack(
                            children: [
                              Icon(
                                Icons.format_quote,
                                color: Theme.of(context).primaryIconTheme.color,
                              ),
                              Positioned(
                                top: 20,
                                width: size.width - SizeConfig.width(16),
                                child: Center(
                                  child: Padding(
                                    padding: EdgeInsets.all(
                                      SizeConfig.width(8),
                                    ),
                                    child: Text(
                                      Shayari.shayariData[7],
                                      style: Theme.of(
                                        context,
                                      ).textTheme.bodyMedium,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 0,
                                bottom: 0,
                                right: 0,
                                child: Center(
                                  child: Padding(
                                    padding: EdgeInsets.all(
                                      SizeConfig.width(8),
                                    ),
                                    child: Text(
                                      "Tap Here to Continue",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(color: Colors.yellow[700]!),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        onTap: () {
                          debugPrint("Quotes Clicked");
                          ProjectManager.instance.clickOnButton(
                            ProjectRoutes.shayariList.toString(),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),

              // Shayari end
              const Divider(),
              /*DesignerContainer(
                isLeft: false,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(SizeConfig.width(8)),
                      child: Text(
                        "✋ Need Your HELP? 😊",
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(SizeConfig.width(8)),
                      child: Text(
                        "Your suggestions are very important to improve your experience in next APP Update. Let me know how our team can improve. Thanks! and click the BUTTON Below 👇🏻 to RATE this app.",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Strings.RateNReview();
                      },
                      child: const Text("⬇️ Rate & Review ⬇️"),
                    ),
                  ],
                ),
              ),
  */
              const Divider(),

              //Image Start
              DesignerContainer(
                isLeft: false,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(SizeConfig.width(8)),
                      child: Text(
                        "Valentine's Wishes Images",
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(SizeConfig.width(8)),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: InkWell(
                          child: IgnorePointer(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                CustomFeatureCard(
                                  size: size,
                                  imageUrl: Images.imagesPath[7],
                                  onTap: null,
                                ),
                                CustomFeatureCard(
                                  size: size,
                                  imageUrl: Images.imagesPath[9],
                                  onTap: null,
                                ),
                                CustomFeatureCard(
                                  size: size,
                                  imageUrl: Images.imagesPath[13],
                                  onTap: null,
                                ),
                                CustomFeatureCard(
                                  size: size,
                                  imageUrl: Images.imagesPath[12],
                                  onTap: null,
                                ),
                              ],
                            ),
                          ),
                          onTap: () {
                            debugPrint("Images Clicked");
                            ProjectManager.instance.clickOnButton(
                              ProjectRoutes.imagesList.toString(),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Image End
              const Divider(),

              // Status Start
              DesignerContainer(
                isLeft: true,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(SizeConfig.width(8)),
                      child: Text(
                        "Valentine's Day FB Whatsapp Status ",
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(SizeConfig.width(8)),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,

                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            CustomFBTextWidget(
                              size: size,
                              text: Status.statusData[2],
                              color: Colors.orange.shade900,
                              url: Gifs.gifsPath[35],

                              isLeft: false,
                              ontap: () {
                                ProjectManager.instance.clickOnButton(
                                  ProjectRoutes.statusList.toString(),
                                );
                              },
                            ),
                            SizedBox(width: SizeConfig.width(8)),
                            CustomFBTextWidget(
                              size: size,
                              text: Status.statusData[3],
                              color: Colors.blue,
                              url: Gifs.gifsPath[35],
                              isLeft: false,
                              ontap: () {
                                ProjectManager.instance.clickOnButton(
                                  ProjectRoutes.statusList.toString(),
                                );
                              },
                            ),
                            SizedBox(width: SizeConfig.width(8)),
                            CustomFBTextWidget(
                              size: size,
                              text: Status.statusData[4],
                              color: Colors.indigoAccent,
                              url: Gifs.gifsPath[35],
                              isLeft: false,
                              ontap: () {
                                ProjectManager.instance.clickOnButton(
                                  ProjectRoutes.statusList.toString(),
                                );
                              },
                            ),
                            SizedBox(width: SizeConfig.width(8)),
                            CustomFBTextWidget(
                              size: size,
                              text: Status.statusData[1],
                              color: Colors.purple,
                              url: Gifs.gifsPath[35],
                              isLeft: false,
                              ontap: () {
                                ProjectManager.instance.clickOnButton(
                                  ProjectRoutes.statusList.toString(),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              //Status End
              const Divider(),

              Padding(
                padding: EdgeInsets.all(SizeConfig.width(8)),
                child: Text(
                  "Play Game \"Sell Rakhi\"",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),

              CustomFullCard(
                size: MediaQuery.of(context).size,
                imageUrl: "lib/assets/rakhi_game.jpeg",
                onTap: () {
                  if (Platform.isAndroid) {
                    // Android-specific code
                    print("More Button Clicked");
                    launch(
                      "https://play.google.com/store/apps/developer?id=Festival+Messages+SMS",
                    );
                  } else if (Platform.isIOS) {
                    // iOS-specific code
                    print("More Button Clicked");
                    launch("https://apps.apple.com/us/app/-/id1434054710");
                  }
                },
              ),

              const Divider(),

              Padding(
                padding: EdgeInsets.all(SizeConfig.width(8)),
                child: Text(
                  "Apps From Developer",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),

              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: EdgeInsets.all(SizeConfig.width(8)),
                  child: Row(
                    children: <Widget>[
                      //Column1
                      const Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          AppStoreAppsItemWidget1(
                            imageUrl:
                                "https://is1-ssl.mzstatic.com/image/thumb/Purple117/v4/8f/e7/b5/8fe7b5bc-03eb-808c-2b9e-fc2c12112a45/mzl.jivuavtz.png/292x0w.jpg",
                            appTitle: "Good Morning Images & Messages",
                            appUrl:
                                "https://apps.apple.com/us/app/good-morning-images-messages-to-wish-greet-gm/id1232993917",
                          ),
                          Divider(),
                          AppStoreAppsItemWidget1(
                            imageUrl:
                                "https://is4-ssl.mzstatic.com/image/thumb/Purple114/v4/44/e0/fd/44e0fdb5-667b-5468-7b2f-53638cba539e/AppIcon-1x_U007emarketing-0-7-0-0-85-220.png/292x0w.jpg",
                            appTitle: "Birthday Status Wishes Quotes",
                            appUrl:
                                "https://apps.apple.com/us/app/birthday-status-wishes-quotes/id1522542709",
                          ),
                          Divider(),
                          AppStoreAppsItemWidget1(
                            imageUrl:
                                "https://is4-ssl.mzstatic.com/image/thumb/Purple114/v4/1a/58/a4/1a58a480-a0ae-1940-2cf3-38524430f66b/AppIcon-0-1x_U007emarketing-0-0-GLES2_U002c0-512MB-sRGB-0-0-0-85-220-0-0-0-7.png/292x0w.jpg",
                            appTitle: "Astrology Horoscope Lal Kitab",
                            appUrl:
                                "https://apps.apple.com/us/app/astrology-horoscope-lal-kitab/id1448343526",
                          ),
                        ],
                      ),
                      SizedBox(width: SizeConfig.width(3)),
                      //Column2
                      const Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          AppStoreAppsItemWidget1(
                            imageUrl:
                                "https://is2-ssl.mzstatic.com/image/thumb/Purple124/v4/e9/96/64/e99664d3-1083-5fac-6a0c-61718ee209fd/AppIcon-0-1x_U007emarketing-0-0-GLES2_U002c0-512MB-sRGB-0-0-0-85-220-0-0-0-7.png/292x0w.jpg",
                            appTitle: "Weight Loss My Diet Coach Tips",
                            appUrl:
                                "https://apps.apple.com/us/app/weight-loss-my-diet-coach-tips/id1448343218",
                          ),
                          Divider(),
                          AppStoreAppsItemWidget1(
                            imageUrl:
                                "https://is2-ssl.mzstatic.com/image/thumb/Purple127/v4/5f/7c/45/5f7c45c7-fb75-ea39-feaa-a698b0e4b09e/pr_source.jpg/292x0w.jpg",
                            appTitle: "English Speaking Course Grammar",
                            appUrl:
                                "https://apps.apple.com/us/app/english-speaking-course-learn-grammar-vocabulary/id1233093288",
                          ),
                          Divider(),
                          AppStoreAppsItemWidget1(
                            imageUrl:
                                "https://is4-ssl.mzstatic.com/image/thumb/Purple128/v4/50/ad/82/50ad82d9-0d82-5007-fcdd-cc47c439bfd0/AppIcon-0-1x_U007emarketing-0-85-220-10.png/292x0w.jpg",
                            appTitle: "English Hindi Language Diction",
                            appUrl:
                                "https://apps.apple.com/us/app/english-hindi-language-diction/id1441243874",
                          ),
                        ],
                      ),
                      SizedBox(width: SizeConfig.width(3)),

                      //Column3
                      const Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          /*AppStoreAppsItemWidget1(
                                  imageUrl:
                                      "https://is3-ssl.mzstatic.com/image/thumb/Purple118/v4/17/f5/0c/17f50c4d-431b-72c6-b9f4-d1706da59394/AppIcon-0-1x_U007emarketing-0-0-85-220-7.png/292x0w.jpg",
                                  appTitle: "Celebrate Happy New Year 2019",
                                  appUrl:
                                      "https://apps.apple.com/us/app/celebrate-happy-new-year-2019/id1447735210"),
                              Divider(),*/
                          AppStoreAppsItemWidget1(
                            imageUrl:
                                "https://is1-ssl.mzstatic.com/image/thumb/Purple118/v4/79/1e/61/791e61de-500c-6c97-3947-8abbc6b887e3/AppIcon-0-1x_U007emarketing-0-0-GLES2_U002c0-512MB-sRGB-0-0-0-85-220-0-0-0-7.png/292x0w.jpg",
                            appTitle: "Bangladesh Passport Visa Biman",
                            appUrl:
                                "https://apps.apple.com/us/app/bangladesh-passport-visa-biman/id1443074171",
                          ),
                          Divider(),
                          AppStoreAppsItemWidget1(
                            imageUrl:
                                "https://is1-ssl.mzstatic.com/image/thumb/Purple126/v4/dd/34/c3/dd34c3e8-5c9f-51aa-a3eb-3a203f5fd49b/AppIcon-0-1x_U007emarketing-0-0-GLES2_U002c0-512MB-sRGB-0-0-0-85-220-0-0-0-10.png/292x0w.jpg",
                            appTitle: "Complete Spoken English Course",
                            appUrl:
                                "https://apps.apple.com/us/app/complete-spoken-english-course/id1440118617",
                          ),
                        ],
                      ),
                      SizedBox(width: SizeConfig.width(3)),

                      //Column4
                      const Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          AppStoreAppsItemWidget1(
                            imageUrl:
                                "https://is4-ssl.mzstatic.com/image/thumb/Purple128/v4/bd/00/ee/bd00ee3b-43af-6b07-62a6-28c68373a8b5/AppIcon-1x_U007emarketing-85-220-0-9.png/292x0w.jpg",
                            appTitle: "Happy Thanksgiving Day Greeting SMS",
                            appUrl:
                                "https://apps.apple.com/us/app/happy-merry_christmas-greeting-sms/id1435157874",
                          ),
                          Divider(),
                          /*AppStoreAppsItemWidget1(
                                  imageUrl:
                                      "https://is4-ssl.mzstatic.com/image/thumb/Purple91/v4/f0/84/d7/f084d764-79a8-f6d1-3778-1cb27fabb8bd/pr_source.png/292x0w.jpg",
                                  appTitle: "Egg Recipes 100+ Recipes",
                                  appUrl:
                                      "https://apps.apple.com/us/app/egg-recipes-100-recipes-collection-for-eggetarian/id1232736881"),
                              Divider(),*/
                          AppStoreAppsItemWidget1(
                            imageUrl:
                                "https://is1-ssl.mzstatic.com/image/thumb/Purple114/v4/0f/d6/f4/0fd6f410-9664-94a5-123f-38d787bf28c6/AppIcon-1x_U007emarketing-0-7-0-0-85-220.png/292x0w.jpg",
                            appTitle: "Rakshabandhan Images Greetings",
                            appUrl:
                                "https://apps.apple.com/us/app/rakshabandhan-images-greetings/id1523619788",
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      drawer: MyDrawer(),
    );
  }

  @override
  void moveToScreen(String s, [PassDataBetweenScreens? object]) {
    // TODO: implement moveToScreen
    debugPrint("Home Page: Move to Screen $s");
    Navigator.of(context).pushNamed(s, arguments: object);
  }

  @override
  void moveToScreenAfterAd(String s, [PassDataBetweenScreens? object]) {
    // TODO: implement moveToScreenAfterAd
    debugPrint("Home Page: Move to Screen After Ad $s");
    Navigator.of(context).pushNamed(s, arguments: object);
  }

  @override
  void showAd(String s, [PassDataBetweenScreens? object]) {
    // TODO: implement showAd
    debugPrint("Home Page: Showing Ad Now");
    AdManager.instance.showInterstitialAd(s, object);
  }
}

class DesignerContainer extends StatelessWidget {
  const DesignerContainer({Key? key, required this.child, required this.isLeft})
    : super(key: key);

  final Widget child;
  final bool isLeft;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: isLeft
          ? BoxDecoration(
              color: Colors.yellow[700],
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(SizeConfig.height(20)),
              ),
              boxShadow: const [
                BoxShadow(
                  offset: Offset(0, 0),
                  blurRadius: 4,
                  color: Colors.grey,
                ),
              ],
            )
          : BoxDecoration(
              color: Colors.pink[400],
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(SizeConfig.height(20)),
              ),
              boxShadow: const [
                BoxShadow(
                  offset: Offset(0, 0),
                  blurRadius: 4,
                  color: Colors.grey,
                ),
              ],
            ),
      child: child,
    );
  }
}
