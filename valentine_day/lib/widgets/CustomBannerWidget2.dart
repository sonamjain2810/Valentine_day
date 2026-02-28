// Ganesh Chaturathi Make Meme or Greetings Design

import 'package:cached_network_image/cached_network_image.dart';
import '/utils/SizeConfig.dart';
import 'package:flutter/material.dart';

class CustomBannerWidget2 extends StatelessWidget {
  const CustomBannerWidget2({
    Key? key,
    required this.size,
    required this.imagePath,
    required this.topText,
    required this.middleText,
    required this.bottomText,
    required this.buttonText,
    required this.ontap,
  }) : super(key: key);

  final Size size;
  final String imagePath, topText, middleText, bottomText, buttonText;
  final Function ontap;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return InkWell(
          onTap: ontap(),
          child: Container(
            color: Theme.of(context).colorScheme.primary,
            height: size.height * 0.35,
            width: constraints.maxWidth,
            child: Stack(
              children: <Widget>[
                Positioned(
                  bottom: 0,
                  top: 0,
                  left: 0,
                  child: Container(
                    height: constraints.maxHeight * 1,
                    width: constraints.maxWidth / 2.5,
                    child: CachedNetworkImage(
                      imageUrl: imagePath,
                      fit: BoxFit.fill,
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
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
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: constraints.maxWidth / 1.75,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text(topText,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                textAlign: TextAlign.center),
                            Text(
                              middleText,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                            Text(bottomText,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                textAlign: TextAlign.center),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: SizeConfig.width(18),
                                  vertical: SizeConfig.height(10)),
                              color: Colors.black,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Text(
                                    buttonText,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(color: Colors.white),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: SizeConfig.width(18)),
                                    child: Icon(
                                      Icons.arrow_forward,
                                      color: Theme.of(context)
                                          .primaryIconTheme
                                          .color,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ))
              ],
            ),
          ),
        );
      },
    );
  }
}
