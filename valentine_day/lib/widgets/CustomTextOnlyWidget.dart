import 'package:flutter/material.dart';
import '../utils/SizeConfig.dart';

class CustomTextOnlyWidget extends StatelessWidget {
  const CustomTextOnlyWidget({
    Key? key,
    required this.size,
    this.color,
    this.text,
    this.language,
  }) : super(key: key);

  final Size size;
  final Color? color;
  final String? text, language;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      height: size.height * 0.40,
      width: size.width * 0.40,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: theme.colorScheme.secondaryContainer.withOpacity(0.9),
        borderRadius: BorderRadius.circular(SizeConfig.height(11)),
      ),
      child: Container(
        height: size.height * 0.38,
        width: size.width * 0.38,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color ?? theme.colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(SizeConfig.height(10)),
        ),
        child: Padding(
          padding: EdgeInsets.all(SizeConfig.width(2)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: SizeConfig.height(10)),
              Text(
                language ?? '',
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onPrimary,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: SizeConfig.height(10)),
              Text(
                text ?? '',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onPrimary,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
