// ignore_for_file: must_be_immutable, library_private_types_in_public_api
import 'package:flutter/material.dart';
import 'package:holbegram/screens/login_screen.dart';
import 'package:holbegram/screens/upload_image_screen.dart';

class SignUp extends StatefulWidget {
  final TextEditingController emailController;
  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final TextEditingController passwordConfirmController;
  bool passwordVisible;

  SignUp({
    super.key,
    required this.emailController,
    required this.usernameController,
    required this.passwordController,
    required this.passwordConfirmController,
    this.passwordVisible = true,
  });

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  void initState() {
    super.initState();
    widget.passwordVisible;
  }

  @override
  void dispose() {
    widget.emailController.dispose();
    widget.usernameController.dispose();
    widget.passwordController.dispose();
    widget.passwordConfirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: widget.emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                hintText: 'Email',
              ),
            ),
            TextField(
              controller: widget.usernameController,
              decoration: const InputDecoration(
                hintText: 'Username',
              ),
            ),
            TextField(
              controller: widget.passwordController,
              obscureText: widget.passwordVisible,
              decoration: InputDecoration(
                hintText: 'Password',
                suffixIcon: IconButton(
                  icon: Icon(
                    widget.passwordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      widget.passwordVisible = !widget.passwordVisible;
                    });
                  },
                ),
              ),
            ),
            TextField(
              controller: widget.passwordConfirmController,
              obscureText: widget.passwordVisible,
              decoration: const InputDecoration(
                hintText: 'Confirm Password',
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Navegar a la página AddPicture pasando los datos de registro
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddPicture(
                      email: widget.emailController.text,
                      password: widget.passwordController.text,
                      username: widget.usernameController.text,
                    ),
                  ),
                );
              },
              child: const Text('Sign Up'),
            ),
            TextButton(
              onPressed: () {
                // Navigate back to Login Page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(
                      emailController: widget.emailController,
                      passwordController: widget.passwordController,
                      passwordVisible: widget.passwordVisible,
                    ),
                  ),
                );
              },
              child: const Text('Log in'),
            ),
          ],
        ),
      ),
    );
  }
}
