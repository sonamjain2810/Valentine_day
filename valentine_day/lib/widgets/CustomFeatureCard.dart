import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '/utils/SizeConfig.dart';

class CustomFeatureCard extends StatelessWidget {
  const CustomFeatureCard({
    Key? key,
    required this.size,
    this.imageUrl,
    this.ontap,
  }) : super(key: key);

  final Size size;
  final String? imageUrl;
  final Function? ontap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        margin: EdgeInsets.only(
            left: 3.86 * SizeConfig.widthMultiplier,
            top: 3.86 * SizeConfig.widthMultiplier / 2,
            bottom: 3.86 * SizeConfig.widthMultiplier / 2),
        width: size.width * 0.8,
        height: 40 * SizeConfig.heightMultiplier,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          /*image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(imageUrl),
            )*/
        ),
        child: CachedNetworkImage(
          imageUrl: imageUrl!,
          placeholder: (context, url) => const CircularProgressIndicator(),
          errorWidget: (context, url, error) => const Icon(Icons.error),
          fadeOutDuration: const Duration(seconds: 1),
          fadeInDuration: const Duration(seconds: 3),
        ),
      ),
      onTap: () => ontap,
    );
  }
}
