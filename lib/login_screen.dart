import 'package:flutter/material.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  _login() {
    if (_formKey.currentState?.validate() ?? false) {
      // Simulate successful login
      String username = _usernameController.text;
      String password = _passwordController.text;
   //   print('Username: $username, Password: $password');

      // Navigate to the home page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                key: const Key('usernameField'),
                controller: _usernameController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your username';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  labelText: 'Username',
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                key: const Key('passwordField'),
                controller: _passwordController,
                validator: (value) {
                  final passReg = RegExp(r'^(?=.*[a-z])(?=.*\d)[a-z\d]{8,}$');
                  if (value!.isEmpty) {
                    return "Enter The Password";
                  }
                  if (!passReg.hasMatch(value)) {
                    return "Enter Valid Password,at least 8 characters";
                  }
                  return null;
                },
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                key: const Key('loginButton'),
                onPressed: _login,
                child: const Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
