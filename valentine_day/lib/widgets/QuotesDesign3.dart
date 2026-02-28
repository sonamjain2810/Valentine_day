import '/utils/SizeConfig.dart';
import 'package:flutter/material.dart';

class QuotesDesign3 extends StatelessWidget {
  const QuotesDesign3({
    Key? key,
    required this.size,
    required this.color,
    required this.bodyText,
    required this.footerText,
    required this.curvedBorder,
    required this.ontap,
    required this.borderColor,
  }) : super(key: key);

  final Size size;
  final Color color;
  final Color borderColor;
  final String bodyText, footerText;
  final Function ontap;
  final bool curvedBorder;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        width: size.width - SizeConfig.width(16),
        height: size.width * 0.55,
        decoration: BoxDecoration(
          color: color,
          borderRadius: curvedBorder == true
              ? BorderRadius.all(
                  Radius.circular(SizeConfig.height(20)),
                )
              : BorderRadius.all(
                  Radius.circular(SizeConfig.height(0)),
                ),
          boxShadow: [
            BoxShadow(offset: Offset(0, 0), blurRadius: 4, color: Colors.grey),
          ],
        ),
        child: Stack(
          children: [
            Positioned(
              left: SizeConfig.width(11),
              right: SizeConfig.width(11),
              bottom: SizeConfig.height(11),
              top: SizeConfig.height(11),
              child: Padding(
                padding: EdgeInsets.all(SizeConfig.width(13)),
                child: Center(
                  child: Column(
                    children: [
                      Text(
                        bodyText,
                        style: Theme.of(context).textTheme.bodyMedium,
                        textAlign: TextAlign.center,
                        maxLines: 5,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Spacer(),
                      Text(
                        footerText,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Theme.of(context).primaryIconTheme.color,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              left: 15,
              top: 15,
              child: Center(
                child: Icon(Icons.format_quote,
                    color: Theme.of(context).primaryIconTheme.color),
              ),
            ),
            Positioned(
              bottom: 15,
              right: 15,
              child: Center(
                child: Icon(Icons.format_quote,
                    color: Theme.of(context).primaryIconTheme.color),
              ),
            ),
          ],
        ),
      ),
      onTap: ontap(),
    );
  }
}
