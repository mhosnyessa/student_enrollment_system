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
  final _nameController = TextEditingController();
  bool _isLoginForm = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<LoginSignupBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(_isLoginForm ? 'Login' : 'Sign up'),
      ),
      body: BlocConsumer<LoginSignupBloc, LoginSignupState>(
        listener: (ctx, state) {
          print("current state: $state");
          if (state is LoginSignupSuccess) {
            Navigator.of(context).pushReplacementNamed('/home');
          } else if (state is LoginSignupFailure) {
            SnackBar s = SnackBar(
              content: Text(state.error),
            );
            ScaffoldMessenger.of(context).showSnackBar(s);
          }else if (state is LoginSignupSuccess) {
            SnackBar s = SnackBar(
              content: Text("logged in successfully!"),
            );
            ScaffoldMessenger.of(context).showSnackBar(s);
          }

        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _isLoginForm
                    ? SizedBox()
                    : TextField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          labelText: 'Name',
                        ),
                        keyboardType: TextInputType.emailAddress,
                  onChanged: (_){ setState(() { }); },
                      ),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                  ),
                  onChanged: (_){ setState(() { }); },
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                  ),
                  onChanged: (_){ setState(() { }); },
                  obscureText: true,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _emailController.text == '' || _passwordController.text == '' ? null: () {
                    if (_isLoginForm) {
                      bloc.add(LoginButtonPressed(
                        email: _emailController.text,
                        // email: "john.smith@example.com",
                        password: _passwordController.text,
                        // password: "password123",
                      ));
                    } else {
                      bloc.add(SignupButtonPressed(
                        name: _nameController.text,
                        email: _emailController.text,
                        password: _passwordController.text,
                      ));
                    }
                  },
                  child: state != LoginSignupLoading()
                      ? Text(_isLoginForm ? 'Login' : 'Sign up')
                      : const CircularProgressIndicator(
                          color: Colors.green,
                        ),
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
