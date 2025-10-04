import 'package:break_in/home_screen.dart';
import 'package:break_in/starter_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:go_router/go_router.dart';

import 'firebase_options.dart';
import 'starter_screen.dart';
import 'home_screen.dart';
import 'login_screen.dart';
import 'register_screen.dart';
import 'create_profile.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const BreakInApp());
}

class BreakInApp extends StatelessWidget {
  const BreakInApp({super.key});

  @override
  Widget build(BuildContext context) {
    final GoRouter _router = GoRouter(
      initialLocation: '/startscreen', //set the default to the start screen
      routes: [
        GoRoute(
          path: '/home',
          builder: (context, state) => const HomePage(),
        ),
        GoRoute(
          path: '/startscreen',
          builder: (context, state) => const StartScreen(),
        ),
        GoRoute(
          path: '/login',
          builder: (context, state) => const LoginPage(title: 'Login',),
        ),
        GoRoute(
          path: '/register',
          builder: (context, state) => const CreateUser(title: 'Create User',),
        ),
        GoRoute(
          path: '/createprofile',
          builder: (context, state) => const CreateProfile(),
        ),
      ],
    );

    return MaterialApp.router(
      title: 'Break>In',
      theme: ThemeData(primarySwatch: Colors.indigo),
      routerConfig: _router,
    );
  }
}
