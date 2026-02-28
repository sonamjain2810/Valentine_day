import '/utils/SizeConfig.dart';
import 'package:flutter/material.dart';

class ImageTextHorizontalWidget2 extends StatelessWidget {
  const ImageTextHorizontalWidget2({
    Key? key,
    required this.context,
    required this.imageUrl,
    required this.title,
    required this.subTitle,
  }) : super(key: key);

  final BuildContext context;
  final String imageUrl, title, subTitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(3.86 * SizeConfig.widthMultiplier),
      child: Row(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                maxLines: 2,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              SizedBox(
                height: 1.12 * SizeConfig.heightMultiplier,
              ),
              Text(subTitle, style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
          SizedBox(
            //20
            width: 4.83 * SizeConfig.widthMultiplier,
          ),
          Container(
            alignment: Alignment.centerRight,
            width: 24.15 * SizeConfig.widthMultiplier,
            height: 11.16 * SizeConfig.heightMultiplier,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  imageUrl,
                ),
                fit: BoxFit.cover,
              ),
              borderRadius:
                  BorderRadius.circular(2.23 * SizeConfig.heightMultiplier),
            ),
          ),
        ],
      ),
    );
  }
}
