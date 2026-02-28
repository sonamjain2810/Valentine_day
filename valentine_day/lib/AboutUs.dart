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

  var aboutUsString =
      "Hello, My name is Rikhil Jain and I'm the man behind this app.\n\tIf you have any suggestions or feedback feel free to message me. I will reply to everyone. Do drop me a hello.\nIt really means a lot to me.\nLooking forward to hear from you.";
  var fbPageURL = "https://www.facebook.com/gj1studio/";
  var twitterURL = "https://twitter.com/GJOneStudio";
  var instagramURL = "https://www.instagram.com/gjonestudio/";
  var youtubeURL = "https://www.youtube.com/GJOneStudioLanguageTutors/";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "About Developer",
          style: Theme.of(context).appBarTheme.toolbarTextStyle,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(1.93 * SizeConfig.widthMultiplier),
            child: Column(
              children: <Widget>[
                Center(
                  child: CircleAvatar(
                    radius: 19 * SizeConfig.widthMultiplier,
                    backgroundImage: const NetworkImage(
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcROE68eqV_QJUN9Nm9465OU0K8Zu245K7JktX5OJUTCioQb1B8R&s'),
                    backgroundColor: Colors.grey,
                  ),
                ),
                //10
                SizedBox(height: 1.12 * SizeConfig.heightMultiplier),
                Card(
                  child: Padding(
                    padding: EdgeInsets.all(1.93 * SizeConfig.widthMultiplier),
                    child: Text(
                      aboutUsString,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ),
                SizedBox(height: 1.12 * SizeConfig.heightMultiplier),
                Column(
                  children: <Widget>[
                    ListTile(
                      leading:  Icon(MdiIcons.youtube, color: Colors.red),
                      title: Text(
                        "Search on YouTube",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      subtitle: Text(
                        "Channel Name \"GJOneStudio Language Tutors\"",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      trailing: Icon(Icons.search,
                          color: Theme.of(context).primaryIconTheme.color),
                      onTap: () {
                        launchUrl(Uri.parse(youtubeURL));

                        
                      },
                    ),
                    const Divider(),
                    ListTile(
                      leading:
                           Icon(MdiIcons.instagram, color: Colors.indigo),
                      title: Text(
                        "Message Me on Instagram",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      subtitle: Text(
                        "Get New !deas & Online Business Opportunity for Free.",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      trailing: Icon(MdiIcons.openInApp,
                          color: Theme.of(context).primaryIconTheme.color),
                      onTap: () {
                        launchUrl(Uri.parse(instagramURL));

                        
                      },
                    ),
                    const Divider(),
                    ListTile(
                      leading:
                           Icon(MdiIcons.facebook, color: Colors.blue),
                      title: Text(
                        "Like Me on Facebook",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      subtitle: Text(
                        "Like Our Page & Stay Updated with Our New App Releases",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      trailing: Icon(MdiIcons.thumbUp,
                          color: Theme.of(context).primaryIconTheme.color),
                      onTap: () {
                        launchUrl(Uri.parse(fbPageURL));

                        
                      },
                    ),
                    const Divider(),
                    ListTile(
                        leading:
                             Icon(MdiIcons.twitter, color: Colors.cyan),
                        title: Text(
                          "Follow Me on Twitter",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        subtitle: Text(
                          "Get Tips About Online Business.",
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        trailing: Icon(Icons.trending_up,
                            color: Theme.of(context).primaryIconTheme.color),
                        onTap: () {
                          launchUrl(Uri.parse(twitterURL));

                          
                        }),
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
