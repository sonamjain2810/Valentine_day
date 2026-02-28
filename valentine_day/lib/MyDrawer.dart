import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'Enums/project_routes_enum.dart';
import 'Singleton/project_manager.dart';
import 'data/Strings.dart';
import 'utils/SizeConfig.dart';
import 'HomePage.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Drawer(
      child: Container(
        color: theme.colorScheme.primary,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: theme.colorScheme.secondary,
              ),
              currentAccountPicture: CircleAvatar(
                backgroundImage: const NetworkImage(
                  'https://pbs.twimg.com/profile_images/1158115409993691138/wABb5ZLe_400x400.jpg',
                ),
                backgroundColor: theme.colorScheme.onPrimary,
              ),
              accountName: Text(
                Strings.accountName,
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onPrimary,
                ),
              ),
              accountEmail: Text(
                Strings.accountEmail,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onPrimary,
                ),
              ),
            ),
            ..._buildListTiles(context),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildListTiles(BuildContext context) {
    final theme = Theme.of(context);
    final tiles = <Map<String, dynamic>>[
      {
        'icon': Icons.home,
        'text': 'Home Page',
        'onTap': () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) =>  HomePage()),
            ),
      },
      {
        'icon': Icons.format_quote,
        'text': 'Quotes',
        'onTap': () => ProjectManager.instance
            .clickOnButton(ProjectRoutes.quotesList.toString()),
      },
      {
        'icon': Icons.image,
        'text': 'Images',
        'onTap': () => ProjectManager.instance
            .clickOnButton(ProjectRoutes.imagesList.toString()),
      },
      {
        'icon': Icons.info,
        'text': 'About Developer',
        'onTap': () => ProjectManager.instance
            .clickOnButton(ProjectRoutes.aboutUs.toString()),
      },
      {
        'icon': Icons.feedback,
        'text': 'Submit Feedback',
        'onTap': () async {
          if (await canLaunchUrlString(Strings.mailContent)) {
            await launchUrlString(Strings.mailContent);
          }
        },
      },
      {
        'icon': Icons.more,
        'text': 'Other Apps',
        'onTap': () => launchUrlString(Strings.accountUrl),
      },
      {
        'icon': Icons.rate_review,
        'text': 'Rate This App',
        'onTap': () => Strings.RateNReview(),
      },
      {
        'icon': Icons.share,
        'text': 'Share App',
        'onTap': () {
          final box = context.findRenderObject() as RenderBox;
          Share.share(
            Strings.shareAppText,
            sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size,
          );
        },
      },
      {
        'icon': Icons.close,
        'text': 'Close',
        'onTap': () => Navigator.pop(context),
      },
    ];

    return tiles.map((tile) {
      return Column(
        children: [
          ListTile(
            leading: Icon(tile['icon'], color: theme.iconTheme.color),
            title: Text(
              tile['text'],
              style: theme.textTheme.titleSmall?.copyWith(
                color: theme.colorScheme.onPrimary,
              ),
            ),
            trailing: Icon(Icons.arrow_forward_ios, size: 16, color: theme.iconTheme.color),
            onTap: () {
              Navigator.pop(context);
              tile['onTap']?.call();
            },
          ),
          Divider(color: theme.dividerColor, height: 1),
        ],
      );
    }).toList();
  }
}
