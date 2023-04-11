import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';

class BadgeWidget extends StatelessWidget {
  final String count;
  final Widget child;
  const BadgeWidget(this.count, this.child, {super.key});

  @override
  Widget build(BuildContext context) {
    return badges.Badge(
      position: badges.BadgePosition.topEnd(top: 2, end: 2),
      badgeAnimation: const badges.BadgeAnimation.rotation(
        animationDuration: Duration(milliseconds: 500),
        loopAnimation: false,
      ),
      badgeContent: Text(
        count,
        style: const TextStyle(color: Colors.white),
      ),
      //color: Colors.white,

      badgeStyle: badges.BadgeStyle(
        badgeColor: Theme.of(context).colorScheme.secondary,
      ),
      child: child,
    );
  }
}
