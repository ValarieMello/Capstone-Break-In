import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';

/*
how this page is going to work/look it is going to have a weekly schedule at the top
then it will show the whole day outlined
then the bottom bar will have a home, a giant plus, full calendar button

if you click on an event inside the whole day it will pop up and show you all the details of that event

if you hit that big plus it will have a box pop up with two options
1: add a connection link to add in info
2: edit your schedule link to page to edit your schedule

If you click the house it will reset to the current day

if you click the full calendar it will link you to the full calendar for the "month"
*/


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

  //added in the debugging from a chatgpt suggestion. helped me find the error.
  Future<void> _login() async {
  if (_formKey.currentState!.validate()) {
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    print('🧪 Trying to login: $email');

    try {
      final userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      print('✅ Login success! ${userCredential.user?.email}');

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
                    style: const TextStyle(color: Colors.red),
                  ),
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
