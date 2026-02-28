import 'package:flutter/material.dart';
import '../utils/SizeConfig.dart';

class MessageWidget3 extends StatelessWidget {
  const MessageWidget3({
    Key? key,
    required this.headLine,
    required this.subTitle,
    required this.imagePath,
    required this.color,
    required this.callback,
  }) : super(key: key);

  final String headLine;
  final String subTitle;
  final String imagePath;
  final Color color;
  final VoidCallback callback; // Notice the variable type

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: callback ,
      child: Padding(
        padding: EdgeInsets.only(right: SizeConfig.width(10.0)),
        child: Container(
          width: SizeConfig.width(180),
          height: SizeConfig.height(170),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.all(Radius.circular(SizeConfig.width(5))),
            boxShadow: [
              BoxShadow(
                offset: const Offset(4, 4),
                blurRadius: 5,
                color: Colors.blue.shade900.withOpacity(0.50),
              )
            ],
          ),
          child: Padding(
            padding: EdgeInsets.all(SizeConfig.width(10.0)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Item2
                Container(
                  height: SizeConfig.height(60),
                  width: SizeConfig.width(60),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        imagePath,
                      ),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
    
                // Item1 with two Text
                SizedBox(
                  width: SizeConfig.width(180),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        headLine,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        subTitle,
                        maxLines: 3,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
