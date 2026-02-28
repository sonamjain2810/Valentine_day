import 'package:flutter/material.dart';
import '../utils/SizeConfig.dart';

class CustomFBTextWidget extends StatelessWidget {
  const CustomFBTextWidget({
    Key? key,
    required this.size,
    this.color,
    this.text,
    this.url,
    this.isLeft,
    required this.ontap,
  }) : super(key: key);

  final Size size;
  final Color? color;
  final String? text, url;
  final bool? isLeft;
  final VoidCallback ontap; // ✅ safer

  @override
  Widget build(BuildContext context) {
    final Color bgColor =
        color ?? Theme.of(context).colorScheme.secondaryContainer;
    final Color avatarOuter = Theme.of(context).colorScheme.primary;
    final Color avatarInner = Theme.of(context).colorScheme.onPrimary;

    return InkWell(
      onTap: ontap, // ✅ FIXED LINE
      child: Container(
        height: size.height * 0.27,
        width: size.width * 0.27,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(SizeConfig.height(10)),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).shadowColor.withOpacity(0.2),
              blurRadius: 6,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              child: Center(
                child: Text(
                  text ?? '',
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Positioned(
              top: 5,
              left: isLeft == true ? 5 : null,
              right: isLeft != true ? 5 : null,
              child: CircleAvatar(
                radius: 5 * SizeConfig.widthMultiplier,
                backgroundColor: avatarOuter,
                child: CircleAvatar(
                  radius: 4 * SizeConfig.widthMultiplier,
                  backgroundImage:
                      url != null ? NetworkImage(url!) : null,
                  backgroundColor: avatarInner,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
