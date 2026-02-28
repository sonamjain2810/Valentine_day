import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../utils/SizeConfig.dart';

class CustomBannerWidget extends StatelessWidget {
  const CustomBannerWidget({
    Key? key,
    required this.size,
    this.imagePath,
    this.topText,
    this.middleText,
    this.bottomText,
    this.buttonText,
  }) : super(key: key);

  final Size size;
  final String? imagePath, topText, middleText, bottomText, buttonText;

  @override
  Widget build(BuildContext context) {
    final Color backgroundColor =
        Theme.of(context).colorScheme.primary.withOpacity(0.9);
    final Color buttonColor = Theme.of(context).colorScheme.inversePrimary;
    final Color textColor = Theme.of(context).colorScheme.onPrimary;

    return LayoutBuilder(
      builder: (context, constraints) {
        return InkWell(
          child: Container(
            color: backgroundColor,
            height: size.height * 0.35,
            width: constraints.maxWidth,
            child: Stack(
              children: <Widget>[
                Positioned(
                  bottom: 0,
                  top: 0,
                  left: 0,
                  child: SizedBox(
                    height: constraints.maxHeight,
                    width: constraints.maxWidth / 2.5,
                    child: CachedNetworkImage(
                      imageUrl: imagePath ?? '',
                      fit: BoxFit.cover,
                      placeholder: (context, url) =>
                          const Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                      fadeOutDuration: const Duration(seconds: 1),
                      fadeInDuration: const Duration(seconds: 3),
                    ),
                  ),
                ),
                Positioned(
                  right: 0,
                  top: 0,
                  bottom: 0,
                  child: Padding(
                    padding: EdgeInsets.all(SizeConfig.width(8)),
                    child: SizedBox(
                      width: constraints.maxWidth / 1.75,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          if (topText != null)
                            Text(
                              topText!,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: textColor,
                                  ),
                              textAlign: TextAlign.center,
                            ),
                          if (middleText != null)
                            Text(
                              middleText!,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: textColor,
                                  ),
                              textAlign: TextAlign.center,
                            ),
                          if (bottomText != null)
                            Text(
                              bottomText!,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: textColor,
                                  ),
                              textAlign: TextAlign.center,
                            ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: SizeConfig.width(18),
                              vertical: SizeConfig.height(10),
                            ),
                            decoration: BoxDecoration(
                              color: buttonColor,
                              borderRadius:
                                  BorderRadius.circular(SizeConfig.height(4)),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  buttonText ?? '',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(color: textColor),
                                ),
                                SizedBox(width: SizeConfig.width(8)),
                                Icon(
                                  Icons.arrow_forward,
                                  color:
                                      Theme.of(context).iconTheme.color ?? textColor,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
