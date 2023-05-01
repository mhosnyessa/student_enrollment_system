import 'package:flutter/material.dart';
import './home_screen/view/home_screen.dart';
import './login_signup_screen/view/login_signup_screen.dart';
import './program_detail_screen/view/program_detail_screen.dart';
import './application_status_screen/view/application_status_screen.dart';
import './schedule_screen/view/schedule_screen.dart';
import './payment_screen/view/payment_screen.dart';
import './profile_screen/view/profile_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Your App Name',
      initialRoute: '/home',
      routes: {
        '/home': (context) => HomeScreen(),
        // TODO: laterr!
        '/login_signup': (context) => LoginSignupScreen(),
        '/program_detail': (context) => ProgramDetailScreen(),
        '/application_status': (context) => ApplicationStatusScreen(),
        '/schedule': (context) => ScheduleScreen(),
        '/payment': (context) => PaymentScreen(),
        '/profile': (context) => ProfileScreen(),
      },
    );
  }
}
