import 'package:flutter/material.dart';
import 'package:manageit_school/globalWidgets/global_widgets.dart';

class OnboardingWidget extends StatelessWidget {
  final String imageUrl;
  final String headingText;
  final String bodyText;
  const OnboardingWidget({
    super.key,
    required this.bodyText,
    required this.headingText,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            imageUrl,
            height: MediaQuery.sizeOf(context).height * 0.35,
          ),
          const YMargin(),
          Text(
            headingText,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const YMargin(height: 20),
          Text(
            bodyText,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.white,
            ),
          ),
          const YMargin(height: 20),
        ],
      ),
    );
  }
}
