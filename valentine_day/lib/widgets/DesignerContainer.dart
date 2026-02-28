import 'package:flutter/material.dart';
import '../utils/SizeConfig.dart';

class DesignerContainer extends StatelessWidget {
  const DesignerContainer({
    Key? key,
    required this.child,
    required this.isLeft,
  }) : super(key: key);

  final Widget child;
  final bool isLeft;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final borderRadiusValue = Radius.circular(SizeConfig.height(20));

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: isLeft
            ? theme.colorScheme.secondaryContainer.withOpacity(0.9)
            : theme.colorScheme.primaryContainer.withOpacity(0.9),
        borderRadius: BorderRadius.only(
          bottomLeft: isLeft ? borderRadiusValue : Radius.zero,
          bottomRight: isLeft ? Radius.zero : borderRadiusValue,
        ),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 2),
            blurRadius: 5,
            color: theme.shadowColor.withOpacity(0.1),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: SizeConfig.height(8),
          horizontal: SizeConfig.width(6),
        ),
        child: child,
      ),
    );
  }
}
