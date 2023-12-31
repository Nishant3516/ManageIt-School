import 'package:manageit_school/screens/change_password.dart';
import 'package:manageit_school/screens/date_sheet.dart';
import 'package:manageit_school/screens/leave_application.dart';
import 'package:manageit_school/screens/onboarding.dart';
import 'package:manageit_school/screens/result.dart';
import 'package:manageit_school/screens/school_gallery.dart';
import 'package:manageit_school/screens/school_holiday.dart';
import 'package:manageit_school/screens/time_table.dart';

class Constants {
  static const String image = 'assets/images';
  static const String icon = 'assets/icons';
  static const String baseUrl = 'https://candeylabs.com/';
  static const String token =
      "eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJuaXNoYW50LnNzaWsiLCJhdXRoIjoiUk9MRV9BRE1JTixST0xFX1NDSE9PTF9BRE1JTixST0xFX1NDSE9PTF9TVFVERU5ULFJPTEVfU0NIT09MX1RFQUNIRVIsUk9MRV9VU0VSIiwiZXhwIjoxNzA2Mjg5MjkxfQ.4uW4knnhC0mMdAzZsJteprfL76EanqFSvhaYKD3mYuE4Cax8onTV8EtGWYDuBguOgsX_fh0I_S6TjsC9MyLrdA";

  List<List<dynamic>> dashboardMenu = [
    // ['assets/icons/ic_quiz.png', 'Play Quiz', PlayQuiz()],
    // ['assets/icons/ic_assignment.png', 'Assignment', AssignmentScreen()],
    ['assets/icons/ic_holiday.png', 'School Holiday', const SchoolHoliday()],
    ['assets/icons/ic_calendra.png', 'Time table', const TimeTableScreen()],
    ['assets/icons/ic_results.png', 'Result', const ResultScreen()],
    ['assets/icons/ic_date_sheet.png', 'Date Sheet', const DateSheetScreen()],
    // ['assets/icons/ic_doubts.png', 'Ask Doubts', AskDoubtScreen()],
    [
      'assets/icons/ic_gallery.png',
      'School Gallery',
      const SchoolGalleryScreen()
    ],
    [
      'assets/icons/ic_leave.png',
      'Leave Application',
      const LeaveApplicationScreen()
    ],
    ['assets/icons/ic_password.png', 'Reset Password', ChangePasswordScreen()],
    // ['assets/icons/ic_event.png', 'Events', EventsScreen()],
    ['assets/icons/ic_logout.png', 'Logout', const OnboardingScreen()],
  ];
}
