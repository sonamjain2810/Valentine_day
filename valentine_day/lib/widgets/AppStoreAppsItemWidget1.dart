import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../utils/SizeConfig.dart';

class AppStoreAppsItemWidget1 extends StatelessWidget {
  const AppStoreAppsItemWidget1({
    Key? key,
    this.imageUrl,
    this.appUrl,
    this.appTitle,
  }) : super(key: key);

  final String? imageUrl, appUrl, appTitle;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (appUrl != null && Uri.tryParse(appUrl!) != null) {
          launchUrl(Uri.parse(appUrl!));
        }
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: SizeConfig.height(4)),
        child: Row(
          mainAxisSize: MainAxisSize.max, // prevent Expanded-like behavior
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(SizeConfig.width(12)),
              child: CachedNetworkImage(
                height: SizeConfig.height(70),
                width: SizeConfig.width(70),
                imageUrl: imageUrl ?? '',
                fit: BoxFit.cover,
                placeholder: (context, url) => Center(
                  child: CircularProgressIndicator(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                errorWidget: (context, url, error) => Icon(
                  Icons.error,
                  color: Theme.of(context).colorScheme.error,
                ),
              ),
            ),
            SizedBox(width: SizeConfig.width(6)),
            SizedBox(
              width: SizeConfig.width(100), // fixed width for safe layout
              child: Text(
                appTitle ?? 'Unknown App',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
