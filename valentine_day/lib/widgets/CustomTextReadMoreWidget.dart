import 'package:flutter/material.dart';
import '../utils/SizeConfig.dart';

class CustomTextReadMoreWidget extends StatelessWidget {
  const CustomTextReadMoreWidget({
    Key? key,
    required this.size,
    required this.text,
    required this.color,
    this.darkButtonText,
  }) : super(key: key);

  final Size size;
  final String? text, darkButtonText;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * 0.31,
      width: size.width * 0.31,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(SizeConfig.height(10)),
      ),
      child: Container(
        height: size.height * 0.30,
        width: size.width * 0.30,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: MediaQuery.of(context).platformBrightness == Brightness.dark
              ? Theme.of(context).primaryColorDark
              : color,
          borderRadius: BorderRadius.circular(SizeConfig.height(10)),
        ),
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Padding(
                padding: EdgeInsets.all(SizeConfig.width(1)),
                child: Text(
                  text!,
                  style: MediaQuery.of(context).platformBrightness ==
                          Brightness.dark
                      ? Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: Colors.black)
                      : Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                height: size.height * 0.10,
                width: size.width * 0.30,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(SizeConfig.height(10)),
                    bottomRight: Radius.circular(SizeConfig.height(10)),
                  ),
                ),
                child: Text(
                  darkButtonText!,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Colors.white),
                  textAlign: TextAlign.right,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
