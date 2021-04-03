import 'package:flutter/material.dart';
import 'package:valentine_day/utils/SizeConfig.dart';

class CustomTextOnlyWidget extends StatelessWidget {
  const CustomTextOnlyWidget({
    Key key,
    @required this.size, this.color, this.text, this.ontap, this.language,
  }) : super(key: key);

  final Size size;
  final Color color;
  final String text,language;
  final Function ontap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
          child: Container(
        height: size.height * 0.40,
        width: size.width * 0.40,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.yellow[700],
          borderRadius: BorderRadius.circular(SizeConfig.height(11)),
        ),
        child: Container(
          height: size.height * 0.38,
          width: size.width * 0.38,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: color,
            borderRadius:
                BorderRadius.circular(SizeConfig.height(10)),
          ),
          child: Padding(
            padding: EdgeInsets.all(SizeConfig.width(2)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: SizeConfig.height(10)),
                 Text(
                    language,
                    style: Theme.of(context).textTheme.bodyText1.copyWith(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                
                SizedBox(height: SizeConfig.height(10)),
                Text(
                  text,
                  style: Theme.of(context).textTheme.bodyText1,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
      onTap: ontap,
    );
  }
}
