import 'package:get/get.dart';
import 'package:school_app/chats/chat.dart';
import 'package:school_app/screens/authentication/role_and_forgot/forgot.dart';
import 'package:school_app/screens/authentication/role_and_forgot/guestmode.dart';
import 'package:school_app/screens/authentication/student_auth/login.dart';
import 'package:school_app/screens/authentication/student_auth/signup.dart';
import 'package:school_app/screens/authentication/teacher_auth/teacher_signin.dart';
import 'package:school_app/screens/authentication/teacher_auth/teacher_signup..dart';
import 'package:school_app/screens/dashboards/student/pages/resultCard.dart';
import 'package:school_app/screens/dashboards/student/pages/studentExamination.dart';
import 'package:school_app/screens/dashboards/student/pages/studentTimetable.dart';
import 'package:school_app/screens/dashboards/student/pages/calendar.dart';
import 'package:school_app/screens/dashboards/student/pages/fees.dart';
import 'package:school_app/screens/dashboards/student/pages/homework.dart';
import 'package:school_app/screens/dashboards/student/pages/noticeboard.dart';
import 'package:school_app/screens/dashboards/student/pages/notification.dart';
import 'package:school_app/screens/dashboards/student/pages/profile.dart';
import 'package:school_app/screens/dashboards/student/pages/reportcard.dart';
import 'package:school_app/screens/dashboards/student/pages/student_syllabus.dart';
import 'package:school_app/screens/dashboards/student/pages/yearAttandence.dart';
import 'package:school_app/screens/dashboards/student/student_dashboard.dart';
import 'package:school_app/screens/dashboards/teacher/Pages/attendance/teacher_attendace.dart';
import 'package:school_app/screens/dashboards/teacher/Pages/attendance/teacher_listattendance.dart';
import 'package:school_app/screens/dashboards/teacher/Pages/homework/homework_page.dart';
import 'package:school_app/screens/dashboards/teacher/Pages/examination/teacherExamination.dart';
import 'package:school_app/screens/dashboards/teacher/Pages/syllabus/teacher_syllabus.dart';
import 'package:school_app/screens/dashboards/teacher/Pages/timetable/teacher_timetable.dart';
import 'package:school_app/screens/dashboards/teacher/teacher_dashboard.dart';
import 'package:school_app/screens/dashboards/teacher/teacher_studentList.dart';
import 'package:school_app/screens/onboardingscreens/onboarding2.dart';
import 'package:school_app/screens/onboardingscreens/onboarding3.dart';
import 'package:school_app/screens/onboardingscreens/onboarding4.dart';
import 'package:school_app/screens/splashscreen/splash.dart';

class AppPages {
  static const initialRoute = '/splash_screen';

  static final pages = [
    //////////////////////Student Authentication
    GetPage(
      transition: Transition.rightToLeft,
      name: '/student_signUp',
      page: () => const SignUpPage(),
    ),
    GetPage(
      transition: Transition.rightToLeft,
      name: '/student_login',
      page: () => const LoginPage(),
    ),
    //////////////////////Teacher Authentication
    GetPage(
      transition: Transition.rightToLeft,
      name: '/teacher_signUp',
      page: () => const TeacherSignUp(),
    ),
    GetPage(
      transition: Transition.rightToLeft,
      name: '/teacher_login',
      page: () => const TeacherLogin(),
    ),
    GetPage(
      transition: Transition.rightToLeft,
      name: '/forgotPage',
      page: () => const ForgotPasswordPage(),
    ),
    //////////////////////Student Pages
    GetPage(
      transition: Transition.rightToLeft,
      name: '/student_dashboard_screen',
      page: () => const DashBoardPage(),
    ),
    GetPage(
      transition: Transition.rightToLeft,
      name: '/Timetable',
      page: () => const Timetable(),
    ),
    GetPage(
      transition: Transition.rightToLeft,
      name: '/chatPage',
      page: () => const ChatScreen(),
    ),
    GetPage(
      transition: Transition.rightToLeft,
      name: '/homework',
      page: () => const HomeWorkPage(),
    ),
    GetPage(
      transition: Transition.rightToLeft,
      name: '/dailyDiaryPage',
      page: () => const DailyDiaryPage(),
    ),
    GetPage(
      transition: Transition.rightToLeft,
      name: '/reportCardPage',
      page: () => const ReportCardPage(),
    ),
    GetPage(
      transition: Transition.rightToLeft,
      name: '/result_card_page',
      page: () => const ResultCard(),
    ),
    GetPage(
      transition: Transition.rightToLeft,
      name: '/calenderPage',
      page: () => const CalendarPage(),
    ),
    GetPage(
      transition: Transition.rightToLeft,
      name: '/noticeBoard',
      page: () => const NoticeBoardPage(),
    ),
    GetPage(
      transition: Transition.rightToLeft,
      name: '/profilePage',
      page: () => const ProfilePage(),
    ),
    GetPage(
      transition: Transition.rightToLeft,
      name: '/student_syllabus_page',
      page: () => const StudentSyllabusPage(),
    ),
    GetPage(
      transition: Transition.rightToLeft,
      name: '/feePage',
      page: () => const SchoolFeesPage(),
    ),
    GetPage(
      transition: Transition.rightToLeft,
      name: '/guestmode_screen',
      page: () => const GuestMode(),
    ),
    GetPage(
      transition: Transition.rightToLeft,
      name: '/splash_screen',
      page: () => const SplashScreen(),
    ),

    GetPage(
      transition: Transition.rightToLeft,
      name: '/quiz_page',
      page: () => const QuizPage(),
    ),
    GetPage(
      transition: Transition.rightToLeft,
      name: '/student_attend',
      page: () => const YearAttandencePage(),
    ),
    ///////////////////////////// Teacher Pages
    GetPage(
      transition: Transition.rightToLeft,
      name: '/teacher_homework',
      page: () => const TeacherHomeWork(),
    ),
    GetPage(
      transition: Transition.rightToLeft,
      name: '/teacher_attendance',
      page: () => const TeacherTimetable(),
    ),
    GetPage(
      transition: Transition.rightToLeft,
      name: '/syllabus_page',
      page: () => const SyllabusPage(),
    ),

    GetPage(
      transition: Transition.rightToLeft,
      name: '/teacher_dashboard_screen',
      page: () => const TeacherDashboard(),
    ),
    GetPage(
      transition: Transition.rightToLeft,
      name: '/teacher_examination',
      page: () => const TeacherExaminationPage(),
    ),
    GetPage(
      transition: Transition.rightToLeft,
      name: '/teacher_listexamview',
      page: () => const TeacherExamView(),
    ),
    GetPage(
      transition: Transition.rightToLeft,
      name: '/teacher_listattendaceview',
      page: () => const TeacherAttendanceView(),
    ),
    GetPage(
      transition: Transition.rightToLeft,
      name: '/teacher_attend_page',
      page: () => const TeacherAttendance(),
    ),
    GetPage(
      transition: Transition.rightToLeft,
      name: '/onboarding_one',
      page: () => const OnBoardingPage(),
    ),
    GetPage(
      transition: Transition.rightToLeft,
      name: '/onboarding_two',
      page: () => const OnBoardingPage2(),
    ),
    GetPage(
        transition: Transition.rightToLeft,
        name: '/onboarding_three',
        page: () => const OnBoardingPage3()),
    GetPage(
      transition: Transition.rightToLeft,
      name: '/onboarding_four',
      page: () => const GuestMode(),
    ),

    /////////////// OnBoardingPages
  ];
}
