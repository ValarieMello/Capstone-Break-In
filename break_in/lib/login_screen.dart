//This is the login page

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({ super.key, required this.title });

  final String title;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String _exception = '';

  //function for logging us in
  //added in the debugging from a chatgpt suggestion. helped me find the error with firebase.
  Future<void> _login() async {
  if (_formKey.currentState!.validate()) {
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    print('🧪 Trying to login: $email');

    try {
      final userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      print('✅ Login success! ${userCredential.user?.email}');

      //if the login is succeful take the user to the homepage
      if (mounted) {
        context.go('/home');
      }

    } on FirebaseAuthException catch (e) {
      print('❌ FirebaseAuthException: ${e.code} — ${e.message}');

      String errorMessage = 'Authentication error: ';
      if (e.code == 'user-not-found') {
        errorMessage += 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        errorMessage += 'Wrong password.';
      } else if (e.code == 'invalid-email') {
        errorMessage += 'Invalid email format.';
      } else {
        errorMessage += e.message ?? 'Unknown error';
      }

      setState(() {
        _exception = errorMessage;
      });
    } catch (e) {
      print('🚨 Unexpected error: $e');
      setState(() {
        _exception = 'Unexpected error: $e';
      });
    }
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //app bar holds the title
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
        IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/startscreen'),
            ),
          ],
      ),
      //Main Body of our App
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  _exception.isEmpty
                  ? const SizedBox.shrink()
                  : Text(
                    _exception,
                    style: const TextStyle(color: Color.fromARGB(255, 119, 0, 194)),
                  ),
                  //take in email info
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email *',
                      icon: Icon(Icons.person),
                    ),
                    validator: (value) {
                      if(value == null || value.isEmpty) {
                        return 'Please enter your email address';
                      }
                      return null;
                    }
                  ),
                  //take in password
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                    decoration: const InputDecoration(
                      labelText: 'Password *',
                      icon: Icon(Icons.password),
                    ),
                    validator: (value) {
                      if(value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    }
                  ),
                  //login button
                  ElevatedButton(
                    onPressed: _login,
                    child: const Text('Login'),
                  )
                ]
              )
            )
          ]
        )
      )
    );
  }
}
