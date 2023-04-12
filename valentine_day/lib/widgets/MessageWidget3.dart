import 'package:flutter/material.dart';
import '/utils/SizeConfig.dart';

class MessageWidget3 extends StatelessWidget {
  const MessageWidget3({
    Key? key,
    required this.headLine,
    required this.subTitle,
    required this.imagePath,
    required this.color,
  }) : super(key: key);

  final String? headLine;
  final String? subTitle;
  final String? imagePath;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: SizeConfig.width(10.0)),
      child: Container(
        width: SizeConfig.width(180),
        height: SizeConfig.height(164),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.all(Radius.circular(SizeConfig.width(5))),
          boxShadow: [
            BoxShadow(
              offset: Offset(4, 4),
              blurRadius: 3,
              color: Colors.grey.withOpacity(0.50),
            )
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(SizeConfig.width(10.0)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Item2
              imagePath != ""
                  ? Container(
                      height: SizeConfig.height(60),
                      width: SizeConfig.width(60),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                            imagePath!,
                          ),
                          fit: BoxFit.fill,
                        ),
                      ),
                    )
                  : Container(),

              // Item1 with two Text
              Container(
                width: SizeConfig.width(180),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      headLine!,
                      style: Theme.of(context).textTheme.headline6,
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      subTitle!,
                      style: Theme.of(context).textTheme.subtitle2,
                      maxLines: 3,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
