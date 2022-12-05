import 'package:flutter/material.dart';

class OrientationLayout extends StatelessWidget {
  final Widget portrait;
  final Widget landspace;

  const OrientationLayout({
    Key? key,
    required this.portrait,
    required this.landspace,
  }) : super(key: key);

  static Orientation isPortrait(BuildContext context) => Orientation.portrait;

  static Orientation isLandscape(BuildContext context) => Orientation.landscape;

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        if (orientation == Orientation.portrait) {
          return portrait;
        } else {
          return landspace;
        }
      },
    );
  }
}
