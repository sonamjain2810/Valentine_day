import 'package:flutter/material.dart';
import 'package:valentine_day/utils/SizeConfig.dart';

class CustomSubHeadingWidget extends StatelessWidget {
  const CustomSubHeadingWidget({
    Key key, this.title,
  }) : super(key: key);

  final String title;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: SizeConfig.height(8), bottom: SizeConfig.height(8)),
      child: Container(
        child: Row(children: [
          Text(
            "---",
            style: Theme.of(context).textTheme.subtitle2.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .subtitle1
                .copyWith(fontWeight: FontWeight.w700),
          ),
        ]),
      ),
    );
  }
}