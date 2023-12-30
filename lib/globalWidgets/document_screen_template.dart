import 'package:flutter/material.dart';

class DocumentScreenTemplate extends StatelessWidget {
  final Widget innerWidget;
  final Widget? bottomWidget;
  final bool isBottomWidgetNeeded;
  const DocumentScreenTemplate({
    super.key,
    required this.innerWidget,
    required this.isBottomWidgetNeeded,
    this.bottomWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          innerWidget,
          if (isBottomWidgetNeeded) bottomWidget!,
        ],
      ),
    );
  }
}
