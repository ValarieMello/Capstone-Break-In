//Screen that shows on boot up. 
//Navigates to either the login page or the register page

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({ super.key });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Break>In Starter Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => context.go('/register'),
              child: const Text('Create Account'),
            ),
            ElevatedButton(
              onPressed: () => context.go('/login'),
              child: const Text('Login'),
            )
          ]
        )
      )
    );
  }
}
