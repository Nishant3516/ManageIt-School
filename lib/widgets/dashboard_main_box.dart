import 'package:flutter/material.dart';
import 'package:manageit_school/globalWidgets/global_widgets.dart';

class DashBoardMainBox extends StatelessWidget {
  final String iconImage;
  final String title;
  final String? value;
  final Widget nextScreen;
  const DashBoardMainBox({
    super.key,
    required this.iconImage,
    required this.title,
    required this.nextScreen,
    this.value,
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
            color: Colors.white,
            border: Border.all(width: 1, color: Colors.black)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              iconImage,
              height: 60,
              width: 60,
            ),
            if (value != null)
              Text(
                value!,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                ),
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontSize: 16),
                ),
                const Icon(Icons.arrow_forward_outlined),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
