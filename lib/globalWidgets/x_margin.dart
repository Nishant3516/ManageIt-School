import 'package:flutter/material.dart';

class XMargin extends StatelessWidget {
  final double? width;

  const XMargin({
    super.key,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: width ?? 10);
  }
}
