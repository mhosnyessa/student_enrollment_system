import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/login_signup_bloc.dart';
import '../bloc/login_signup_event.dart';
import '../bloc/login_signup_state.dart';

class LoginSignupScreen extends StatefulWidget {
  @override
  _LoginSignupScreenState createState() => _LoginSignupScreenState();
}

class _LoginSignupScreenState extends State<LoginSignupScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoginForm = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<LoginSignupBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(_isLoginForm ? 'Login' : 'Sign up'),
      ),
      body: BlocBuilder<LoginSignupBloc, LoginSignupState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    if (_isLoginForm) {
                      bloc.add(LoginButtonPressed(
                        email: _emailController.text,
                        password: _passwordController.text,
                      ));
                    } else {
                      bloc.add(SignupButtonPressed(
                        email: _emailController.text,
                        password: _passwordController.text,
                      ));
                    }
                  },
                  child: Text(_isLoginForm ? 'Login' : 'Sign up'),
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _isLoginForm = !_isLoginForm;
                    });
                  },
                  child: Text(
                    _isLoginForm
                        ? 'Create an account'
                        : 'Have an account? Sign in',
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
