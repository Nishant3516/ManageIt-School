import 'package:flutter/material.dart';
import 'package:manageit_school/globalWidgets/global_widgets.dart';

class DashBoardMenu extends StatelessWidget {
  final String iconImage;
  final String title;
  final Widget nextScreen;
  const DashBoardMenu({
    super.key,
    required this.iconImage,
    required this.title,
    required this.nextScreen,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        NavigatorWidget().screenReplacement(context, nextScreen);
      },
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 1, color: Colors.black)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              iconImage,
              height: 40,
              width: 40,
            ),
            Text(
              title,
              style: const TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
