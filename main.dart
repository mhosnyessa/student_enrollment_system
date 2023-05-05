import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gui_db/user_repository.dart';
import './home_screen/view/home_screen.dart';
import './login_signup_screen/view/login_signup_screen.dart';
import './program_detail_screen/view/program_detail_screen.dart';
import './application_status_screen/view/application_status_screen.dart';
import './schedule_screen/view/schedule_screen.dart';
import './payment_screen/view/payment_screen.dart';
import './profile_screen/view/profile_screen.dart';
import 'authentication_repository.dart';
import 'login_signup_screen/bloc/login_signup_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthenticationRepository authenticationRepository =
        AuthenticationRepository();

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthenticationRepository>.value(
            value: authenticationRepository),
        RepositoryProvider<UserRepository>(
          create: (context) =>
              // UserRepository(apiBaseUrl: 'your_api_base_url_here'),
              UserRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => LoginSignupBloc(
                authenticationRepository: authenticationRepository,
                userRepository: context.read<UserRepository>()),
          ),
        ],
        child: const MaterialMe(),
        // child: MaterialApp(
        //   home: Scaffold(
        //     body: Center(
        //       child: GridScreen(),
        //     ),
        //   ),
        // ),
      ),
    );
  }
}

class GridScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final squareSize = screenWidth / 20;

    return CustomPaint(
      painter: MyPainter(squareSize: squareSize),
      size: Size(double.infinity, double.infinity),
    );
  }
}

class MyPainter extends CustomPainter {
  late int rows = 900;
  late int cols = 900;
  final double squareSize;

  MyPainter({required this.squareSize});

  void drawSquare(Canvas canvas, int row, int col) {
    final x = col * squareSize;
    final y = row * squareSize;
    final squareRect = Rect.fromLTWH(x, y, squareSize, squareSize);
    final squarePaint = Paint()..color = Colors.green; // Green fill color
    final strokePaint = Paint()
      ..color = Colors.yellow // Yellow stroke color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4; // Stroke width of 4

    canvas.drawRect(squareRect, squarePaint);
    canvas.drawRect(squareRect, strokePaint);
  }

  @override
  void paint(Canvas canvas, Size size) {
    for (int row = 0; row < rows; row++) {
      for (int col = 0; col < cols; col++) {
        drawSquare(canvas, row, col);
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class MaterialMe extends StatelessWidget {
  const MaterialMe({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Your App Name',
      initialRoute: '/home',
      routes: {
        '/home': (context) => HomeScreen(),
        // TODO: laterr!
        '/login_signup': (context) => LoginSignupScreen(),
        '/program_detail': (context) => const ProgramDetailScreen(),
        '/application_status': (context) => const ApplicationStatusScreen(),
        '/schedule': (context) => const ScheduleScreen(),
        // '/payment': (context) => PaymentScreen(),
        // '/profile': (context) => ProfileScreen(),
      },
    );
  }
}
