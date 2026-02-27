import 'package:flutter/material.dart';

class ResponsiveWrapper extends StatelessWidget {
  final Widget child;
  const ResponsiveWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: width > 1200
              ? 1100
              : width > 900
                  ? 900
                  : width,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: width > 900 ? 32 : 16,
          ),
          child: child,
        ),
      ),
    );
  }
}