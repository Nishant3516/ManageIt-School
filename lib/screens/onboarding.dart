import 'package:flutter/material.dart';
import 'package:manageit_school/globalWidgets/individual_button.dart';
import 'package:manageit_school/globalWidgets/navigator_widget.dart';
import 'package:manageit_school/globalWidgets/y_margin.dart';
import 'package:manageit_school/screens/login.dart';
import 'package:manageit_school/widgets/onboarding_widget.dart';

class OnboardingScreen extends StatefulWidget {
  static const routeName = 'OnboardingScreen';
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int currentIndex = 0;
  PageController? _controller;
  static const _kDuration = Duration(microseconds: 1);
  static const _kCurve = Curves.linear;
  nextFunction() {
    _controller!.nextPage(duration: _kDuration, curve: _kCurve);
  }

  final List<List<String>> screenvalues = [
    [
      'assets/images/onboarding1.png',
      'Getting Started',
      'Welcome to Manage!t School 🏫\nUnlock the potential of seamless school management. Experience simplicity and efficiency at your fingertips.'
    ],
    [
      'assets/images/onboarding2.png',
      'Explore Features',
      'Discover a suite of powerful features for school administrators, teachers, students, and parents! 🚀 Streamline tasks and enhance collaboration.'
    ],
    [
      'assets/images/onboarding3.png',
      'Connect with Your School',
      'Join the Manage!t School community! 🌐 Stay connected with teachers, students, and parents. Engage in effective communication and collaboration.'
    ],
  ];

  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = screenvalues
        .map((value) => OnboardingWidget(
            bodyText: value[2], headingText: value[1], imageUrl: value[0]))
        .toList();

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.92,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: NotificationListener<OverscrollIndicatorNotification>(
                    onNotification:
                        (OverscrollIndicatorNotification notification) {
                      if (notification.leading) {
                        notification.paintOffset;
                      }
                      return false;
                    },
                    child: Stack(alignment: Alignment.center, children: [
                      Positioned(
                        child: PageView.builder(
                          controller: _controller,
                          physics: const ClampingScrollPhysics(),
                          itemCount: screens.length,
                          onPageChanged: (int index) {
                            setState(() {
                              currentIndex = index;
                            });
                          },
                          itemBuilder: (context, index) {
                            return Container(
                              child: screens[index],
                            );
                          },
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            screens.length,
                            (index) => buildDot(index, context),
                          ),
                        ),
                      ),
                    ]),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: SizedBox(
                    child: Column(
                      children: [
                        const YMargin(),
                        IndividualButton(
                          buttonText: 'Join',
                          buttonFunction: () {
                            NavigatorWidget().screenReplacement(
                                context, const LoginScreen());
                          },
                          borderColor: Colors.white,
                          backgroundColor: Colors.black,
                        ),
                        const YMargin(height: 20),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container buildDot(int index, BuildContext context) {
    return Container(
      height: currentIndex == index ? 9 : 7,
      width: currentIndex == index ? 9 : 7,
      margin: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(13),
          color: currentIndex == index ? Colors.blue : Colors.white),
    );
  }
}
