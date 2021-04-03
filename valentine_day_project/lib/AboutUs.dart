import 'package:facebook_app_events/facebook_app_events.dart';
import "package:flutter/material.dart";
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import 'utils/SizeConfig.dart';

// Ye video dekh ke mene flutter custom icons and svg icons rakhna sikha 
// https://www.youtube.com/watch?v=qZYqmM3daO0
class AboutUs extends StatefulWidget {
  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  static final facebookAppEvents = FacebookAppEvents();

  var aboutUsString =
      "Hello, My name is Rikhil Jain and I'm the man behind this app.\n\tIf you have any suggestions or feedback feel free to message me. I will reply to everyone. Do drop me a hello.\nIt really means a lot to me.\nLooking forward to hear from you.";
  var fbPageURL="https://www.facebook.com/gj1studio/";
  var twitterURL="https://twitter.com/GJOneStudio";
  var instagramURL="https://www.instagram.com/gjonestudio/";
  var youtubeURL="https://www.youtube.com/GJOneStudioLanguageTutors/";
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("About Developer",
          style: Theme.of(context).appBarTheme.textTheme.headline1,),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(1.93 * SizeConfig.widthMultiplier),
              child: Column(
                children: <Widget>[
                  Center(
                    child: CircleAvatar(
                      radius: 19*SizeConfig.widthMultiplier,
                      backgroundImage: NetworkImage(
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcROE68eqV_QJUN9Nm9465OU0K8Zu245K7JktX5OJUTCioQb1B8R&s'),
                      backgroundColor: Colors.grey,
                      
                    ),
                  ),
                  //10
                  SizedBox(height: 1.12*SizeConfig.heightMultiplier),
                  Card(
                    child: Padding(
                      padding: EdgeInsets.all(1.93 * SizeConfig.widthMultiplier),
                      child: Text(
                        aboutUsString,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                  ),
                  SizedBox(height: 1.12*SizeConfig.heightMultiplier),
                  Column(
                    children: <Widget>[
                      ListTile(
                        leading: Icon(
                          MdiIcons.youtube,
                          color: Theme.of(context).iconTheme.color
                        ),
                        title: Text(
                          "Search on YouTube",
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        subtitle: Text("Channel Name \"GJOneStudio Language Tutors\"",
                        style: Theme.of(context).textTheme.subtitle1,
                        ),
                        trailing: Icon(
                          Icons.search,
                          color: Theme.of(context).primaryIconTheme.color
                        ),
                        onTap:(){
                          launch(youtubeURL);
                        
                        facebookAppEvents.logEvent(
                        name: "YouTube URL",
                        parameters: {
                          'clicked_on_youtube_url': 'Yes',
                        },
                      );
                        },
                      ),
                      Divider(),
                      ListTile(
                        leading: Icon(
                          MdiIcons.instagram,
                          color: Theme.of(context).iconTheme.color
                        ),
                        title: Text(
                          "Message Me on Instagram",
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        subtitle: Text("Get New !deas & Online Business Opportunity for Free.",
                        style: Theme.of(context).textTheme.subtitle1,
                        ),
                        trailing: Icon(
                          MdiIcons.openInApp,
                          color: Theme.of(context).primaryIconTheme.color
                        ),
                        onTap:(){
                          launch(instagramURL);

                        facebookAppEvents.logEvent(
                        name: "Instagram URL",
                        parameters: {
                          'clicked_on_instagram_url': 'Yes',
                        },
                      );
                        },
                      ),
                      Divider(),
                      ListTile(
                        leading: Icon(
                          MdiIcons.facebook,
                          color: Theme.of(context).iconTheme.color
                        ),
                        title: Text(
                          "Like Me on Facebook",
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        subtitle: Text("Like Our Page & Stay Updated with Our New App Releases",
                        style: Theme.of(context).textTheme.subtitle1,
                        ),
                        trailing: Icon(
                          MdiIcons.thumbUp,
                          color: Theme.of(context).primaryIconTheme.color
                        ),
                        onTap: (){
                          launch(fbPageURL); 

                          facebookAppEvents.logEvent(
                        name: "Facebook Page URL",
                        parameters: {
                          'clicked_on_facebook_page_url': 'Yes',
                        },
                      );
                        },
                      ),
                      Divider(),
                      ListTile(
                        leading: Icon(
                          MdiIcons.twitter,
                          color: Theme.of(context).iconTheme.color
                        ),
                        title: Text(
                          "Follow Me on Twitter",
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        subtitle: Text("Get Tips About Online Business.",
                        style: Theme.of(context).textTheme.subtitle1,
                        ),
                        trailing: Icon(
                          Icons.trending_up,
                          color: Theme.of(context).primaryIconTheme.color
                        ),
                        onTap: ()
                        {
                          launch(twitterURL);
                        
                        facebookAppEvents.logEvent(
                        name: "Twitter URL",
                        parameters: {
                          'clicked_on_twitter_url': 'Yes',
                        },
                      );
                        }
                      ),
                      // Divider(),
                      // ListTile(
                      //   leading: Icon(
                      //     Icons.mail,
                      //     color: Theme.of(context).iconTheme.color
                      //   ),
                      //   title: Text(
                      //     "Email Us",
                      //     style: Theme.of(context).textTheme.bodyText1,
                      //   ),
                      //   subtitle: Text("Lets discuss about your business app.",
                      // style: Theme.of(context).textTheme.subtitle1,
                      //   ),
                      //   trailing: Icon(
                      //     Icons.send,
                      //     color: Theme.of(context).primaryIconTheme.color
                      //   ),
                      // ),
                      // Divider(),
                      // ListTile(
                      //   leading: Icon(
                      //     Icons.card_travel,
                      //     color: Theme.of(context).iconTheme.color
                      //   ),
                      //   title: Text(
                      //     "Be the part of my journey",
                      //     style: Theme.of(context).textTheme.bodyText1,
                      //   ),
                      //   subtitle: Text(
                      //   "Lets discuss about your business app.",
                      //   style: Theme.of(context).textTheme.subtitle1,
                      //   ),
                      //   trailing: Icon(
                      //     Icons.send,
                      //     color: Theme.of(context).primaryIconTheme.color
                      //   ),
                      // ),
                      ],
                  ),
                ],
              ),
            ),
          ),
        ),
       );
  }
}
