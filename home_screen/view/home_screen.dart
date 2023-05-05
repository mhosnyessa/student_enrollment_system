import 'package:flutter/material.dart';
import 'package:gui_db/program_detail_screen/view/program_detail_screen.dart';
import 'package:gui_db/application_status_screen/view/application_status_screen.dart';
import 'package:gui_db/schedule_screen/view/schedule_screen.dart';
import 'package:gui_db/payment_screen/view/payment_screen.dart';
import 'package:gui_db/profile_screen/view/profile_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your App Name'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.max,
        children: [
          RaisedButton(
            child: Text('View Programs'),
            onPressed: () {
              Navigator.pushNamed(context, '/program_detail');
            },
          ),
          RaisedButton(
            child: Text('Application Status'),
            onPressed: () {
              Navigator.pushNamed(context, '/application_status');
            },
          ),
          RaisedButton(
            child: Text('Schedule'),
            onPressed: () {
              Navigator.pushNamed(context, '/schedule');
            },
          ),
          RaisedButton(
            child: Text('Payment'),
            onPressed: () {
              Navigator.pushNamed(context, '/payment');
            },
          ),
          RaisedButton(
            child: Text('Profile'),
            onPressed: () {
              Navigator.pushNamed(context, '/profile');
            },
          ),
        ],
      ),
    );
  }
}
